local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require('telescope.config').values
local entry_display = require("telescope.pickers.entry_display")
local make_entry = require("telescope.make_entry")

local function visit_yaml_node(node, name, yaml_path, result, file_path, bufnr, doc_num)
    local key = ''
    if node:type() == "block_mapping_pair" then
        local field_key = node:field("key")[1]
        key = vim.treesitter.get_node_text(field_key, bufnr)
    end

    if key ~= nil and string.len(key) > 0 then
        table.insert(yaml_path, key)
        local line, col = node:start()
        local path_text = table.concat(yaml_path, '.')
        local display_text = doc_num and string.format("[%d] %s", doc_num, path_text) or path_text
        table.insert(result, {
            lnum = line + 1,
            col = col + 1,
            bufnr = bufnr,
            filename = file_path,
            text = display_text,
        })
    end

    for node, name in node:iter_children() do
        visit_yaml_node(node, name, yaml_path, result, file_path, bufnr, doc_num)
    end

    if key ~= nil and string.len(key) > 0 then
        table.remove(yaml_path, table.maxn(yaml_path))
    end
end

local function gen_from_yaml_nodes(opts)
    local displayer = entry_display.create {
        separator = " │ ",
        items = {
            { width = 5 },
            { remaining = true },
        },
    }

    local make_display = function(entry)
        return displayer {
            { entry.lnum, "TelescopeResultsSpecialComment" },
            { entry.text, function() return {} end },
        }
    end

    return function(entry)
        return make_entry.set_default_entry_mt({
            ordinal = entry.text,
            display = make_display,
            filename = entry.filename,
            lnum = entry.lnum,
            text = entry.text,
            col = entry.col,
        }, opts)
    end
end

local yaml_symbols = function(opts)
    local yaml_path = {}
    local result = {}
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    local parser = vim.treesitter.get_parser(bufnr, 'yaml')
    if not parser then
        print("No treesitter parser for YAML")
        return
    end
    
    local tree = parser:parse()[1]
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    local root = tree:root()
    
    local doc_num = 0
    local has_multiple_docs = root:type() == "stream"
    
    -- Process all nodes
    for node, name in root:iter_children() do
        if node:type() == "document" then
            doc_num = doc_num + 1
            for child in node:iter_children() do
                visit_yaml_node(child, nil, yaml_path, result, file_path, bufnr, has_multiple_docs and doc_num or nil)
            end
        else
            visit_yaml_node(node, name, yaml_path, result, file_path, bufnr, nil)
        end
    end
    
    if #result == 0 then
        print("No YAML symbols found")
        return
    end

    pickers.new(opts, {
        prompt_title = "YAML symbols",
        finder = finders.new_table {
            results = result,
            entry_maker = opts.entry_maker or gen_from_yaml_nodes(opts),
        },
        sorter = conf.generic_sorter(opts),
        previewer = conf.grep_previewer(opts),
    }):find()
end
-- Add this to your telescope mappings
local function livegrep_refine(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local entries = {}
  
  -- Get all current results (filenames)
  for entry in picker.manager:iter() do
    entries[entry.filename] = true
  end
  
  local files = vim.tbl_keys(entries)
  actions.close(prompt_bufnr)
  
  -- Launch new livegrep on those files only
  builtin.live_grep({
    search_dirs = files,
  })
end

-- dynamic sizing for telescope based on the screen width
local function get_layout_config()
  local screen_width = vim.o.columns

  if screen_width > 200 then
    return {
      width = 160,
      height = 0.8,
      preview_width = 80,
    }
  else
    return {
      width = 0.9,
      height = 0.8,
      preview_width = 0.5,
    }
  end
end
local function live_grep_adaptive()
  builtin.live_grep({
    previewer = true,
    layout_config = get_layout_config(),
  })
end

local function find_files_adaptive()
  builtin.find_files({
    previewer = true,
    layout_config = get_layout_config(),
  })
end

local function live_grep_buffers()
  local buffers = vim.tbl_filter(function(bufnr)
    return vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr) ~= ""
  end, vim.api.nvim_list_bufs())
  
  local buffer_paths = vim.tbl_map(function(bufnr)
    return vim.api.nvim_buf_get_name(bufnr)
  end, buffers)
  
  if #buffer_paths == 0 then
    print("No file buffers open")
    return
  end
  
  builtin.live_grep({
    search_dirs = buffer_paths,
    prompt_title = "Live Grep (Buffers)",
  })
end

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            '.git/', 'node_modules/', '.npm', '*.py[co]', '__pycache__', '*.pdf', '*.zip',
            '*.tar.gz', '*.tar.bz2', '*.rar', '*.7z', '*.iso', '*.tmp', '*.exe', '*.dll',
            '*.obj', '*.o', '*.a', '*.lib', '*.so', '*.dmg', '*.jpg', '*.jpeg', '*.png',
            '*.gif', '*.bmp', '*.tiff', '*.ico', '.terraform/', '.terraform.*', '.venv',
            'My Drive/', 'Movies', 'Desktop', 'Library'
        },
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case',
            '--hidden', "--trim"
        },
        mappings = {
            i = {
                -- sends selected results to qfllist and opens a buffer for each of them
                -- this allows doing livegrep search over buffers (leader-bg)
                ["<C-o>"] = function(p_bufnr)
                    require("telescope.actions").send_selected_to_qflist(p_bufnr)
                    vim.cmd.cfdo("edit")
                    vim.cmd.cfirst()  -- jump to first item in qflist
                end,
                ["<M-o>"] = function(p_bufnr)  -- Alt-o for all results
                    require("telescope.actions").send_to_qflist(p_bufnr)
                    vim.cmd.cfdo("edit")
                    vim.cmd.cfirst()
                end,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<C-f>"] = require("telescope.actions").to_fuzzy_refine,
                ['<C-u>'] = livegrep_refine,  -- or any key you prefer
            },
        },
    },
    pickers = {
        live_grep = {
          theme = "ivy",
        },
        find_files = {
          theme = "ivy",
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})

require('telescope').load_extension('fzf')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>ff', find_files_adaptive, {})
--vim.keymap.set('n', '<leader>fg', live_grep_adaptive, {})
vim.keymap.set('n', '<leader>bg', live_grep_buffers)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ft', builtin.git_files, {})
vim.keymap.set('n', '<leader>fy', function()
  yaml_symbols(themes.get_ivy({}))
end, { desc = "YAML symbols" })
