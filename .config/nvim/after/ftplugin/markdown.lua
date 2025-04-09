vim.cmd("set makeprg=pandoc\\ %\\ -o\\ %:r.pdf\\ --pdf-engine=xelatex\\ &")
vim.keymap.set("n", "<leader>S", ":make<CR> :!zathura %:r.pdf & <CR><CR>")
