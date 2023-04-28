-- Java Language Server configuration.
-- Locations:
-- 'nvim/ftplugin/java.lua'.
-- 'nvim/lang-servers/intellij-java-google-style.xml'

local jdtls_ok, _ = pcall(require, "jdtls")
if not jdtls_ok then
	vim.notify("JDTLS not found, install with `:LspInstall jdtls`")
	return
end

local os_type = require("utils.sys").os_type

local jdtls_path = os_type() == "win" and vim.fn.stdpath("data") .. "\\mason\\packages\\jdtls"
	or vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local config_path = os_type() == "win" and jdtls_path .. "\\config_win" or jdtls_path .. "/config_linux"
local plugins_path = os_type() == "win" and jdtls_path .. "\\plugins" or jdtls_path .. "/plugins"
local jar_path = os_type() == "win" and plugins_path .. "\\org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
	or plugins_path .. "/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
local lombok_path = os_type() == "win" and jdtls_path .. "\\lombok.jar" or "/lombok.jar"

local root_markers = { "gradlew", ".git", "mvnw", "build.gradle", "build.gradle.kts" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_root = os_type() == "win" and "\\site\\java\\workspace-root\\" or "/site/java/workspace-root/"
local workspace_dir = vim.fn.stdpath("data") .. workspace_root .. project_name
os.execute("mkdir " .. workspace_dir)

local handlers = require("plugins.config.lsp.handlers")

-- Main Config
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok_path,
		"-jar",
		jar_path,
		"-configuration",
		config_path,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			references = {
				includeDecompiledSources = true,
			},
		},
	},
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
