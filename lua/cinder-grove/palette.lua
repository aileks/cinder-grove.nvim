local M = {}

local colors = {
  bg = '#121212',
  bg_alt = '#191919',
  surface = '#212121',
  muted = '#535353',
  gray = '#949494',
  fg_dim = '#A7A7A7',
  fg = '#B4B4B4',
  fg_bright = '#D5D5D5',
  red = '#B14242',
  green = '#8A9A5B',
  yellow = '#E5A72A',
  blue = '#6284A3',
  magenta = '#95799A',
  cyan = '#4A8B8B',
  orange = '#C4693D',
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
