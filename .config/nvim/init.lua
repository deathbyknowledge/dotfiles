-- ~/.vimrc
vim.g.mapleader = ";"
local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.number = true
opt.hlsearch = true
opt.clipboard = "unnamedplus"
opt.guicursor = "n-v-c-i:block"
vim.cmd('colorscheme wildcharm')

-- install lazy.vim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
      -- FIXED: The new way to call treesitter setup (no .configs)
      require("nvim-treesitter").setup({
        ensure_installed = { "lua", "vim", "javascript", "typescript", "rust", "python" },
        highlight = { enable = true },
      })
    end
  },
  { 
    "nvim-telescope/telescope.nvim", 
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("telescope").setup{} end
  },
})

-- lsp setup, needs:
--  npm i -g typescript-language-server
--  uv tool install ty
if vim.fn.executable("typescript-language-server") == 1 then
  vim.lsp.enable("ts_ls")
end

if vim.fn.executable("rust-analyzer") == 1 then
  vim.lsp.enable("rust_analyzer")
end

if vim.fn.executable("ty") == 1 then
  -- Define the configuration for Ty
  vim.lsp.config("ty", {
    cmd = { "ty", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
  })
  -- Enable it
  vim.lsp.enable("ty")
end

-- keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>gf', builtin.git_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>gt', builtin.lsp_type_definitions)
vim.keymap.set('n', '<leader>gs', builtin.git_status)
vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- browser search
local function open_search(visual)
    local input = ""
    if visual then
        vim.cmd('normal! "xy')
        input = vim.fn.getreg('x')
    else
        input = vim.fn.input('Search: ')
    end
    if input == "" then return end
    local url = input:find(" ") and ("https://www.google.com/search?q=" .. input:gsub(" ", "+")) or input
    os.execute('open -a "Brave Browser" ' .. '"' .. url .. '"')
end
vim.keymap.set('n', '<leader>gg', function() open_search(false) end)
vim.keymap.set('v', '<leader>gg', function() open_search(true) end)

