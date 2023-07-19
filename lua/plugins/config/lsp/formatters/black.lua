local status_ok, black = pcall(require, "black")
if not status_ok then
	return
end

black.setup()
