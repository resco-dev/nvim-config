
-- Kanagawa Dragon tuned for a neutral grey UI and clear VS Code-like syntax.
-- Place this file at lua/plugins/kanagawa.lua when using lazy.nvim.
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon",
      transparent = false,
      compile = false,

      -- Re-map Kanagawa's palette-level yellow roles. This prevents built-in
      -- Dragon groups (including parameters, constants, and warnings) from
      -- inheriting the original yellow palette.
      colors = {
        palette = {
          dragonBlack0 = "#161616",
          dragonBlack1 = "#1F1F1F",
          dragonBlack2 = "#222222",
          dragonBlack3 = "#232323",
          dragonBlack4 = "#2A2A2A",
          dragonBlack5 = "#494949",
          dragonBlack6 = "#545454",
          sumiInk6 = "#545454",
          dragonWhite = "#D0D0D0",
          oldWhite = "#C9D1D9",

          waveBlue1 = "#363636",
          waveBlue2 = "#494949",

          -- VSS-inspired syntax colours
          dragonBlue2 = "#D2A8FF", -- functions
          dragonAqua = "#4EC9B0", -- types
          dragonGreen2 = "#A5D6FF", -- strings
          dragonPink = "#79C0FF", -- numbers
          dragonOrange = "#FFA657", -- constants / warm accents
          dragonGray = "#FFA657", -- parameters
          dragonYellow = "#C9D1D9", -- neutral identifiers; removes Dragon yellow
          dragonViolet = "#FF7B72", -- keywords
          dragonRed = "#FF7B72", -- operators / special tokens
          dragonGray2 = "#BBBEBF", -- punctuation
          dragonGray3 = "#BBBEBF",
          dragonAsh = "#8A8A8A", -- comments
          katanaGray = "#717C7C",

          -- Keep every Kanagawa yellow-named role out of yellow hues.
          carpYellow = "#A5D6FF",
          boatYellow1 = "#BBBEBF",
          boatYellow2 = "#FFA657",
          roninYellow = "#FFA657",
          autumnYellow = "#FFA657",
          winterYellow = "#34312A",

          samuraiRed = "#FF7B72",
          dragonBlue = "#569CD6",
          waveAqua1 = "#79C0FF",
          springGreen = "#4EC9B0",
          autumnGreen = "#4EC9B0",
          autumnRed = "#FF7B72",
          winterGreen = "#29332D",
          winterRed = "#342729",
          winterBlue = "#292B33",
          dragonGreen = "#4EC9B0",
          dragonTeal = "#4EC9B0",
          dragonOrange2 = "#FFA657",
          waveRed = "#FF7B72",
          springBlue = "#569CD6",
          springViolet1 = "#D2A8FF",
          waveAqua2 = "#4EC9B0",
        },
        theme = {
          all = {
            ui = {
              bg_gutter = "dragonBlack1",
            },
          },
        },
      },

      -- Palette values alone do not control every Tree-sitter, LSP semantic,
      -- or built-in editor group. These explicit groups keep them consistent.
      overrides = function(colors)
        local p = colors.palette
        local groups = {
          -- Core editor and interface
          Normal = { fg = p.oldWhite, bg = p.dragonBlack3 },
          NormalNC = { fg = p.oldWhite, bg = p.dragonBlack3 },
          SignColumn = { fg = p.dragonAsh, bg = p.dragonBlack3 },
          LineNr = { fg = p.dragonBlack6 },
          CursorLineNr = { fg = p.dragonWhite, bold = true },
          WinSeparator = { fg = p.dragonBlack5 },
          VertSplit = { fg = p.dragonBlack5 },
          EndOfBuffer = { fg = p.dragonBlack4 },
          NonText = { fg = p.dragonBlack6 },
          SpecialKey = { fg = p.dragonBlack6 },
          Folded = { fg = p.dragonAsh, bg = p.dragonBlack4 },
          FoldColumn = { fg = p.dragonAsh, bg = p.dragonBlack3 },
          Visual = { bg = p.waveBlue1 },
          Search = { fg = p.dragonBlack0, bg = p.dragonOrange },
          IncSearch = { fg = p.dragonBlack0, bg = p.dragonBlue },
          CurSearch = { fg = p.dragonBlack0, bg = p.dragonBlue },
          Pmenu = { fg = p.oldWhite, bg = p.dragonBlack4 },
          PmenuSel = { fg = p.dragonWhite, bg = p.waveBlue1, bold = true },
          PmenuSbar = { bg = p.dragonBlack5 },
          PmenuThumb = { bg = p.dragonGray2 },
          StatusLine = { fg = p.oldWhite, bg = p.dragonBlack4 },
          StatusLineNC = { fg = p.dragonAsh, bg = p.dragonBlack2 },
          TabLine = { fg = p.dragonAsh, bg = p.dragonBlack2 },
          TabLineSel = { fg = p.dragonWhite, bg = p.dragonBlack4, bold = true },
          TabLineFill = { bg = p.dragonBlack2 },
          FloatBorder = { fg = p.dragonBlack6, bg = p.dragonBlack4 },
          NormalFloat = { fg = p.oldWhite, bg = p.dragonBlack4 },
          WinBar = { fg = p.oldWhite, bg = p.dragonBlack3 },
          WinBarNC = { fg = p.dragonAsh, bg = p.dragonBlack3 },

          -- Vim syntax groups: no yellow identifier/constant/number defaults.
          Comment = { fg = p.dragonAsh, italic = true },
          String = { fg = p.dragonGreen2 },
          Character = { fg = p.dragonGreen2 },
          Number = { fg = p.dragonPink },
          Float = { fg = p.dragonPink },
          Boolean = { fg = p.dragonPink },
          Constant = { fg = p.dragonOrange },
          Identifier = { fg = p.dragonYellow },
          Function = { fg = p.dragonBlue2 },
          Statement = { fg = p.dragonViolet },
          Conditional = { fg = p.dragonViolet },
          Repeat = { fg = p.dragonViolet },
          Label = { fg = p.dragonViolet },
          Operator = { fg = p.dragonRed },
          Keyword = { fg = p.dragonViolet },
          Exception = { fg = p.dragonViolet },
          Type = { fg = p.dragonAqua },
          StorageClass = { fg = p.dragonViolet },
          Structure = { fg = p.dragonAqua },
          Typedef = { fg = p.dragonAqua },
          PreProc = { fg = p.dragonViolet },
          Include = { fg = p.dragonViolet },
          Define = { fg = p.dragonViolet },
          Macro = { fg = p.dragonViolet },
          Special = { fg = p.dragonRed },
          Delimiter = { fg = p.dragonGray2 },
          SpecialChar = { fg = p.dragonRed },
          Todo = { fg = p.dragonBlack0, bg = p.dragonBlue, bold = true },
          Underlined = { fg = p.dragonBlue, underline = true },
          Error = { fg = p.samuraiRed, bold = true },
          WarningMsg = { fg = p.dragonOrange },
          MoreMsg = { fg = p.springGreen },
          Question = { fg = p.springGreen },

          -- Tree-sitter captures, including newer captures used by Rust and others.
          ["@variable"] = { fg = p.oldWhite },
          ["@variable.builtin"] = { fg = p.dragonBlue },
          ["@variable.parameter"] = { fg = p.dragonGray },
          ["@variable.member"] = { fg = p.dragonYellow },
          ["@property"] = { fg = p.dragonYellow },
          ["@constant"] = { fg = p.dragonOrange },
          ["@constant.builtin"] = { fg = p.dragonOrange },
          ["@module"] = { fg = p.dragonAqua },
          ["@string"] = { fg = p.dragonGreen2 },
          ["@string.escape"] = { fg = p.dragonRed },
          ["@number"] = { fg = p.dragonPink },
          ["@boolean"] = { fg = p.dragonPink },
          ["@function"] = { fg = p.dragonBlue2 },
          ["@function.builtin"] = { fg = p.dragonBlue2 },
          ["@function.call"] = { fg = p.dragonBlue2 },
          ["@method"] = { fg = p.dragonBlue2 },
          ["@constructor"] = { fg = p.dragonAqua },
          ["@type"] = { fg = p.dragonAqua },
          ["@type.builtin"] = { fg = p.dragonAqua },
          ["@keyword"] = { fg = p.dragonViolet },
          ["@keyword.return"] = { fg = p.dragonViolet },
          ["@operator"] = { fg = p.dragonRed },
          ["@punctuation"] = { fg = p.dragonGray2 },
          ["@punctuation.bracket"] = { fg = p.dragonGray2 },
          ["@punctuation.delimiter"] = { fg = p.dragonGray2 },
          ["@punctuation.special"] = { fg = p.dragonRed },
          ["@attribute"] = { fg = p.dragonBlue },
          ["@comment"] = { fg = p.dragonAsh, italic = true },
          ["@comment.todo"] = { fg = p.dragonBlack0, bg = p.dragonBlue, bold = true },

          -- LSP semantic tokens (used when the server provides semantic highlighting).
          ["@lsp.type.parameter"] = { fg = p.dragonGray },
          ["@lsp.type.property"] = { fg = p.dragonYellow },
          ["@lsp.type.variable"] = { fg = p.oldWhite },
          ["@lsp.type.enumMember"] = { fg = p.dragonOrange },
          ["@lsp.type.enum"] = { fg = p.dragonAqua },
          ["@lsp.type.class"] = { fg = p.dragonAqua },
          ["@lsp.type.interface"] = { fg = p.dragonAqua },
          ["@lsp.type.type"] = { fg = p.dragonAqua },
          ["@lsp.type.function"] = { fg = p.dragonBlue2 },
          ["@lsp.type.method"] = { fg = p.dragonBlue2 },
          ["@lsp.type.keyword"] = { fg = p.dragonViolet },

          -- Diagnostics and diff accents use red/blue/green/orange, never yellow.
          DiagnosticWarn = { fg = p.dragonOrange },
          DiagnosticVirtualTextWarn = { fg = p.dragonOrange, bg = p.winterYellow },
          DiagnosticSignWarn = { fg = p.dragonOrange },
          DiagnosticUnderlineWarn = { undercurl = true, sp = p.dragonOrange },
          DiffAdd = { bg = p.winterGreen },
          DiffChange = { bg = p.winterBlue },
          DiffDelete = { bg = p.winterRed },
          DiffText = { bg = p.waveBlue1 },

          -- Common plugin groups (only take effect when the plugin defines them).
          NvimTreeNormal = { fg = p.oldWhite, bg = p.dragonBlack3 },
          NeoTreeNormal = { fg = p.oldWhite, bg = p.dragonBlack3 },
          TelescopeNormal = { fg = p.oldWhite, bg = p.dragonBlack4 },
          TelescopeBorder = { fg = p.dragonBlack6, bg = p.dragonBlack4 },
          CmpItemKind = { fg = p.dragonAqua },
          WhichKey = { fg = p.dragonBlue },
        }
        return groups
      end,
    },
  },
}
