local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugins.config.lsp.handlers").on_attach,
		capabilities = require("plugins.config.lsp.handlers").capabilities,
	}

	if server.name == "dartls" then
		local dartls_opts = require("plugins.config.lsp.settings.dartls")
		opts = vim.tbl_deep_extend("force", dartls_opts, opts)
	end

	if server.name == "jdtls" then
		local jdtls_opts = require("plugins.config.lsp.settings.jdtls")
		opts = vim.tbl_deep_extend("force", jdtls_opts, opts)
	end

	if server.name == "jsonls" then
		local jsonls_opts = require("plugins.config.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("plugins.config.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "html" then
		local html_opts = require("plugins.config.lsp.settings.html")
		opts = vim.tbl_deep_extend("force", html_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
