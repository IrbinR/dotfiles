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
			rust = { "rustfmt" },
            sh = { "shfmt" }
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

	keys = require("core.keymaps.plugins.conform"),

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
				local mason_registry = require("mason-registry")
				for _, pkg in ipairs(ensure_installed) do
					if mason_registry.has_package(pkg) and not mason_registry.get_package(pkg):is_installed() then
						mason_registry.get_package(pkg):install()
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

		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
