local config = require('cinder-grove.config').get()
local colors = require('cinder-grove.palette').get(config.colors)

local function mode(accent)
  return {
    a = { fg = colors.background, bg = accent, gui = 'bold' },
    b = { fg = colors.text_bright, bg = colors.surface },
    c = { fg = colors.text, bg = colors.container },
  }
end

return {
  normal = mode(colors.info),
  insert = mode(colors.success),
  visual = mode(colors.purple),
  replace = mode(colors.error),
  command = mode(colors.warning),
  terminal = mode(colors.cyan),
  inactive = {
    a = { fg = colors.text_subtle, bg = colors.surface },
    b = { fg = colors.text_subtle, bg = colors.surface },
    c = { fg = colors.text_muted, bg = colors.container },
  },
}
