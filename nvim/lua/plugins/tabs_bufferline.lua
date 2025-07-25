return {

	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
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
			show_close_icon = false,
			diagnostics = "nvim_lsp",
			separator_style = "slant",

			-- Prevenir problemas de layout
			enforce_regular_tabs = false,
			always_show_bufferline = true,
		},
	},
}
