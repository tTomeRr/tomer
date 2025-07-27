-- Basic settings
vim.opt.tabstop = 2                            -- Number of spaces that a tab counts for
vim.opt.smartindent = true                     -- Smart auto-indenting
vim.opt.autoindent = true                      -- Copy indent from current line
vim.opt.shiftwidth = 2                         -- Number of spaces for each indent level
vim.opt.shiftround = true                      -- Round indent to multiple of shiftwidth
vim.opt.expandtab = true                       -- Convert tabs to spaces
vim.opt.encoding = 'utf-8'                     -- File encoding
vim.opt.number = true                          -- Show line numbers
vim.opt.relativenumber = true                  -- Show relative line numbers
vim.opt.ruler = true                           -- Show cursor position in status line
vim.opt.scrolloff = 6                          -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 5                      -- Keep 8 columns left/right of cursor
vim.opt.signcolumn = "yes"                     -- Always show sign column
vim.opt.termguicolors = true                   -- Enable 24-bit colors
vim.opt.cursorline = true                      -- Highlight current line


-- File handling
vim.opt.backup = false                         -- Don't create backup files
vim.opt.writebackup = false                    -- Don't create backup before writing
vim.opt.swapfile = false                       -- Don't create swap files
vim.opt.undofile = true                        -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 300                       -- Faster completion
vim.opt.timeoutlen = 500                       -- Key timeout duration
vim.opt.ttimeoutlen = 0                        -- Key code timeout
vim.opt.autoread = true                        -- Auto reload files changed outside vim
vim.opt.autowrite = false                      -- Don't auto save

-- Leader key
vim.g.mapleader = " "                         -- Set space as leader key

vim.keymap.set("i", "jj", "<Esc>")            -- Quick escape from insert mode

-- Disable arrow keys
vim.keymap.set("", "<Up>", "<Nop>")
vim.keymap.set("", "<Left>", "<Nop>")
vim.keymap.set("", "<Right>", "<Nop>")
vim.keymap.set("", "<Down>", "<Nop>")


-- theme & transparency
vim.cmd.colorscheme("unokai")                 
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })     
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })  
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" }) 


-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


-- Performance improvements
vim.opt.redrawtime = 10000                     
vim.opt.maxmempattern = 20000                 

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
