local gl = require('galaxyline')
local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

-- Functions

local colors = {
  black = '#09040A',
  yellow = '#fabd2f',
  cyan = '#008080',
  green = '#b9f27c',
  orange = '#FF8800',
  purple = '#5d4d7a',
  mid_blue = '#3a405e',
  deep_blue = '#232433', 
  magenta = '#d16d9e',
  deep_grey = '#2C323C',
  grey = '#3E4452',
  light_grey = '#C3C3C5',
  blue = '#7da6ff',
  isr_bg = '#1A1B26',
  red = '#ec5f67'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local function get_current_file_name()
    local file = vim.fn.expand '%:t'
    if vim.fn.empty(file) == 1 then
       return ' '
    end
    return file .. ''
  end

gls.left[1] = {
  FirstElement = {
    provider = function() return '▋' end,
    highlight = {colors.deep_blue,colors.deep_blue}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local alias = {
          n = 'NORMAL',
          i = 'INSERT',
          c= 'COMMAND',
          V= 'VISUAL',
          [''] = 'VISUAL',
          v ='VISUAL',
          c  = 'COMMAND-LINE',
          ['r?'] = ':CONFIRM',
          rm = '--MORE',
          R  = 'REPLACE',
          Rv = 'VIRTUAL',
          s  = 'SELECT',
          S  = 'SELECT',
          ['r']  = 'HIT-ENTER',

          [''] = 'SELECT',
          t  = 'TERMINAL',
          ['!']  = 'SHELL',
      }
      local mode_color = {
          n = colors.green,
          i = colors.blue,
          v=colors.magenta,
          [''] = colors.blue,
          V=colors.blue,
          c = colors.red,
          no = colors.magenta,
          s = colors.orange,
          S=colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.purple,
          Rv = colors.purple,
          cv = colors.red,
          ce=colors.red, 
          r = colors.cyan,
          rm = colors.cyan, 
          ['r?'] = colors.cyan,
          ['!']  = colors.green,
          t = colors.green,
          c  = colors.purple,
          ['r?'] = colors.red,
          ['r']  = colors.red,
          rm = colors.red,
          R  = colors.yellow,
          Rv = colors.magenta,
      }
      local vim_mode = vim.fn.mode()
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim_mode])
      return alias[vim_mode] .. ''
    end,
    separator = '▌',
    separator_highlight = {colors.deep_blue, colors.deep_grey},
    highlight = {colors.red,colors.deep_blue,'bold'},
  },
}

gls.left[3] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    separator = '',
    separator_highlight = {colors.deep_grey,colors.deep_blue},
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.deep_grey},
  },
}

gls.left[4] = {
  FileName = {
    provider = get_current_file_name,
    condition = buffer_not_empty,
    separator = '▌',
    separator_highlight = {colors.deep_grey,colors.mid_blue},
    highlight = {colors.light_grey,colors.deep_grey}
  }
}

gls.left[5] = {
  GitIcon = {
    provider = function() return " " end,
    condition = buffer_not_empty,
    highlight = {colors.orange,colors.mid_blue},
  }
}

gls.left[6] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.mid_blue},
  }
}

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

--[[
gls.left[7] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '4 ',
    highlight = {colors.green,colors.purple},
  }
}
gls.left[8] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '5 ',
    highlight = {colors.orange,colors.purple},
  }
}
gls.left[9] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '6 ',
    highlight = {colors.red,colors.purple},
  }
}


gls.left[10] = {
  LeftEnd = {
    provider = function() return ' ' end,
    separator = '7',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.purple,colors.purple}
  }
}

gls.left[11] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = ' 8 ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[12] = {
  Space = {
    provider = function () return ' ' end
  }
}
gls.left[13] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = ' 9 ',
    highlight = {colors.blue,colors.bg},
  }
}

--]]
--
gls.right[1]= {
  FileFormat = {
    provider = 'FileFormat',
    separator = ' ',
    separator_highlight = {colors.mid_blue,colors.mid_blue},
    highlight = {colors.light_grey,colors.mid_blue},
  }
}
gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.isr_bg,colors.mid_blue},
    highlight = {colors.light_grey,colors.mid_blue},
  },
}

gls.right[3] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {colors.mid_blue,colors.mid_blue},
    highlight = {colors.light_grey,colors.deep_blue},
  },
}

gls.right[4] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.blue,colors.deep_blue},
  }
}

--[[
gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '12',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.mid_blue,colors.mid_blue}
  }
}


gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    separator = '13',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.grey,colors.purple}
  }
}
--]]
