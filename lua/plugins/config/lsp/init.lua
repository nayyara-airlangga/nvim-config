local lspconfig_ok, _ = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

require("plugins.config.lsp.installer")
require("plugins.config.lsp.handlers").setup()
require("plugins.config.lsp.null-ls")
require("plugins.config.lsp.linters")
require("plugins.config.lsp.formatters")
