vim.api.nvim_create_user_command("RunSplit", function(option)
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })

	if #buffers <= 1 then
		vim.notify("No hay más buffers abiertos para mostrar", vim.log.levels.WARN)
		return
	end

	-- Buffers ya visibles en alguna ventana
	local visible_buffers = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		visible_buffers[buf] = true
	end

	-- Buscar un buffer distinto y no visible
	local target_buf = nil
	for _, buf in ipairs(buffers) do
		if buf.bufnr ~= current_buf and not visible_buffers[buf.bufnr] then
			target_buf = buf.bufnr
			break
		end
	end

	-- Si no hay buffers nuevos, no abrir split
	if not target_buf then
		vim.notify("No hay buffers nuevos para mostrar", vim.log.levels.WARN)
		return
	end

    local layout = vim.fn.winlayout()
	if option.args == "h" then
			vim.cmd("split")
	elseif option.args == "v" then
			vim.cmd("vsplit")
	else
		vim.notify("Usa 'h' para horizontal o 'v' para vertical", vim.log.levels.ERROR)
		return
	end
	vim.cmd("wincmd p")
	vim.cmd("buffer " .. target_buf)
end, { desc = "Split archivo y cambiar buffer anterior", nargs = 1 })
