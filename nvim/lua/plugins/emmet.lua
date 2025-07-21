return {

  "mattn/emmet-vim",
  ft = { "html", "css", "javascriptreact", "typescriptreact" },
  init = function()
    -- Puedes cambiar esto a otra combinación si lo deseas
    vim.g.user_emmet_leader_key = '<C-e>' --El keymap es Ctrl+e y luego ,
  end,

}
