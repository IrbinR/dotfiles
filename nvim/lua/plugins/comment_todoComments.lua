--[[
--          ┌─────────────────────────────────────────────────────────┐
--          │                      Todo-Comments                      │
--          └─────────────────────────────────────────────────────────┘
--          ┌                                                         ┐
--          │ Es un resaltador de comentarios aqui podemos resaltar   │
--          │ el comentarios para lo siguiente:                       │
--          │ TODO   🔵: Para tareas pendientes                       │
--          │ FIXME  🔴: Para código que necesita reparación          │
--          │ WARN   🟡: Para advertencias futuras                    │
--          │ NOTE   🟢: Para información importante                  │
--          │ HACK   🟠: Para soluciones temporales                   │
--          │ PERF   🟣: Para optimizaciones pendientes               │
--          │ TEST   ⚪: Para recordatorios de testing                │
--          └                                                         ┘
--
--          TODO: Crear keymaps para Todo-Comments
--]]
return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
    keys = require("core.keymaps.plugins.todoComments")
}
