local config = require('cinder-grove.config').get()
local colors = require('cinder-grove.palette').get(config.colors)

local section_b = { fg = colors.fg_bright, bg = colors.surface }
local section_c = { fg = colors.fg, bg = colors.bg_alt }

return {
  normal = {
    a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
    b = section_b,
    c = section_c,
  },
  insert = {
    a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
    b = section_b,
    c = section_c,
  },
  visual = {
    a = { fg = colors.bg, bg = colors.magenta, gui = 'bold' },
    b = section_b,
    c = section_c,
  },
  replace = {
    a = { fg = colors.bg, bg = colors.red, gui = 'bold' },
    b = section_b,
    c = section_c,
  },
  command = {
    a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' },
    b = section_b,
    c = section_c,
  },
  terminal = {
    a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' },
    b = section_b,
    c = section_c,
  },
  inactive = {
    a = { fg = colors.gray, bg = colors.surface },
    b = { fg = colors.gray, bg = colors.surface },
    c = { fg = colors.muted, bg = colors.bg_alt },
  },
}
