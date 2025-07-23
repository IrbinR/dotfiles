return {
	"stevearc/conform.nvim",
	opts = function()
		local prettierd_langs = {
			"javascript",
			"typescript",
			"json",
			"yaml",
			"html",
			"css",
			"scss",
			"less",
			"markdown",
			"graphql",
			"vue",
			"svelte",
			"handlebars",
		}

		local formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt", lsp_format = "fallback" },
		}

		for _, ft in ipairs(prettierd_langs) do
			formatters_by_ft[ft] = { "prettierd" }
		end

		return {
			formatters_by_ft = formatters_by_ft,

			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		}
	end,

	init = function()
		local ensure_installed = {
			"stylua",
			"isort",
			"black",
			"prettierd",
		}

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyDone",
			callback = function()
				local registry = require("mason-registry")
				for _, name in ipairs(ensure_installed) do
					local ok, pkg = pcall(registry.get_package, name)
					if ok and not pkg:is_installed() then
						pkg:install()
					end
				end
			end,
		})

		vim.api.nvim_create_user_command("Format", function(args)
			require("conform").format({
				lsp_fallback = true,
				async = true,
				range = args.range > 0 and {
					start = { args.line1, 0 },
					["end"] = { args.line2, 0 },
				} or nil,
			})
		end, { range = true })
	end,
}
