local M = {}

local function get_git_root(filepath)
  local dir = vim.fn.fnamemodify(filepath, ':h')
  local cmd = 'git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel 2>/dev/null'
  local handle = io.popen(cmd)
  if not handle then return nil end
  local root = handle:read('*l')
  handle:close()
  return root
end

function M.root_for(bufname)
  return get_git_root(bufname)
end

function M.relative_path(bufname, git_root)
  return bufname:sub(#git_root + 2)
end

function M.file_at_ref(relative_path, ref)
  local cmd = 'git show ' .. vim.fn.shellescape(ref .. ':' .. relative_path)
  local handle = io.popen(cmd)
  if not handle then return nil end
  local content = handle:read('*a')
  handle:close()
  if content == '' then return nil end
  return content
end

function M.branches()
  local refs = {}
  local handle = io.popen('git for-each-ref --sort=-creatordate --format="%(refname:short)" refs/heads/')
  if handle then
    for line in handle:lines() do
      table.insert(refs, line)
    end
    handle:close()
  end
  return refs
end

function M.commits(count)
  count = count or 50
  local commits = {}
  local handle = io.popen('git log --oneline -' .. count)
  if handle then
    for line in handle:lines() do
      table.insert(commits, line)
    end
    handle:close()
  end
  return commits
end

function M.tags()
  local refs = {}
  local handle = io.popen('git for-each-ref --sort=-creatordate --format="%(refname:short)" refs/tags/')
  if handle then
    for line in handle:lines() do
      table.insert(refs, line)
    end
    handle:close()
  end
  return refs
end

return M
