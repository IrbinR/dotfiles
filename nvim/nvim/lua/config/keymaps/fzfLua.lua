local M = {}

M.find_files_from_project_git_root = function(command)
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")
		return vim.v.shell_error == 0
	end

	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end

	local opts = {}
	if is_git_repo() then
		opts = { cwd = get_git_root() }
	end

	require("fzf-lua")[command](opts)
end

M.commandFzf = function(command)
	return "<cmd>FzfLua " .. command .. "<CR>"
end

return {

	{
		"<leader>ff",
		function()
			M.find_files_from_project_git_root("files")
		end,
		desc = "Listar archivos",
	},

	{ "<leader>fk", M.commandFzf("keymaps"), desc = "Listar keymaps" },

	{ "<leader>fb", M.commandFzf("buffers"), desc = "Listar buffers" },

	{ "<leader>fgc", M.commandFzf("git_commits"), desc = "Listar git commits" },

	{ "<leader>fgs", M.commandFzf("git_status"), desc = "Listar git status" },

	{
		"<leader>flg",
		function()
			M.find_files_from_project_git_root("live_grep")
		end,
		desc = "Buscar con ripgrep",
	},

	{
		"<leader>fc",
		function()
			local selector = require("config.autocmds.theme_manager")
			selector.colorscheme_picker()
		end,
        desc = "Selectro de temas"
	},
}
