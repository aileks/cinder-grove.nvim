local M = {}

local terminal = {
  'bg',
  'red',
  'green',
  'yellow',
  'blue',
  'magenta',
  'cyan',
  'fg_dim',
  'muted',
  'red',
  'green',
  'yellow',
  'blue',
  'magenta',
  'cyan',
  'fg_bright',
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
