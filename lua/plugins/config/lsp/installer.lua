local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

mason.setup()
mason_lspconfig.setup()

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).

mason_lspconfig.setup_handlers({
	function(server)
		local opts = {
			on_attach = require("plugins.config.lsp.handlers").on_attach,
			capabilities = require("plugins.config.lsp.handlers").capabilities,
		}

		if server == "dartls" then
			local dartls_opts = require("plugins.config.lsp.settings.dartls")
			opts = vim.tbl_deep_extend("force", dartls_opts, opts)
		end

		if server == "jsonls" then
			local jsonls_opts = require("plugins.config.lsp.settings.jsonls")
			opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
		end

		if server == "lua_ls" then
			local luals_opts = require("plugins.config.lsp.settings.lua_ls")
			opts = vim.tbl_deep_extend("force", luals_opts, opts)
		end

		if server == "html" then
			local html_opts = require("plugins.config.lsp.settings.html")
			opts = vim.tbl_deep_extend("force", html_opts, opts)
		end

		if server == "sonarlint-language-server" then
			local sonarlint_opts = require("plugins.config.lsp.settings.sonarlint")
			opts = vim.tbl_deep_extend("force", sonarlint_opts, opts)
		end

		if server ~= "jdtls" then
			-- This setup() function is exactly the same as lspconfig's setup function.
			-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			lspconfig[server].setup(opts)
		end
	end,
})
