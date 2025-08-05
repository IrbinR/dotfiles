local function map(mode, lhs, rhs, opts )
    vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>hp", "<cmd>:RunSplit h<cr>", { desc = "Abre ventana horizontal" })
map("n", "<leader>vp", "<cmd>:RunSplit v<cr>", { desc = "Abre ventana vertical" })
