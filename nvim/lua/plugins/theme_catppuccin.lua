return {        

    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
    flavour = "macchiato"
    },
    init = function()
        vim.cmd.colorscheme "catppuccin"
    end

}
