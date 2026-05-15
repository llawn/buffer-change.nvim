vim.api.nvim_create_user_command("BufferDiffRef", function()
  require("buffer-change.picker").select_ref_type_and_diff()
end, { desc = "Diff current buffer against a Git ref" })
