return {

	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- Optional image support for file preview: See `# Preview Mode` for more information.
		-- {"3rd/image.nvim", opts = {}},
		-- OR use snacks.nvim's image module:
		-- "folke/snacks.nvim",
	},
	--lazy = false, -- neo-tree will lazily load itself
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		-- add options here
	},

    keys = require("core.keymaps.neotree"),

	config = function(_, opts)
		require("neo-tree").setup(opts)

		-- Forzar fondo transparente o igual al Normal
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
		-- Opcionalmente también puedes igualar los bordes o float
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	end,
}
