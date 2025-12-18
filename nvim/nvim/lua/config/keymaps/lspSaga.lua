return {

    { 'K', '<cmd>Lspsaga hover_doc<CR>', desc = "Mostrar documentación (hover)" },
    { 'gd', '<cmd>Lspsaga peek_definition<CR>', desc = "Ir a definición (peek)" },
    { 'gr', '<cmd>Lspsaga lsp_finder<CR>', desc = "Referencias / Finder" },
    { '<leader>ca', '<cmd>Lspsaga code_action<CR>', mode = { 'n', 'v' }, desc = "Acciones rápidas de código" },
    { '<leader>rn', '<cmd>Lspsaga rename<CR>', desc = "Renombrar símbolo" },
    { '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', desc = "Mostrar diagnósticos" },
}
