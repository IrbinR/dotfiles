local opt = vim.opt

opt.clipboard = "unnamedplus" -- Habilita el portapapeles
opt.number = true -- Habilita el número de lineas
opt.relativenumber = true -- Muestra números relativos a la linea actual en lugar de números absolutos
--vim.opt.winbar = "%f"			-- Muestra titulo del winbar
opt.splitright = true -- Permite que el vsplit se muestre a la derecha
opt.splitbelow = true -- Permire que el split se muestre abajo
opt.termguicolors = true -- Permite activar colores RGB de 24-bit(true color)
opt.cursorline = true -- Resalta la linea donde esta el cursor
opt.ignorecase = true -- Permite ignorar mayúsculas y minúsculas en las búsquedas
opt.wrap = true -- Permite que las lineas largas se ajusten en ligar de cortarse
opt.linebreak = true -- Hace que el ajuste(wrap) ocurra en un espacio entre palabras, no en medio de ellas

--       --------------> 		Asegura que Neovim no dibuje cruces entre líneas horizontales y verticales
--      |
--      |
opt.fillchars = {
	vert = " ",
	vertleft = " ",
	vertright = " ",
	verthoriz = " ",
	horiz = " ",
	horizup = "─",
	horizdown = "─",
}

opt.splitkeep = "screen" -- Esto evita que Neovim redibuje bordes visuales al crear splits

opt.expandtab = true -- usar espacios en vez de tabs
opt.tabstop = 4 -- cada tab = 4 espacios
opt.shiftwidth = 4 -- indentación automática = 4 espacios
opt.softtabstop = 4 -- <Tab> en modo insert = 4 espacios
