# buffer-change.nvim

Diff the current buffer against any Git reference — branch, tag, or commit — with inline annotations powered by `mini.diff`.

## Features

- Inline buffer diff against any Git ref (branch, tag, commit)
- Interactive picker via `vim.ui.select`
- Single user command `:BufferDiffRef`

## Requirements

- Neovim >= 12
- [mini.diff](https://github.com/nvim-mini/mini.diff)
- `git`

## Installation

### vim.pack

```lua
vim.pack.add({
    "https://github.com/nvim-mini/mini.diff"
    "https://github.com/llawn/buffer-change.nvim"
})
```

## Usage

- `:BufferDiffRef` — pick a ref type, then a specific ref, and diff the current buffer against it.

## How it works

1. Retrieves the file content at the chosen ref via `git show`.
2. Passes it to `mini.diff` to render inline change annotations in the current buffer.
3. The diff is purely additive — it does not modify the buffer contents.

## License

MIT
