local M = {}

local defaults = {
  transparent = false,
  terminal_colors = true,
  colors = {},
  highlights = {},
}

local options = vim.deepcopy(defaults)

function M.setup(user_options)
  if user_options ~= nil and type(user_options) ~= 'table' then
    error('cinder-grove: setup options must be a table')
  end

  options = vim.tbl_deep_extend('force', vim.deepcopy(defaults), vim.deepcopy(user_options or {}))
end

function M.get()
  return vim.deepcopy(options)
end

function M.defaults()
  return vim.deepcopy(defaults)
end

return M
