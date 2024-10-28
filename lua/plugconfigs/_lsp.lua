local lspconfig = require('lspconfig') 
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp_capabilities.textDocument.completion.completionItem.snippetSupport = false

lspconfig.pyright.setup{
	capabilities = lsp_capabilities,
}
lspconfig.gopls.setup{
	capabilities = lsp_capabilities,
}
lspconfig.clangd.setup{
	capabilities = lsp_capabilities,
}
lspconfig.lua_ls.setup{
	capabilities = lsp_capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					'vim',
					'require'
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

vim.diagnostic.config({
    virtual_text = { prefix = "■", },
    signs = false,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = true,
  })


vim.keymap.set('n', ',e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', 'gS', vim.lsp.buf.type_definition, opts)
  end,
})

vim.cmd('highlight link LspDiagnosticsVirtualTextError Error')
