local M = {}

local colors = {
  bg = '#131210',
  bg_alt = '#1B1916',
  surface = '#23201C',
  muted = '#58534C',
  gray = '#9A938A',
  fg_dim = '#ACA49B',
  fg = '#BBB3A9',
  fg_bright = '#DDD5CA',
  red = '#B34A45',
  green = '#879B5C',
  yellow = '#D9A441',
  blue = '#6785A1',
  magenta = '#9A788F',
  cyan = '#58918C',
  orange = '#C87546',
}

local function is_hex(value)
  return type(value) == 'string' and value:match('^#%x%x%x%x%x%x$') ~= nil
end

function M.get(overrides)
  local resolved = vim.deepcopy(colors)

  for name, value in pairs(overrides or {}) do
    if type(name) ~= 'string' or name == '' then
      error('cinder-grove: palette names must be non-empty strings')
    end
    if not is_hex(value) then
      error(('cinder-grove: invalid color for %s: expected #RRGGBB'):format(name))
    end
    resolved[name] = value
  end

  return resolved
end

function M.defaults()
  return vim.deepcopy(colors)
end

function M.is_hex(value)
  return is_hex(value)
end

return M
