local systemThemes = vim.fn.getcompletion("", "color")

local M = {}

-- Configuración de persistencia (usando estrategia moderna)
local theme_file = vim.fn.stdpath("data") .. "/selected_colorscheme.txt"

-- Guardar tema en archivo (versión moderna)
M.save_colorscheme = function(theme_name)
	vim.fn.writefile({ theme_name }, theme_file)
	vim.g.current_theme = theme_name -- También guardar en variable de sesión
end

-- Cargar tema desde archivo (versión moderna)
M.load_colorscheme = function()
	if vim.fn.filereadable(theme_file) == 1 then
		local content = vim.fn.readfile(theme_file)
		if #content > 0 and content[1] ~= "" then
			return content[1]
		end
	end
	return nil -- Sin tema por defecto, que use el actual
end

-- Aplicar tema guardado
M.apply_saved_colorscheme = function()
	local saved_theme = M.load_colorscheme()
	if saved_theme and saved_theme ~= vim.g.colors_name then
		pcall(function()
			vim.cmd("colorscheme " .. saved_theme)
		end)
	end
end

M.active_colors_plugins = function()
	local theme = vim.g.colors_name or "habamax"

	local lualineConfig = require("config.customPlugins.lualine")

	local lualineSetConfig
	if theme == "tundra" then
		lualineSetConfig = lualineConfig.tundra()
	elseif theme:match("^onedark") or theme == "onelight" then
		lualineSetConfig = lualineConfig.onedark()
	elseif theme == "gruvbox" then
		lualineSetConfig = lualineConfig.gruvbox()
	elseif theme == "solarized" then
		lualineSetConfig = lualineConfig.solarized()
	else
		lualineSetConfig = lualineConfig.default()
	end

	require("lualine").setup(lualineSetConfig)
	vim.schedule(function()
		require("lualine").refresh({
			place = { "statusline", "tabline", "winbar" },
		})
	end)
end

M.colorscheme_picker = function()
	-- local current_theme = vim.g.colors_name or "habamax"

	local entries = {}
	for _, theme in ipairs(M.themes) do
		local icon = " "
		table.insert(entries, string.format("%s %s", icon, theme))
	end
	local FzfLua = require("fzf-lua")

	FzfLua.fzf_exec(entries, {
		prompt = " ",
		winopts = {
			height = 0.50,
			width = 0.40,
			title = "Theme Manager",
			title_pos = "center",
		},

		actions = {
			["default"] = function(selected, opts)
				if selected and #selected > 0 then
					local theme = selected[1]:gsub("^%s*", "")
					vim.cmd("colorscheme " .. theme)
				end
			end,
		},
	})
end

M.themes = {

	"tundra",
	"gruvbox",
	"onedark",
	"onedark_vivid",
	"onedark_dark",
	"onelight",
	"solarized",
	"monokai-pro-spectrum",
	"monokai-pro-ristretto",
	"monokai-pro-octagon",
	"monokai-pro-machine",
	"monokai-pro-light",
	"monokai-pro-default",
	"monokai-pro-classic",
	"monokai-pro",
	"catppuccin-macchiato",
	"catppuccin-frappe",
	"catppuccin-mocha",
	"catppuccin-latte",
	"catppuccin",
}

M.addThemes = function()
	for _, theme in ipairs(M.themes) do
		table.insert(systemThemes, theme)
	end
end

M.getUniqueThemes = function()
	local unique = {}
	local seen = {}

	for _, theme in ipairs(systemThemes) do
		if not seen[theme] then
			table.insert(unique, theme)
			seen[theme] = true
		end
	end

	return unique
end

-- Cargar tema guardado al iniciar
vim.g.current_theme = M.load_colorscheme()

-- Aplicar el tema guardado al iniciar (usando vim.schedule para mejor timing)
vim.schedule(function()
	M.apply_saved_colorscheme()
end)

-- Autocmd que guarda automáticamente cualquier cambio de tema
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local theme = vim.g.colors_name
		if theme then
			M.save_colorscheme(theme)
			M.active_colors_plugins()
		end
	end,
})

-- Respaldo: guardar tema al salir
vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	callback = function()
		if vim.g.current_theme then
			M.save_colorscheme(vim.g.current_theme)
		end
	end,
})

local first_run_file = vim.fn.stdpath("data") .. "/nvim_theme_initialized.txt"

if vim.fn.filereadable(first_run_file) == 0 then
	vim.defer_fn(function()
		local saved_theme = M.load_colorscheme()

		if not saved_theme then
			local default_theme = "onedark"

			pcall(function()
				vim.cmd("Lazy load onedarkpro.nvim")
			end)

			vim.defer_fn(function()
				local ok = pcall(function()
					vim.cmd("colorscheme " .. default_theme)
				end)

				if ok then
					M.save_colorscheme(default_theme)
					M.active_colors_plugins()
					vim.notify("✓ Tema inicial configurado: " .. default_theme, vim.log.levels.INFO)
				end

				vim.fn.writefile({ vim.g.colors_name or "initialized" }, first_run_file)
			end, 300)
		else
			vim.fn.writefile({ "already_configured" }, first_run_file)
		end
	end, 1000)
end

return M
