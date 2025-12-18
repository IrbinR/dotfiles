return {

	-- NORMAL
	{ "gcc", desc = "Alterna la línea actual usando comentarios línea por línea" },
	{ "gbc", desc = "Alterna la línea actual usando comentarios en bloque" },
	{ "gco", desc = "Inserta comentario en la siguiente línea y entra en modo INSERTAR" },
	{ "gcO", desc = "Inserta comentario en la línea anterior y entra en modo INSERTAR" },
	{ "gcA", desc = "Inserta comentario hasta el final de la línea actual y entra en modo INSERTAR" },

	-- VISUAL y OP-PENDING
	{ "gc", mode = { "v", "o" }, desc = "Alterna la región usando comentarios línea por línea" },
	{ "gb", mode = { "v", "o" }, desc = "Alterna la región usando comentarios en bloques" },

}
