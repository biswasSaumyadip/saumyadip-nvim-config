-- init.lua

-- Define the path to lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"

-- Check if lazy.nvim is installed, if not, clone it
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("lazy.nvim installed.")
else
  print("lazy.nvim already installed.")
end

-- Add the lazy.nvim directory to the runtimepath
vim.opt.rtp:prepend(lazypath)
print("Runtime path set to: " .. lazypath)

-- Load core keymaps
require("core.keymaps")

-- Initialize lazy.nvim to manage plugins
require("lazy").setup(require("core.plugins"))

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "dist",
      "build",
      ".git",
      ".next",
      ".cache",
      ".angular",
      ".vscode",
      ".idea",
      ".turbo",
      "coverage",
      "tmp",
      "logs",
      "__pycache__",
      "target",    -- Rust/Cargo
      "%.lock",    -- lock files
      "%.sqlite3", -- SQLite DBs
      "%.ipynb",   -- Jupyter notebooks
      "%.pdf",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.webp",
      "%.svg",
      "%.mp4",
      "%.mp3",
      "%.zip",
      "%.tar",
      "%.gz",
      "%.7z",
      "%.exe",
      "%.dll",
      "%.DS_Store",
      "%.class",
      "%.o",
      "%.obj",
      "%.so",
      "%.a",
      "%.bin",
      "%.log"
    },
  }
}
