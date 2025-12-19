return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({ "*" }, {
			mode = "background",
			always_update = true,
		})
	end,
}
