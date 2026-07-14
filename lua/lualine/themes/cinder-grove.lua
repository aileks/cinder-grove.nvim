local config = require('cinder-grove.config').get()
local colors = require('cinder-grove.palette').get(config.colors)

local function mode(accent)
  return {
    a = { fg = colors.bg, bg = accent, gui = 'bold' },
    b = { fg = colors.fg_bright, bg = colors.surface },
    c = { fg = colors.fg, bg = colors.bg_alt },
  }
end

return {
  normal = mode(colors.blue),
  insert = mode(colors.green),
  visual = mode(colors.magenta),
  replace = mode(colors.red),
  command = mode(colors.yellow),
  terminal = mode(colors.cyan),
  inactive = {
    a = { fg = colors.gray, bg = colors.surface },
    b = { fg = colors.gray, bg = colors.surface },
    c = { fg = colors.muted, bg = colors.bg_alt },
  },
}
