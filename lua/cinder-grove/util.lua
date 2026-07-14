local M = {}

local color_fields = {
  fg = true,
  bg = true,
  sp = true,
}

function M.merge_highlights(target, source, source_name)
  for group, spec in pairs(source) do
    if target[group] ~= nil then
      error(('cinder-grove: duplicate highlight %s in %s'):format(group, source_name))
    end
    target[group] = vim.deepcopy(spec)
  end

  return target
end

function M.resolve_spec(spec, colors)
  if type(spec) ~= 'table' then
    error('cinder-grove: highlight specs must be tables')
  end

  local resolved = vim.deepcopy(spec)
  for field in pairs(color_fields) do
    local value = resolved[field]
    if type(value) == 'string' and value ~= 'NONE' then
      if not require('cinder-grove.palette').is_hex(value) then
        value = colors[value]
        if value == nil then
          error(('cinder-grove: unknown palette color %s'):format(resolved[field]))
        end
      end
      resolved[field] = value
    end
  end

  return resolved
end

function M.apply_transparency(highlights)
  local groups = {
    'Normal',
    'NormalNC',
    'EndOfBuffer',
    'FoldColumn',
    'LineNr',
    'SignColumn',
    'WinBar',
    'WinBarNC',
  }

  for _, group in ipairs(groups) do
    if highlights[group] then
      highlights[group].bg = nil
    end
  end
end

return M
