
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local commentbox = require("comment-box")

local options = {
  "CBllbox",
  "CBrlbox",
  "CBclbox",
  "CBccbox",
  "CBccline",
  "CBcline",
  "CBalbox",
  "CBajbox",
  "CBcbox",
  "CBline"
}

local function generate_preview(cmd)
  -- Esto es solo un ejemplo: ajusta el texto a previsualizar como gustes
  local sample_text = "Comentario de ejemplo"
  local lines = commentbox[cmd]({ lines = { sample_text } })
  return table.concat(lines, "\n")
end

local function comment_box_menu()
  pickers.new({}, {
    prompt_title = "Selecciona una caja",
    finder = finders.new_table({
      results = options,
    }),
    sorter = conf.generic_sorter({}),
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry)
        local content = generate_preview(entry.value)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(content, "\n"))
      end,
    }),
    attach_mappings = function(_, map)
      map("i", "<CR>", function()
        local selection = action_state.get_selected_entry()
        actions.close()
        vim.cmd(selection[1]) -- Ejecutar comando
      end)
      return true
    end,
  }):find()
end

return comment_box_menu
