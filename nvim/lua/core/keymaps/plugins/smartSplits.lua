return {
	-- resizing splits
	-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
	{
		"<A-h>",
		function()
			require("smart-splits").resize_left()
		end,
		desc = "Resize Left",
	},
	{
		"<A-j>",
		function()
			require("smart-splits").resize_down()
		end,
		desc = "Resize Down",
	},
	{
		"<A-k>",
		function()
			require("smart-splits").resize_up()
		end,
		desc = "Resize Up",
	},
	{
		"<A-l>",
		function()
			require("smart-splits").resize_right()
		end,
		desc = "Resize Right",
	},

	-- moving between splits
	{
		"<C-h>",
		function()
			require("smart-splits").move_cursor_left()
		end,
		desc = "Move Cursor Left",
	},
	{
		"<C-j>",
		function()
			require("smart-splits").move_cursor_down()
		end,
		desc = "Move Cursor Down",
	},
	{
		"<C-k>",
		function()
			require("smart-splits").move_cursor_up()
		end,
		desc = "Move Cursor Up",
	},
	{
		"<leader>l",
		function()
			require("smart-splits").move_cursor_right()
		end,
		desc = "Move Cursor Right",
	},
	{
		"<C-\\>",
		function()
			require("smart-splits").move_cursor_previous()
		end,
		desc = "Move Cursor Previous",
	},

	-- swapping buffers between windows
	{
		"<leader><leader>h",
		function()
			require("smart-splits").swap_buf_left()
		end,
		desc = "Move Buffer Left",
	},
	{
		"<leader><leader>j",
		function()
			require("smart-splits").swap_buf_down()
		end,
		desc = "Move Buffer Down",
	},
	{
		"<leader><leader>k",
		function()
			require("smart-splits").swap_buf_up()
		end,
		desc = "Move Buffer Up",
	},
	{
		"<leader><leader>l",
		function()
			require("smart-splits").swap_buf_right()
		end,
		desc = "Move Buffer Right",
	},
}
