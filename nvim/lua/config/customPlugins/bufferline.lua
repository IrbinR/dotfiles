local M = {}

M.validated = function(theme)
	local config
	if theme == "solarized" then
		config = M.solarized()
	elseif theme == "gruvbox" then
		config = M.gruvbox()
	elseif theme:match("^onedark") then
		config = M.onedark()
	else
		config = M.default()
	end
	return config
end

M.options = function()
	return {
		offsets = {
			{ filetype = "neo-tree" },
		},
		separator_style = { "", "" },
		indicator = {
			style = "",
		},
		close_icon = "󱎘",
	}
end

M.solarized = function()
	return {
		options = M.options(),
		highlights = {
			fill = {
				bg = { attribute = "bg", highlight = "None" },
			},

			background = {
				bg = { attribute = "bg", highlight = "None" },
			},

			buffer_selected = {
				bg = { attribute = "bg", highlight = "None" },
			},

			close_button_selected = {
				bg = { attribute = "bg", highlight = "None" },
			},

			indicator_selected = {
				bg = { attribute = "bg", highlight = "None" },
			},

			close_button = {
				bg = { attribute = "bg", highlight = "None" },
			},

			separator = {
				bg = { attribute = "bg", highlight = "None" },
			},

			tab_selected = {
				bg = { attribute = "bg", highlight = "None" },
				fg = "#9ED89B",
			},

			tab_close = {
				bg = { attribute = "bg", highlight = "None" },
			},

			tab = {
				bg = { attribute = "bg", highlight = "None" },
				fg = "#FF8AA6",
			},
		},
	}
end

M.gruvbox = function()
	local backgroundColor = "#282828"
	return {
		options = M.options(),
		highlights = {
			fill = {
				bg = backgroundColor,
			},

			background = {
				bg = backgroundColor,
			},

			buffer_selected = {
				bg = backgroundColor,
			},

			close_button_selected = {
				bg = backgroundColor,
				fg = "#EF6975",
			},

			indicator_selected = {
				bg = backgroundColor,
			},

			close_button = {
				bg = backgroundColor,
			},

			separator = {
				bg = backgroundColor,
			},

			tab_selected = {
				bg = backgroundColor,
				fg = "#FBFF00",
			},

			tab_close = {
				bg = "#EF6975",
				fg = "#000000",
			},

			tab = {
				bg = backgroundColor,
				fg = "#93ABA2",
			},
		},
	}
end

M.onedark = function()
	-- local onedark = require("onedarkpro.helpers").get_colors()
	return {
		options = M.options(),
		highlights = {
			fill = {
				bg = { attribute = "bg", highlight = "None" },
			},

			background = {
				bg = { attribute = "bg", highlight = "None" },
			},

			buffer_selected = {
				bg = { attribute = "bg", highlight = "None" },
			},

			close_button_selected = {
				bg = { attribute = "bg", highlight = "None" },
			},

			indicator_selected = {
				bg = { attribute = "bg", highlight = "None" },
			},

			close_button = {
				bg = { attribute = "bg", highlight = "None" },
			},

			separator = {
				bg = { attribute = "bg", highlight = "None" },
			},

			tab_selected = {
				bg = { attribute = "bg", highlight = "None" },
				fg = "#9ED89B",
			},

			tab_close = {
				bg = { attribute = "bg", highlight = "None" },
			},

			tab = {
				bg = { attribute = "bg", highlight = "None" },
				fg = "#FF8AA6",
			},
		},
	}
end

M.default = function()
	return {

		options = {
			offsets = {
				{ filetype = "neo-tree" },
			},
			separator_style = { "", "" },
			indicator = {
				style = "",
			},
		},
	}
end

return M
