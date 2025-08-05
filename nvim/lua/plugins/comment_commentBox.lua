--[[
--          ╔═════════════════════════════════════════════════════════╗
--          ║                       Comment-box                       ║
--          ╚═════════════════════════════════════════════════════════╝
--          ┌                                                         ┐
--          │  Es un decorador de comentarios y no un resaltador de   │
--          │       comentarios como lo hace todo-comment.nvim        │
--          └                                                         ┘
--          TODO: Crear keymaps de Comment-box
]]
return {
	"LudoPinelli/comment-box.nvim",
    keys = require("core.keymaps.plugins.commentBox")
}
