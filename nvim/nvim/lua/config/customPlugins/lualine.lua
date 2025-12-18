local M = {}
-- Configuración BASE (por defecto)
local base_config = {
	-- {{{
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16,
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
	-- }}}
}

-- Función helper para hacer deep merge
local function merge_config(override)
	local base = vim.deepcopy(base_config)
	return vim.tbl_deep_extend("force", base, override)
end

M.tundra = function()
	-- {{{
	local function espaciador()
		return {
			function()
				return " "
			end,
			color = { bg = "none" },
			padding = 0,
		}
	end

	local function separadores()
		return { left = "", right = "" }
	end
	local tundra_colors = require("nvim-tundra.palette." .. (vim.g.tundra_biome or "arctic"))
	local tundra_override = {
		options = {
			theme = "tundra",
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},

		sections = {
			lualine_a = {
				{
					"mode",
					separator = separadores(),
				},
			},

			lualine_b = {
				espaciador(),
				{
					"filetype",
					separator = { left = "" },
					icon_only = true,
					color = {
						bg = tundra_colors.gray._800,
					},
					padding = 0,
				},
				{
					"filename",
					separator = { right = "" },
					color = {
						bg = tundra_colors.gray._800,
						fg = tundra_colors.gray._400,
						gui = "bold",
					},
					symbols = {
						modified = "",
						newfile = "",
						readonly = "󰌾",
						unnamed = "󰡯",
					},
					padding = 0,
				},
			},

			lualine_c = {
				{
					"branch",
					icon = "",
					color = {
						fg = tundra_colors.gray._400,
					},
					padding = { left = 1, right = 0 },
				},
				{
					"diff",
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
					padding = { left = 1, right = 0 },
				},
				{
					function()
						local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
						return "" .. " " .. buf_count
					end,
					color = { fg = tundra_colors.indigo._500, gui = "bold" },
					cond = function()
						local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
						return buf_count > 1
					end,
				},
			},

			lualine_x = {
				"encoding",
				"fileformat",
				"diagnostics",
				{
					"lsp_status",
					color = { fg = tundra_colors.sky._500 },
				},
			},

			lualine_y = {
				{
					function()
						local line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")
						local percent = math.floor((line / total_lines) * 100)

						local icon
						if line == 1 then
							icon = "󰘣 TOP"
						elseif line == total_lines then
							icon = "󰘡 BOT"
						else
							icon = percent .. " 󰏰"
						end

						return icon
					end,
					separator = separadores(),
					color = {
						bg = tundra_colors.gray._800,
						fg = tundra_colors.gray._400,
						gui = "bold",
					},
					padding = 0,
				},
				espaciador(),
			},

			lualine_z = {
				{
					function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					end,
					icon = "",
					color = {
						bg = tundra_colors.gray._800,
						fg = tundra_colors.sand._500,
						gui = "bold",
					},
					separator = separadores(),
					padding = 0,
				},
				espaciador(),
				{
					function()
						return " " .. vim.fn.line(".") .. ":" .. vim.fn.col(".")
					end,
					color = {
						bg = tundra_colors.gray._800,
						fg = tundra_colors.gray._400,
						gui = "bold",
					},
					separator = separadores(),
					padding = 0,
				},
			},
		},
	}

	return merge_config(tundra_override)
	-- }}}
end

M.onedark = function()
	-- {{{
	local onedark = require("onedarkpro.helpers").get_colors()
	local devicons = require("nvim-web-devicons")
	local function espaciador(color)
		return {
			function()
				return " "
			end,
			color = { bg = color },
			padding = 0,
		}
	end

	local file_icon = function()
		local filename = vim.fn.expand("%:t")
		local extension = vim.fn.expand("%:e")
		local icon = devicons.get_icon(filename, extension, { default = true })

		if icon == nil then
			icon = " "
		end

		return icon .. " "
	end

	local onedark_override = {
		options = {
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						local mode_icons = {
							NORMAL = " ",
							INSERT = " ",
							VISUAL = "󰈈 ",
							VLINE = "󰆤 ",
							VBLOCK = "󰝤 ",
							REPLACE = " ",
							COMMAND = " ",
						}

						return (mode_icons[str] or " ")
					end,
					separator = { left = "" },
					color = function()
						local mode = vim.fn.mode()
						local colors = {
							n = { bg = onedark.blue },
							i = { bg = onedark.green },
							v = { bg = onedark.orange },
							V = { bg = onedark.orange },
							R = { bg = onedark.red },
							c = { bg = onedark.purple },
						}
						return colors[mode] or colors["n"]
					end,
					padding = 0,
				},
				espaciador(onedark.fg_gutter),
				{
					"mode",
					color = function()
						local mode = vim.fn.mode()
						local colors = {
							n = { fg = onedark.blue, bg = onedark.fg_gutter },
							i = { fg = onedark.green, bg = onedark.fg_gutter },
							v = { fg = onedark.orange, bg = onedark.fg_gutter },
							V = { fg = onedark.orange, bg = onedark.fg_gutter },
							R = { fg = onedark.red, bg = onedark.fg_gutter },
							c = { fg = onedark.purple, bg = onedark.fg_gutter },
						}
						return colors[mode] or colors["n"]
					end,
					separator = { right = "" },
					padding = 0,
				},
				espaciador(onedark.float_bg),
			},
			lualine_b = {
				{
					file_icon,
					separator = { left = "" },
					color = {
						bg = onedark.red,
						fg = onedark.float_bg,
					},
					padding = 0,
				},
				espaciador(onedark.fg_gutter),
				{
					"filename",
					separator = { right = "" },
					color = {
						bg = onedark.fg_gutter,
						fg = onedark.red,
					},
					symbols = {
						modified = "",
						newfile = "",
						readonly = "󰌾",
						unnamed = "󰡯",
					},
					padding = 0,
				},
				espaciador(onedark.float_bg),
				{
					"branch",
					icon = "",
					color = {
						fg = onedark.comment,
						bg = onedark.float_bg,
					},
					padding = 0,
				},
				{
					"diff",
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
					color = {
						bg = onedark.float_bg,
					},
					diff_color = {
						added = { fg = onedark.comment },
						modified = { fg = onedark.comment },
						removed = { fg = onedark.comment },
					},
				},
			},
			lualine_c = {},
			lualine_x = {
				{
					"encoding",
					color = {
						fg = onedark.comment,
					},
				},
				{
					"diagnostics",
				},
				{
					function()
						return " "
					end,
					separator = { left = "" },
					color = {
						bg = onedark.green,
						fg = onedark.float_bg,
					},
					padding = 0,
				},
				espaciador(onedark.fg_gutter),
				{
					function()
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if #clients == 0 then
							return "unknown"
						end
						local names = {}
						for _, c in ipairs(clients) do
							table.insert(names, c.name)
						end
						return table.concat(names, ", ")
					end,
					icons_enabled = false,
					color = {
						fg = onedark.green,
						bg = onedark.fg_gutter,
					},
					separator = { right = "" },
					padding = 0,
				},
				espaciador(onedark.float_bg),
			},
			lualine_y = {
				{
					function()
						local line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")

						local icon
						if line == 1 then
							icon = "TOP "
						elseif line == total_lines then
							icon = "BOT "
						else
							icon = "󰏰 "
						end

						return icon
					end,
					separator = { left = "" },
					color = {
						fg = onedark.float_bg,
						bg = onedark.virtual_text_error,
					},
					padding = 0,
				},
				espaciador(onedark.fg_gutter),
				{
					function()
						local line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")
						local percent = math.floor((line / total_lines) * 100)
						return percent
					end,
					separator = { right = "" },
					color = {
						fg = onedark.virtual_text_error,
						bg = onedark.fg_gutter,
					},
					padding = 0,
				},
			},
			lualine_z = {
				espaciador(onedark.float_bg),
				{
					function()
						return "󰕮 "
					end,
					separator = { left = "" },
					color = {
						bg = onedark.yellow,
						fg = onedark.float_bg,
					},
					padding = 0,
				},
				espaciador(onedark.fg_gutter),
				{
					function()
						return vim.fn.line(".") .. "/" .. vim.fn.col(".")
					end,
					separator = { right = "" },
					color = {
						fg = onedark.yellow,
						bg = onedark.fg_gutter,
					},
					padding = 0,
				},
			},
		},
	}
	return merge_config(onedark_override)
	-- }}}
end

M.gruvbox = function()
	-- {{{
	local gruvbox = require("gruvbox").palette
	local mode_colors = {
		n = { fg = gruvbox.neutral_blue },
		i = { fg = gruvbox.neutral_green },
		v = { fg = gruvbox.neutral_aqua },
		V = { fg = gruvbox.neutral_aqua },
		c = { fg = gruvbox.neutral_red },
		R = { fg = gruvbox.neutral_purple },
	}

	local function separadorMode(separator, next_bg)
		return {
			function()
				return separator
			end,
			color = function()
				local mode = vim.fn.mode()
				local c = mode_colors[mode] or mode_colors["n"]
				return { fg = c.fg, bg = gruvbox[next_bg] }
			end,
			padding = 0,
		}
	end

	local separadorGruvbox = function(separator, fg, bg)
		return {

			function()
				return separator
			end,
			color = { fg = gruvbox[fg], bg = gruvbox[bg] },
			padding = 0,
		}
	end

	local separadorDiagnostic = function(separator, fg, bg)
		return {
			function()
				return separator
			end,
			color = { fg = gruvbox[fg], bg = gruvbox[bg] },
			padding = 0,
			cond = function()
				return #vim.diagnostic.get(0) > 0
			end,
		}
	end

	local separadorDiff = function(separator)
		return {
			function()
				return separator
			end,
			color = function()
				local diagnostic = #vim.diagnostic.get(0)
				if diagnostic > 0 then
					return {
						fg = gruvbox.neutral_orange,
						bg = gruvbox.dark0_soft,
					}
				end
				return {
					fg = gruvbox.neutral_orange,
					bg = gruvbox.dark1,
				}
			end,
			padding = 0,
		}
	end

	local gruvbox_override = {
		options = {
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			theme = {
				normal = {
					a = { fg = gruvbox.light0_soft, bg = gruvbox.neutral_blue, gui = "bold" },
					b = { fg = gruvbox.light0_soft, bg = gruvbox.neutral_yellow },
					c = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
					x = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
				},
				insert = {
					a = { fg = gruvbox.dark0_soft, bg = gruvbox.neutral_green, gui = "bold" },
					b = { fg = gruvbox.dark0_soft, bg = gruvbox.neutral_yellow, gui = "bold" },
					c = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
					x = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
				},
				visual = {
					a = { fg = gruvbox.dark0_soft, bg = gruvbox.neutral_aqua, gui = "bold" },
					b = { fg = gruvbox.dark_aqua, bg = gruvbox.neutral_yellow, gui = "bold" },
					c = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
					x = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
				},
				replace = {
					a = { fg = gruvbox.dark0_soft, bg = gruvbox.neutral_purple, gui = "bold" },
					c = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
					x = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
				},
				command = {
					a = { fg = gruvbox.bright_green, bg = gruvbox.neutral_red, gui = "bold" },
					c = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
					x = { fg = gruvbox.light0_soft, bg = gruvbox.dark1 },
				},
			},
		},

		sections = {
			lualine_a = {
				{
					"mode",
					separator = { left = "" },
					color = function()
						local mode = vim.fn.mode()
						local colors = {
							n = { fg = gruvbox.light0_soft, bg = gruvbox.neutral_blue, gui = "bold" },
							i = { fg = gruvbox.dark0_soft, bg = gruvbox.neutral_green, gui = "bold" },
							v = { fg = gruvbox.dark0_soft, bg = gruvbox.neutral_aqua, gui = "bold" },
							V = { fg = gruvbox.dark0_soft, bg = gruvbox.neutral_aqua, gui = "bold" },
							c = { fg = gruvbox.bright_green, bg = gruvbox.neutral_red, gui = "bold" },
							R = { fg = gruvbox.dark0_soft, bg = gruvbox.neutral_purple, gui = "bold" },
						}
						return colors[mode] or colors["n"]
					end,
				},
				separadorMode("", "neutral_yellow"),
			},

			lualine_b = {
				{
					"branch",
					color = {
						fg = gruvbox.light0_soft,
						bg = gruvbox.neutral_yellow,
					},
				},
				separadorGruvbox("", "neutral_yellow", "neutral_orange"),
				{
					"diff",
					color = {
						bg = gruvbox.neutral_orange,
					},
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
					diff_color = {
						added = { fg = gruvbox.light0_soft },
						modified = { fg = gruvbox.light0_soft },
						removed = { fg = gruvbox.light0_soft },
					},
				},
				separadorDiff(""),
				{
					"diagnostics",
					color = {
						bg = gruvbox.dark0_soft,
					},
				},
				separadorDiagnostic("", "dark0_soft", "dark1"),
			},

			lualine_c = {
				{
					"filename",
					color = {
						fg = gruvbox.light0_soft,
					},
				},
			},

			lualine_x = {
				{
					"encoding",
				},
				{
					"fileformat",
				},
				separadorGruvbox("", "dark0_soft", "dark1"),
				{
					"filetype",
					color = {
						bg = gruvbox.dark0_soft,
					},
				},
			},

			lualine_y = {
				separadorGruvbox("", "neutral_yellow", "dark0_soft"),
				{
					function()
						local line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")
						local percent = math.floor((line / total_lines) * 100)

						local icon
						if line == 1 then
							icon = "󰘣 TOP"
						elseif line == total_lines then
							icon = "󰘡 BOT"
						else
							icon = percent .. " 󰏰"
						end

						return icon
					end,
					color = {
						bg = gruvbox.neutral_yellow,
						fg = gruvbox.light0_soft,
					},
					padding = 1,
				},
			},

			lualine_z = {
				{
					function()
						return " " .. vim.fn.line(".") .. ":" .. vim.fn.col(".")
					end,
					color = {
						bg = gruvbox.neutral_blue,
						fg = gruvbox.light0_soft,
						gui = "bold",
					},
					separator = { left = "", right = "" },
					padding = 1,
				},
			},
		},
	}

	return merge_config(gruvbox_override)
	-- }}}
end

M.solarized = function()
	-- {{{
	local devicons = require("nvim-web-devicons")

	local function file_icon_and_name()
		local filename = vim.fn.expand("%:t") -- nombre del archivo
		local extension = vim.fn.expand("%:e") -- extensión del archivo
		local icon = devicons.get_icon(filename, extension, { default = true })

		if icon == nil then
			icon = "" -- ícono por defecto si no hay
		end

		return icon .. " " .. filename
	end

	local solarized_override = {

		options = {
			theme = "solarized",
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},

		sections = {
			lualine_a = {
				{
					"mode",
					-- icon = "",
					fmt = function(str)
						local mode_icons = {
							NORMAL = "",
							INSERT = "",
							VISUAL = "󰈈",
							VLINE = "󰆤",
							VBLOCK = "󰝤",
							REPLACE = "",
							COMMAND = "",
						}

						return (mode_icons[str] or "") .. " " .. str
					end,
				},
			},
			lualine_b = { file_icon_and_name },
			lualine_c = {
				"branch",
				{
					"diff",
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
				},
				"diagnostics",
				{
					function()
						local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
						return "" .. " " .. buf_count
					end,
					cond = function()
						local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
						return buf_count > 1
					end,
				},
			},
			lualine_x = { "encoding", "fileformat" },
			lualine_y = {
				{
					function()
						local line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")
						local percent = math.floor((line / total_lines) * 100)

						local icon
						if line == 1 then
							icon = "󰘣 TOP"
						elseif line == total_lines then
							icon = "󰘡 BOT"
						else
							icon = percent .. " 󰏰"
						end

						return icon
					end,
				},
			},
			lualine_z = {
				{
					function()
						return " " .. vim.fn.line(".") .. ":" .. vim.fn.col(".")
					end,
				},
			},
		},
	}

	return merge_config(solarized_override)
	-- }}}
end

M.default = function()
	local default_override = {
		options = {
			globalstatus = true,
		},
	}
	return merge_config(default_override)
end

return M
