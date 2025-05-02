local M = { 'neoclide/coc.nvim' }

M.branch = "release"

M.config = function()
	vim.g["coc_global_extensions"] = {
		"coc-rust-analyzer",
		"coc-clangd",
		"coc-pyright",
		"coc-lua",
		"coc-markdownlint",
		"coc-json",
		"coc-yaml",
	}
	vim.opt.backup = false
	vim.opt.writebackup = false
	vim.opt.updatetime = 300
	vim.opt.signcolumn = "yes"

	function _G.check_back_space()
		local col = vim.fn.col('.') - 1
		return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
	end

	local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
	Imap("<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
	Imap("<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
	Imap("<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
	Imap("<c-j>", "<Plug>(coc-snippets-expand-jump)")
	Imap("<c-space>", "coc#refresh()", { silent = true, expr = true })
	Nmap("[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
	Nmap("]g", "<Plug>(coc-diagnostic-next)", { silent = true })
	Nmap("gd", "<Plug>(coc-definition)", { silent = true })
	Nmap("gy", "<Plug>(coc-type-definition)", { silent = true })
	Nmap("gi", "<Plug>(coc-implementation)", { silent = true })
	Nmap("gr", "<Plug>(coc-references)", { silent = true })


	-- Use K to show documentation in preview window
	function _G.show_docs()
		local cw = vim.fn.expand('<cword>')
		if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
			vim.api.nvim_command('h ' .. cw)
		elseif vim.api.nvim_eval('coc#rpc#ready()') then
			vim.fn.CocActionAsync('doHover')
		else
			vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
		end
	end

	Nmap("K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

	vim.api.nvim_create_augroup("CocGroup", {})
	vim.api.nvim_create_autocmd("CursorHold", {
		group = "CocGroup",
		command = "silent call CocActionAsync('highlight')",
		desc = "Highlight symbol under cursor on CursorHold"
	})

	Nmap("<leader>rn", "<Plug>(coc-rename)", { silent = true })

	vim.api.nvim_create_autocmd("FileType", {
		group = "CocGroup",
		pattern = "typescript,json",
		command = "setl formatexpr=CocAction('formatSelected')",
		desc = "Setup formatexpr specified filetype(s)."
	})

	local opts = { silent = true, nowait = true }
	Xmap("<leader>a", "<Plug>(coc-codeaction-selected)", opts)
	Nmap("<leader>a", "<Plug>(coc-codeaction-selected)", opts)
	Nmap("<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
	Nmap("<leader>as", "<Plug>(coc-codeaction-source)", opts)
	Nmap("<leader>qf", "<Plug>(coc-fix-current)", opts)
	Nmap("<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
	Xmap("<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
	Nmap("<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
	Nmap("<leader>cl", "<Plug>(coc-codelens-action)", opts)


	vim.keymap.set({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)", opts)
	vim.keymap.set({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)", opts)
	vim.keymap.set({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)", opts)
	vim.keymap.set({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)", opts)
	Nmap("<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
	Nmap("<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
	Imap("<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
	Imap("<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
	vim.keymap.set("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
	vim.keymap.set("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


	Nmap("<C-s>", "<Plug>(coc-range-select)", { silent = true })
	Xmap("<C-s>", "<Plug>(coc-range-select)", { silent = true })

	vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
	vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
	vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

	local opts = { silent = true, nowait = true }
	Nmap("<space>a", ":<C-u>CocList diagnostics<cr>", opts)
	Nmap("<space>e", ":<C-u>CocList extensions<cr>", opts)
	Nmap("<space>c", ":<C-u>CocList commands<cr>", opts)
	Nmap("<space>o", ":<C-u>CocList outline<cr>", opts)
	Nmap("<space>s", ":<C-u>CocList -I symbols<cr>", opts)
	Nmap("<space>j", ":<C-u>CocNext<cr>", opts)
	Nmap("<space>k", ":<C-u>CocPrev<cr>", opts)
	Nmap("<space>p", ":<C-u>CocListResume<cr>", opts)
end

return M
