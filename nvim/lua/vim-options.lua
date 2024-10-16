-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Make line numbers default
vim.wo.number = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Enable mouse mode
vim.o.mouse = ''

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Show which line your cursor is on
-- vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.expandtab=true
vim.o.shiftwidth=4
vim.o.tabstop=4

-- colorcolumns
vim.api.nvim_create_autocmd(
  {"FileType"},
  {
    pattern = {"c","cpp","python","javascript","java","julia"},
    callback = function()
      vim.o.colorcolumn="89"
    end
  }
)
vim.api.nvim_create_autocmd(
  {"FileType"},
  {
    pattern = {"sh"},
    callback = function()
      vim.o.colorcolumn="81"
    end
  }
)
vim.api.nvim_create_autocmd(
  {"BufEnter"},
  {
    pattern = {"*"},
    callback = function()
      vim.opt.formatoptions:remove('c')
      vim.opt.formatoptions:remove('r')
      vim.opt.formatoptions:remove('o')
    end
  }
)
-- vim.opt.formatoptions:remove("c")
-- vim.opt.formatoptions:remove("r")
-- vim.opt.formatoptions:remove("o")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd("colorscheme gruvbox")
-- vim.cmd("colorscheme everforest")
-- vim.cmd("colorscheme catppuccin")
