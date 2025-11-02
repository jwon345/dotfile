-- ==============================
--  Basic Neovim init.lua
-- ==============================

-- [[ Basic Settings ]]
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.tabstop = 4              -- Number of spaces per tab
vim.opt.shiftwidth = 4           -- Indent width
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.smartindent = true       -- Auto indent new lines
vim.opt.wrap = false             -- Don't wrap long lines
vim.opt.termguicolors = true     -- True color support
vim.opt.cursorline = true        -- Highlight current line
vim.opt.scrolloff = 8            -- Keep some context when scrolling
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.ignorecase = true        -- Ignore case in searches
vim.opt.smartcase = true         -- ...unless uppercase used
vim.opt.hlsearch = true          -- Highlight search results

-- ===== Visuals =====
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"        -- highlight only the number
vim.cmd([[highlight CursorLineNr gui=bold guifg=#ff4d4f]])  -- red current line number
vim.cmd([[highlight Visual guibg=#ff4d4f guifg=#1e1e1e]])   -- red Visual selection

-- ===== Highlight on yank (copy) =====
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- brief flash on yank
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- ===== Clear search highlights on Esc =====
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { silent = true })

-- Keep selection after indenting
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- ===== Keep cursor centered after <C-d>/<C-u> =====
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

-- Put this at the END of init.lua
if vim.g.vscode then
  -- Re-apply UI opts after VSCode finishes embedding
  vim.schedule(function()
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
    vim.opt.cursorlineopt = "number"  -- highlight only the line number
  end)

  -- Reassert when focus/tab changes (prevents losing relativenumber)
  vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained", "BufEnter" }, {
    callback = function()
      vim.opt.number = true
      vim.opt.relativenumber = true
    end,
  })
end
