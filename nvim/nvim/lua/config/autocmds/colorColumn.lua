local colorColumn = function(patterns, column)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = patterns,
		callback = function()
			vim.opt_local.colorcolumn = column
		end,
	})
end

local filesTypes = {
	[80] = { "python", "sh" },
	[100] = { "javascript", "typescript", "html", "css", "lua" },
	--[120] = { "go", "rust" },
}

for column, patterns in pairs(filesTypes) do
	colorColumn(patterns, tostring(column))
end
