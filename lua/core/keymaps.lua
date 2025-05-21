local global = vim.g
local o = vim.o
local opt = vim.opt

vim.scriptencoding = "utf-8"

-- Map <leader>

global.mapleader = " "
global.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Editor options
o.number = true -- display number
o.relativenumber = true

opt.backspace = '2'
opt.showcmd = true
opt.laststatus = 2
opt.autowrite = true
opt.cursorline = true

-- Use spaces for tabs
opt.tabstop = 2        -- number of spaces inserted for tab character
opt.shiftwidth = 2     -- number of spaces inserted for each indentation level
opt.shiftround = true  --
opt.expandtab = true   --converts tabs to spaces
opt.smartindent = true -- enable smart indentation
opt.breakindent = true -- enable line breaking indentation

-- General behaviors
opt.backup = false            -- disable backup file creation
opt.clipboard = "unnamedplus" -- enable system clipboard access
opt.conceallevel = 0          -- show concealed characters in markdown files
-- opt.showmode = false -- removes insert display like -- insert --
opt.splitbelow = true         -- force horizontal splits right of current window
opt.termguicolors = true      -- enable term GUI colors
opt.undofile = true           -- enable persistent undo
opt.updatetime = 100          -- set faster completion
opt.writebackup = false       -- prevent editing of files being edited elsewhere

-- Searching behavior
opt.hlsearch = true   -- highlight all matches in search
opt.ignorecase = true -- ignore case in search
opt.smartcase = true  -- match case if explicitly stated


vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper   window" })

-- Easily split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- 🔍 Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Grep text in project" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List open buffers" })

-- lsp format current format
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end, { desc = "Format file" })

map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format with Conform" })

-- Hover doc (K is default, just a reminder)
map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })

-- Git signs keymaps
-- Safe require for gitsigns
local ok, gs = pcall(require, "gitsigns")
if ok then
  vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Git Hunk" })
  vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Git Hunk" })
  vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
  vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Git Blame Line" })
  vim.keymap.set("n", "]g", gs.next_hunk, { desc = "Next Git Hunk" })
  vim.keymap.set("n", "[g", gs.prev_hunk, { desc = "Prev Git Hunk" })
end

-- lazy git commands
vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { desc = "Open LazyGit" })

-- Tab navigation (like VS Code)
vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })


vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment on line" })

vim.keymap.set("v", "<leader>/", function()
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment in selection" })

vim.keymap.set("n", "<leader>tg", ":TermExec cmd='lazygit'<CR>", { desc = "Toggle Lazygit Terminal" })

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local wk_ok, wk = pcall(require, "which-key")
    if not wk_ok then return end

    wk.register({
      ["<leader>f"] = { name = "+find" },
      ["<leader>x"] = { name = "+trouble" },
      ["<leader>t"] = { name = "+terminal" },
      ["<leader>g"] = { name = "+git" },
    })
  end
})

vim.keymap.set("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Restore Session" })

vim.keymap.set("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end, { desc = "Restore Last Session" })

vim.keymap.set("n", "<leader>qd", function()
  require("persistence").stop()
end, { desc = "Don't Save Session" })

vim.keymap.set("n", "<leader>F", function()
  require("conform").format({ async = true })
end, { desc = "Format buffer" })
