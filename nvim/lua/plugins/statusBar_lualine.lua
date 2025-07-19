return {

    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "palenight",
            component_separators = "",
            section_separators = { left = "", right = "" },
        },

        sections = {
            lualine_a = {
                { "mode", separator = { left = "" }, right_padding = 2 },
            },

            lualine_c = {
                { "filename", path = 1 }, -- Muestra la ruta completa del archivo
            },

            lualine_z = {
                { "location", separator = { right = "" }, left_padding = 2 },
            },
        },
    },

    event = "VeryLazy"

}
