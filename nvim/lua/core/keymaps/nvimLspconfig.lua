return function(bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end
	map("n", "K", vim.lsp.buf.hover, "Mostrar documentación")
	map("n", "gd", vim.lsp.buf.definition, "Ir a definición")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Acciones de código")
	map("n", "gr", vim.lsp.buf.references, "Busca todas Referencias donde aparece")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Cambiar variable/funcion en todo el proyecto")
end
