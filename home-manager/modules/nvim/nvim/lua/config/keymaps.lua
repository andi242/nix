-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- nnoremap ,<Up>   :<C-u>silent! move-2<CR>==
-- nnoremap ,<Down> :<C-u>silent! move+<CR>==
--  xnoremap ,<Up>   :<C-u>silent! '<,'>move-2<CR>gv=gvars
--  xnoremap ,<Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv

local map = vim.keymap.set
map("n", "<A-Up>", "<cmd>move -2<cr>", { desc = "Move line up" })
map("n", "<A-Down>", "<cmd>move +1<cr>", { desc = "Move line down" })
map("n", "<S-A-Down>", "<cmd>t +0<cr>", { desc = "Move line down" })
map("n", "<S-A-Up>", "<cmd>t -1<cr>", { desc = "Move line down" })

map("n", "<A-Left>", "<cmd>wincmd h<CR>")
map("n", "<A-Right>", "<cmd>wincmd l<CR>")
