local M = {}

local terminal = {
  'background',
  'error',
  'success',
  'warning',
  'info',
  'purple',
  'cyan',
  'text_secondary',
  'overlay',
  'error',
  'success',
  'warning',
  'info',
  'purple',
  'cyan',
  'text_bright',
}

function M.apply(colors)
  for index, name in ipairs(terminal) do
    vim.g['terminal_color_' .. index - 1] = colors[name]
  end
end

function M.names()
  return vim.deepcopy(terminal)
end

return M
