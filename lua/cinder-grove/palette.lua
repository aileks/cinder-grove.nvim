local M = {}

local colors = {
  background = '#131210',
  container = '#1B1916',
  surface = '#23201C',
  overlay = '#58534C',
  text_muted = '#58534C',
  text_subtle = '#9A938A',
  text_secondary = '#ACA49B',
  text = '#BBB3A9',
  text_bright = '#DDD5CA',
  primary = '#C87546',
  secondary = '#879B5C',
  error = '#B34A45',
  warning = '#D9A441',
  success = '#879B5C',
  info = '#6785A1',
  purple = '#9A788F',
  cyan = '#58918C',
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
