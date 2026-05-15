local git = require('buffer-change.git')
local diff = require('buffer-change.diff')
local picker = require('buffer-change.picker')

local M = {}

M.git = git
M.diff = diff
M.picker = picker

M.show_diff_with_ref = diff.show_with_ref
M.select_ref_type_and_diff = picker.select_ref_type_and_diff

function M.setup(opts)
  opts = opts or {}
  local keymap = opts.keymap or '<leader>gf'
  vim.keymap.set('n', keymap, picker.select_ref_type_and_diff, { desc = 'Git Diff Current File' })
end

return M
