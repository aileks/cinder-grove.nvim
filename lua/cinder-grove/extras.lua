local M = {}

function M.fzf_colors()
  return {
    hl = { 'fg', 'CinderGroveOrange' },
    ['hl+'] = { 'fg', 'CinderGroveYellow' },
    fg = { 'fg', 'CinderGroveFg' },
    bg = { 'fg', 'CinderGroveBg' },
    ['fg+'] = { 'fg', 'CinderGroveFgBright' },
    ['bg+'] = { 'bg', 'Visual' },
    pointer = { 'fg', 'CinderGroveOrange' },
    marker = { 'fg', 'CinderGroveGreen' },
    prompt = { 'fg', 'CinderGroveMagenta' },
    info = { 'fg', 'CinderGroveCyan' },
    gutter = { 'fg', 'CinderGroveBg' },
    header = { 'fg', 'CinderGroveBlue' },
    border = { 'fg', 'FloatBorder' },
    spinner = { 'fg', 'CinderGroveYellow' },
    query = { 'fg', 'CinderGroveFgBright' },
    disabled = { 'fg', 'CinderGroveMuted' },
  }
end

function M.minimap()
  return {
    minimap_cursor_color = 'CinderGroveMinimapCursor',
    minimap_range_color = 'CinderGroveMinimapRange',
  }
end

return M
