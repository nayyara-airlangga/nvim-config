local lspconfig_ok, _ = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

require("plugins.config.lsp.installer")
require("plugins.config.lsp.handlers").setup()
