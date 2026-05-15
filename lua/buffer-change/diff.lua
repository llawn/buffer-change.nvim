local git = require('buffer-change.git')
local diff = require('mini.diff')

local M = {}

function M.show_with_ref(ref)
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    vim.notify('Buffer is not saved to a file!', vim.log.levels.WARN)
    return
  end

  local git_root = git.root_for(bufname)
  if not git_root then
    vim.notify('Buffer is not in a Git repository!', vim.log.levels.ERROR)
    return
  end

  local relative_path = git.relative_path(bufname, git_root)
  local git_content = git.file_at_ref(relative_path, ref)
  if not git_content then
    vim.notify('File not found at ref: ' .. ref, vim.log.levels.ERROR)
    return
  end

  diff.set_ref_text(0, git_content)
  vim.notify('Diff with ' .. ref .. ' displayed!', vim.log.levels.INFO)
end

return M
