local root = vim.fn.getcwd()
vim.opt.runtimepath:prepend(root)

local function fail(message)
  error('test failed: ' .. message, 0)
end

local function assert_equal(actual, expected, message)
  if actual ~= expected then
    fail(('%s: expected %s, got %s'):format(message, vim.inspect(expected), vim.inspect(actual)))
  end
end

local function assert_true(value, message)
  if not value then
    fail(message)
  end
end

local function color(hex)
  return tonumber(hex:sub(2), 16)
end

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local config = require('cinder-grove.config')
local palette = require('cinder-grove.palette')
local theme = require('cinder-grove.theme')

config.setup({})
vim.cmd.colorscheme('cinder-grove')
assert_equal(vim.g.colors_name, 'cinder-grove', 'colorscheme name')
assert_equal(highlight('Normal').fg, color('#B4B4B4'), 'Normal foreground')
assert_equal(highlight('Normal').bg, color('#121212'), 'Normal background')
assert_equal(highlight('Comment').fg, color('#535353'), 'Comment color')
assert_equal(highlight('@keyword').fg, color('#95799A'), 'Tree-sitter keyword color')
assert_equal(highlight('DiagnosticError').fg, color('#B14242'), 'diagnostic color')
assert_equal(highlight('markdownHeadingDelimiter').fg, color('#8A9A5B'), 'Markdown heading color')
assert_equal(highlight('IblScope').fg, color('#6284A3'), 'ibl scope color')
assert_equal(highlight('TocH1').fg, color('#8A9A5B'), 'markdown-plus heading color')
assert_equal(highlight('GitSignsAdd').fg, color('#8A9A5B'), 'gitsigns add color')
assert_equal(highlight('TelescopeMatching').fg, color('#E5A72A'), 'Telescope match color')
assert_equal(highlight('NeogitBranch').fg, color('#E5A72A'), 'Neogit branch color')

config.setup({ transparent = true })
require('cinder-grove').load()
assert_equal(highlight('Normal').bg, nil, 'transparent Normal background')
assert_equal(highlight('LineNr').bg, nil, 'transparent LineNr background')
assert_equal(highlight('NormalFloat').bg, color('#191919'), 'transparent floating window background')

config.setup({})
require('cinder-grove').load()
assert_equal(highlight('Normal').bg, color('#121212'), 'opaque background after transparent reload')

local terminal = {
  '#121212',
  '#B14242',
  '#8A9A5B',
  '#E5A72A',
  '#6284A3',
  '#95799A',
  '#4A8B8B',
  '#A7A7A7',
  '#535353',
  '#B14242',
  '#8A9A5B',
  '#E5A72A',
  '#6284A3',
  '#95799A',
  '#4A8B8B',
  '#D5D5D5',
}
for index, expected in ipairs(terminal) do
  assert_equal(vim.g['terminal_color_' .. index - 1], expected, 'terminal color ' .. index - 1)
end

for index = 0, 15 do
  vim.g['terminal_color_' .. index] = '#010203'
end
config.setup({ terminal_colors = false })
require('cinder-grove').load()
for index = 0, 15 do
  assert_equal(vim.g['terminal_color_' .. index], '#010203', 'disabled terminal color ' .. index)
end

config.setup({
  colors = { fg = '#FFFFFF' },
  highlights = {
    Normal = { fg = 'green', bg = '#010203' },
    TestCinderGroveOverride = { fg = 'fg' },
  },
})
require('cinder-grove').load()
assert_equal(highlight('Normal').fg, color('#8A9A5B'), 'symbolic highlight override')
assert_equal(highlight('Normal').bg, color('#010203'), 'hex highlight override')
assert_equal(highlight('TestCinderGroveOverride').fg, color('#FFFFFF'), 'palette override in custom highlight')

config.setup({ colors = { red = 'invalid' } })
local valid_color, color_error = pcall(require('cinder-grove').load)
assert_true(not valid_color, 'invalid palette override must fail')
assert_true(color_error:match('expected #RRGGBB') ~= nil, 'invalid palette error message')

config.setup({ highlights = { TestUnknownColor = { fg = 'missing' } } })
local valid_highlight, highlight_error = pcall(require('cinder-grove').load)
assert_true(not valid_highlight, 'unknown symbolic highlight color must fail')
assert_true(highlight_error:match('unknown palette color') ~= nil, 'unknown color error message')

local defaults = palette.defaults()
defaults.bg = '#FFFFFF'
assert_equal(palette.defaults().bg, '#121212', 'palette defaults are immutable')

config.setup({})
local colors = palette.get({})
for group, spec in pairs(theme.collect(config.get())) do
  local ok, error_message = pcall(require('cinder-grove.util').resolve_spec, spec, colors)
  assert_true(ok, ('%s resolves: %s'):format(group, error_message or ''))
end

local globals = {
  fzf_colors = vim.g.fzf_colors,
  minimap_cursor_color = vim.g.minimap_cursor_color,
  minimap_range_color = vim.g.minimap_range_color,
}
for _, module_name in ipairs(theme.modules()) do
  package.loaded[module_name] = nil
  assert_true(pcall(require, module_name), module_name .. ' loads without its plugin')
end
assert_equal(vim.g.fzf_colors, globals.fzf_colors, 'integrations do not configure fzf')
assert_equal(vim.g.minimap_cursor_color, globals.minimap_cursor_color, 'integrations do not configure minimap cursor')
assert_equal(vim.g.minimap_range_color, globals.minimap_range_color, 'integrations do not configure minimap range')

package.loaded['lualine.themes.cinder-grove'] = nil
local lualine = require('lualine.themes.cinder-grove')
for _, mode in ipairs({ 'normal', 'insert', 'visual', 'replace', 'command', 'terminal', 'inactive' }) do
  assert_true(type(lualine[mode]) == 'table', 'lualine mode ' .. mode)
  assert_true(type(lualine[mode].a) == 'table', 'lualine section a for ' .. mode)
end

config.setup({})
require('cinder-grove').load()
assert_equal(highlight('Normal').fg, color('#B4B4B4'), 'default foreground restored after overrides')
assert_equal(highlight('Normal').bg, color('#121212'), 'default background restored after overrides')

print('cinder-grove: all tests passed')
