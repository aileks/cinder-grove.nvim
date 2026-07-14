# Cinder Grove

A warm, muted Neovim colorscheme built around charcoal, grove green, ember orange, and cool blue accents.

## Features

- Modern Neovim UI, syntax, Tree-sitter, LSP, diagnostics, and semantic tokens
- Language-specific groups for Markdown, structured data, web, Lua, Go, Python, Rust, shell, and JavaScript/TypeScript
- Plugin integrations with no plugin setup or import-time side effects
- Lualine auto-discovery through `theme = 'auto'`
- Optional transparency, palette overrides, highlight overrides, and terminal colors
- Dependency-free headless tests

## Installation

Use the repository URL after publishing it. With lazy.nvim:

```lua
{
  '<user>/cinder-grove.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('cinder-grove')
  end,
}
```

With Neovim's built-in package manager:

```lua
vim.pack.add({
  { src = 'https://github.com/<user>/cinder-grove.nvim' },
})
vim.cmd.colorscheme('cinder-grove')
```

For local development:

```lua
vim.opt.runtimepath:prepend('/path/to/cinder-grove.nvim')
vim.cmd.colorscheme('cinder-grove')
```

## Configuration

Calling `setup()` is optional. It configures the theme but does not load it.

```lua
require('cinder-grove').setup({
  transparent = false,
  terminal_colors = true,
  colors = {},
  highlights = {},
})
vim.cmd.colorscheme('cinder-grove')
```

### Transparency

Cinder Grove uses `#121212` as the default editor background. Enable transparency while keeping floating windows opaque:

```lua
require('cinder-grove').setup({ transparent = true })
vim.cmd.colorscheme('cinder-grove')
```

### Palette overrides

Palette values must use six-digit hexadecimal colors. Existing names can be replaced and new names can be used by custom highlights.

```lua
require('cinder-grove').setup({
  colors = {
    bg = '#101010',
    custom = '#6F8050',
  },
  highlights = {
    Normal = { fg = 'fg', bg = 'bg' },
    MyHighlight = { fg = 'custom', bold = true },
  },
})
```

Highlight colors may be palette names, `#RRGGBB`, or `NONE`. Other `nvim_set_hl()` fields pass through unchanged.

## Palette

| Role | Color |
| --- | --- |
| Background | `#121212` |
| Alternate background | `#191919` |
| Surface | `#212121` |
| Muted | `#535353` |
| Gray | `#949494` |
| Dim foreground | `#A7A7A7` |
| Foreground | `#B4B4B4` |
| Bright foreground | `#D5D5D5` |
| Red | `#B14242` |
| Green | `#8A9A5B` |
| Yellow | `#E5A72A` |
| Blue | `#6284A3` |
| Magenta | `#95799A` |
| Cyan | `#4A8B8B` |
| Orange | `#C4693D` |

No extra colors are used by the Neovim theme. Every highlight maps to this established Cinder Grove palette.

## Integrations

Cinder Grove defines highlights for:

- blink.cmp and nvim-cmp
- flash.nvim
- fzf-lua and optional fzf.vim colors
- gitsigns.nvim and neogit
- indent-blankline.nvim
- lazy.nvim
- lualine.nvim
- markdown-plus.nvim
- mini.icons and minimap.vim
- obsidian.nvim, org-bullets.nvim, and render-markdown.nvim
- oil.nvim
- telescope.nvim
- trailblazer.nvim
- which-key.nvim

Integrations are pure highlight definitions and are safe to load without the plugins installed.

### Lualine

The current dotfiles configuration works without changes:

```lua
require('lualine').setup({
  options = { theme = 'auto' },
})
```

### fzf.vim and minimap.vim

These plugins require configuration in addition to highlight groups. Optional data is exported without changing globals:

```lua
vim.g.fzf_colors = require('cinder-grove.extras').fzf_colors()

for name, value in pairs(require('cinder-grove.extras').minimap()) do
  vim.g[name] = value
end
```

## Development

```sh
stylua --check colors lua tests
nvim --headless --clean --cmd 'set runtimepath^=.' -l tests/run.lua
nvim --headless --clean --cmd 'set runtimepath^=.' \
  '+colorscheme cinder-grove' \
  '+lua assert(vim.g.colors_name == "cinder-grove")' \
  '+qa'
git diff --check
```

## Acknowledgements

Cinder Grove began as a visual adaptation of [Ashen](https://codeberg.org/ficd/ashen.nvim) by Daniel Fichtinger. Its standalone Neovim architecture also uses Ashen as a reference. Ashen's MIT notice is retained in `LICENSE`.
