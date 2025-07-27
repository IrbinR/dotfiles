return {

	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = function()
		local bufferline = require("bufferline")
		local colourSelected = "#EDC595"
		local underlineColor = "#FF8AA6"

		return {
			options = {
				-- Usar Snacks.bufdelete para cerrar buffers
				close_command = function(bufnum)
					Snacks.bufdelete({ buf = bufnum })
				end,
				right_mouse_command = function(bufnum)
					Snacks.bufdelete({ buf = bufnum })
				end,

				close_icon = "󱎘",
				buffer_close_icon = "󱎘",
				-- Configuraciones adicionales
				show_buffer_close_icons = true,
				diagnostics = "nvim_lsp",
				style_preset = bufferline.style_preset.minimal,
				separator_style = { "", "" },
				indicator = {
					style = "underline",
				},

				offsets = {
					{ filetype = "neo-tree" },
				},
			},

			highlights = {

				buffer_selected = {
					fg = colourSelected,
					sp = underlineColor,
					bold = false,
					italic = true,
					underline = true,
				},
				diagnostic_selected = {
					fg = colourSelected,
					bold = false,
					italic = false,
					--underline = false,

					sp = underlineColor,
					underline = true,
				},
				error_selected = {
					fg = colourSelected,
					bold = false,

					sp = underlineColor,
					underline = true,
				},
				warning_selected = {
					fg = colourSelected,
					bold = false,

					sp = underlineColor,
					underline = true,
				},
				hint_selected = {
					fg = colourSelected,
					bold = false,

					sp = underlineColor,
					underline = true,
				},
				info_selected = {
					fg = colourSelected,
					bold = false,

					sp = underlineColor,
					underline = true,
				},
				close_button_selected = {
					fg = underlineColor,

					sp = underlineColor,
					underline = true,
				},
				indicator_selected = {
					sp = underlineColor,
					underline = true,
				},

				tab_selected = {
					fg = "#9ED89B",
					--sp = "#9ED89B", -- mismo underline color
					underline = false,
				},
				tab_close = {
					fg = underlineColor,
				},
				-- Si también quieres que las tabs no seleccionadas tengan estilo
				tab = {
					bg = {
						attribute = "bg",
						highlight = "Normal",
					},
				},
			},
		}
	end,
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
