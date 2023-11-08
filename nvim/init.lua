vim.g.mapleader = ","
vim.wo.number = true
vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.wo.relativenumber = true
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<CR>")
vim.keymap.set("", "<C-h>", "gt")
vim.b.autoformat = true
vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])

require("lahssen.lazy")
