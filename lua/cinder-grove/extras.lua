local M = {}

function M.fzf_colors()
  return {
    hl = { 'fg', 'CinderGroveSecondary' },
    ['hl+'] = { 'fg', 'CinderGroveWarning' },
    fg = { 'fg', 'CinderGroveText' },
    bg = { 'fg', 'CinderGroveBackground' },
    ['fg+'] = { 'fg', 'CinderGroveTextBright' },
    ['bg+'] = { 'bg', 'Visual' },
    pointer = { 'fg', 'CinderGroveSecondary' },
    marker = { 'fg', 'CinderGrovePrimary' },
    prompt = { 'fg', 'CinderGrovePurple' },
    info = { 'fg', 'CinderGroveCyan' },
    gutter = { 'fg', 'CinderGroveBackground' },
    header = { 'fg', 'CinderGroveInfo' },
    border = { 'fg', 'FloatBorder' },
    spinner = { 'fg', 'CinderGroveWarning' },
    query = { 'fg', 'CinderGroveTextBright' },
    disabled = { 'fg', 'CinderGroveTextMuted' },
  }
end

function M.minimap()
  return {
    minimap_cursor_color = 'CinderGroveMinimapCursor',
    minimap_range_color = 'CinderGroveMinimapRange',
  }
end

return M
