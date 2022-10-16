local M = {}

M.os_type = function()
	return package.config:sub(1, 1) == "\\" and "win" or "unix"
end

M.get_shell = function()
	if M.os_type() == "win" then
		return "pwsh" or "powershell"
	end

	return "zsh" or "bash"
end

M.config_path = function()
	if M.os_type() == "win" then
		return "~/AppData/Local/nvim"
	end

	return "~/.config/nvim"
end

return M
