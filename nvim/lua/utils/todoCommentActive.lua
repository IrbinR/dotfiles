local activeTodoComment = function()
	-- Verificar que telescope se pueda cargar
	local telescope_ok, telescope = pcall(require, "telescope")
	if not telescope_ok then
		vim.notify("Telescope no está disponible", vim.log.levels.ERROR)
		return
	end

	-- Verificar que todo-comments se pueda cargar
	local todo_ok = pcall(require, "todo-comments")
	if not todo_ok then
		vim.notify("todo-comments no está disponible", vim.log.levels.ERROR)
		return
	end

	-- Ejecutar el comando
	vim.cmd("TodoTelescope")
end

return activeTodoComment
