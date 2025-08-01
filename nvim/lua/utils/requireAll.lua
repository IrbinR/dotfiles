local importAll = function(directory)
	-- print("Ejecutando importAll para:", directory)
	local path = vim.fn.stdpath("config") .. "/lua/" .. directory:gsub("%.", "/")
	-- print("Buscando en ruta:", path)
	local scan = vim.loop.fs_scandir(path)
	if not scan then
		print("ERROR: No se pudo escanear el directorio")
		return
	end

	while true do
		local name, type = vim.loop.fs_scandir_next(scan)
		if not name then
			break
		end

		--print("Archivo encontrado:", name, "tipo:", type) -- NUEVO
		if type == "file" and name:match("%.lua$") and name ~= "init.lua" then
			local module = directory .. "." .. name:gsub("%.lua$", "")
			-- print("Importando modulo", module)
			require(module)
		end
	end
end

return importAll
