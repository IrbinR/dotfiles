vim.api.nvim_create_autocmd("TabNewEntered", {
  callback = function()
    require("lazy").load({ plugins = { "scope.nvim" } })
  end,
})
