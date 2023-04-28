local status_ok, sonarlint = pcall(require, "sonarlint")
if not status_ok then
	return
end

local os_type = require("utils.sys").os_type
local sonarlint_path = os_type() == "win" and vim.fn.stdpath("data") .. "\\mason\\bin\\sonarlint-language-server.cmd"
	or vim.fn.stdpath("data") .. "/mason/bin/sonarlint-language-server.cmd"

sonarlint.setup({
	server = {
		cmd = {
			sonarlint_path,
			-- Ensure that sonarlint-language-server uses stdio channel
			"-stdio",
			"-analyzers",
			-- paths to the analyzers you need, using those for python and java in this example
			vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
			vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
		},
	},
	filetypes = {
		-- Tested and working
		"python",
		-- Requires nvim-jdtls, otherwise an error message will be printed
		"java",
	},
})
