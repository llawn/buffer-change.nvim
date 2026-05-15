local git = require('buffer-change.git')
local diff = require('buffer-change.diff')

local M = {}

function M.select_ref_type_and_diff()
  local choices = {
    { label = 'Branch', ref_type = 'branch' },
    { label = 'Tag',    ref_type = 'tag' },
    { label = 'Commit', ref_type = 'commit' },
  }

  vim.ui.select(choices, {
    prompt = 'Select ref type for diff',
    format_item = function(item) return item.label end,
  }, function(choice)
    if not choice then return end

    if choice.ref_type == 'branch' then
      local branches = git.branches()
      if #branches == 0 then
        vim.notify('No branches found!', vim.log.levels.WARN)
        return
      end
      vim.ui.select(branches, { prompt = 'Select branch' }, function(branch)
        if branch then diff.show_with_ref(branch) end
      end)

    elseif choice.ref_type == 'tag' then
      local tags = git.tags()
      if #tags == 0 then
        vim.notify('No tags found!', vim.log.levels.WARN)
        return
      end
      vim.ui.select(tags, { prompt = 'Select tag' }, function(tag)
        if tag then diff.show_with_ref(tag) end
      end)

    elseif choice.ref_type == 'commit' then
      local commits = git.commits()
      if #commits == 0 then
        vim.notify('No commits found!', vim.log.levels.WARN)
        return
      end
      vim.ui.select(commits, { prompt = 'Select commit' }, function(commit)
        if commit then
          local hash = commit:match('%S+')
          if hash then diff.show_with_ref(hash) end
        end
      end)
    end
  end)
end

return M
