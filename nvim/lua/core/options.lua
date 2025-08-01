vim.o.clipboard = "unnamedplus" --Habilitar portapapeles
local opt = vim.opt

-- ─[ Apariencia y manejo de archivos ]────────────────────────────────
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true

-- ─[ Comportamiento de edicción ]─────────────────────────────────────
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- ─[ Búsqueda ]───────────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase = true
--opt.incsearch = true
--opt.hlsearch = true
--opt.laststatus = 0
--opt.cmdheight = 0
opt.wrap = true
opt.linebreak = true

-- ─[ Barra de estado y lineas de comandos ]───────────────────────────
opt.showmode = false -- Muestra el modo actual(insertar, normal y visual), si usas lualine desactivalo
print("Cargando core/options")
