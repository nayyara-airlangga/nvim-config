local colorscheme = "onedark"

local colorscheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not colorscheme_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
