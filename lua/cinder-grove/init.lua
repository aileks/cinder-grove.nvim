local M = {}

function M.setup(options)
  require('cinder-grove.config').setup(options)
end

function M.load()
  local config = require('cinder-grove.config').get()
  local colors = require('cinder-grove.palette').get(config.colors)

  vim.cmd('highlight clear')
  if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
  end

  vim.o.background = 'dark'
  vim.o.termguicolors = true

  require('cinder-grove.theme').apply(colors, config)
  if config.terminal_colors then
    require('cinder-grove.terminal').apply(colors)
  end

  vim.g.colors_name = 'cinder-grove'
end

return M
