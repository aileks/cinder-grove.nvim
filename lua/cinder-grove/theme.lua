local M = {}

local modules = {
  'cinder-grove.groups.editor',
  'cinder-grove.groups.syntax',
  'cinder-grove.groups.treesitter',
  'cinder-grove.groups.lsp',
  'cinder-grove.groups.languages',
  'cinder-grove.integrations.ibl',
  'cinder-grove.integrations.markdown-plus',
  'cinder-grove.integrations.gitsigns',
  'cinder-grove.integrations.completion',
  'cinder-grove.integrations.navigation',
  'cinder-grove.integrations.ui',
  'cinder-grove.integrations.writing',
  'cinder-grove.integrations.neogit',
  'cinder-grove.integrations.trailblazer',
}

function M.collect(config)
  local util = require('cinder-grove.util')
  local highlights = {}

  for _, module_name in ipairs(modules) do
    util.merge_highlights(highlights, require(module_name), module_name)
  end

  if config.transparent then
    util.apply_transparency(highlights)
  end

  if type(config.highlights) ~= 'table' then
    error('cinder-grove: highlights must be a table')
  end
  for group, spec in pairs(config.highlights) do
    highlights[group] = vim.deepcopy(spec)
  end

  return highlights
end

function M.apply(colors, config)
  local util = require('cinder-grove.util')
  local resolved = {}

  for group, spec in pairs(M.collect(config)) do
    resolved[group] = util.resolve_spec(spec, colors)
  end

  for group, spec in pairs(resolved) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

function M.modules()
  return vim.deepcopy(modules)
end

return M
