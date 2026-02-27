local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

ls.add_snippets("all", {
    s("mainfunc", {
        t('func main() {'),
        i(1),
        t('}')
    }),
    s("deployment", {
        t('apiVersion: apps/v1'),
        t({'', 'kind: Deployment'}),
        t({'', 'metadata:'}),
        t({'', '  name: '}), i(1, 'NAME'),
        t({'', '  namespace: '}), i(2, 'NAMESPACE'),
        t({'', 'spec:'}),
        t({'', '  replicas: '}), i(3, '1'),
        t({'', '  selector:'}),
        t({'', '    matchLabels:'}),
        t({'', '      '}), i(4, 'KEY: VALUE'),
        t({'', '  template:'}),
        t({'', '    metadata:'}),
        t({'', '      labels:'}),
        t({'', '        '}), i(4, 'KEY: VALUE'),
        t({'', '    spec:'}),
        t({'', '      containers:'}),
        t({'', '      - name: '}), i(5, 'CONTAINER_NAME'),
        t({'', '        image: '}), i(6, 'IMAGE:TAG'),
        t({'', '        ports: []'}),
        t({'', '        volumeMounts: {}'}),
        t({'', '        resources: {}'})
    })
})
