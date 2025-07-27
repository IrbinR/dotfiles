return {

	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = function()
		-- Primero requerimos el módulo aquí donde sí está disponible
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

				-- Configuraciones adicionales
				show_buffer_close_icons = true,
				diagnostics = "nvim_lsp",
				style_preset = bufferline.style_preset.minimal, -- Usamos la referencia local
				separator_style = "thin",
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
					underline = true, -- ¡Importante!
				},
				indicator_selected = {
					sp = underlineColor,
					underline = true,
				},

				tab_selected = {
					fg = colourSelected, -- mismo color que buffer_selected
					sp = underlineColor, -- mismo underline color
					underline = true,
				},
				tab_separator_selected = {
					fg = "#232634", -- mismo color del fondo para que no se vea
					--bg = "#232634",
					bg = {
						attribute = "bg",
						highlight = "Normal",
					},
					sp = underlineColor,
					underline = true,
				},
				tab_close = {
					fg = underlineColor,
					--bg = "#232634",
					bg = {
						attribute = "bg",
						highlight = "Normal",
					},
					sp = underlineColor,
					underline = true,
				},
				-- Si también quieres que las tabs no seleccionadas tengan estilo
				tab = {
					fg = "#6c7086",
					--bg = "#232634",
					bg = {
						attribute = "bg",
						highlight = "Normal",
					},
				},
				tab_separator = {
					fg = "#232634",
					--bg = "#232634",
					bg = {
						attribute = "bg",
						highlight = "Normal",
					},
				},
				close_button = {
					fg = "#6c7086",
					--bg = "#232634",
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
