local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local show_docs = function()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

local M = {"neoclide/coc.nvim"}

M.branch = "release"

M.config = function()
	vim.opt.backup = false
	vim.opt.writebackup = false
	vim.opt.updatetime = 300
	vim.opt.signcolumn = "yes"

	local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
	vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
	vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
	vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
	vim.keymap.set("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
	vim.keymap.set("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
	vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
	vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
	vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
	vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
	vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
	vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})

	vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

	vim.api.nvim_create_augroup("CocGroup", {})
	vim.api.nvim_create_autocmd("CursorHold", {
			group = "CocGroup",
			command = "silent call CocActionAsync('highlight')",
			desc = "Highlight symbol under cursor on CursorHold"
	})

	vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

	vim.api.nvim_create_autocmd("FileType", {
			group = "CocGroup",
			pattern = "typescript,json",
			command = "setl formatexpr=CocAction('formatSelected')",
			desc = "Setup formatexpr specified filetype(s)."
	})

	local opts = {silent = true, nowait = true}
	vim.keymap.set("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
	vim.keymap.set("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

	vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
	vim.keymap.set("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
	vim.keymap.set("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)
	vim.keymap.set("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
	vim.keymap.set("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
	vim.keymap.set("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

	vim.keymap.set("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


	vim.keymap.set("x", "if", "<Plug>(coc-funcobj-i)", opts)
	vim.keymap.set("o", "if", "<Plug>(coc-funcobj-i)", opts)
	vim.keymap.set("x", "af", "<Plug>(coc-funcobj-a)", opts)
	vim.keymap.set("o", "af", "<Plug>(coc-funcobj-a)", opts)
	vim.keymap.set("x", "ic", "<Plug>(coc-classobj-i)", opts)
	vim.keymap.set("o", "ic", "<Plug>(coc-classobj-i)", opts)
	vim.keymap.set("x", "ac", "<Plug>(coc-classobj-a)", opts)
	vim.keymap.set("o", "ac", "<Plug>(coc-classobj-a)", opts)


	---@diagnostic disable-next-line: redefined-local
	local opts = {silent = true, nowait = true, expr = true}
	vim.keymap.set("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
	vim.keymap.set("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
	vim.keymap.set("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
	vim.keymap.set("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
	vim.keymap.set("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
	vim.keymap.set("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


	vim.keymap.set("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
	vim.keymap.set("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

	vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
	vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

	vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

	local opts = {silent = true, nowait = true}
	vim.keymap.set("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
	vim.keymap.set("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
	vim.keymap.set("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
	vim.keymap.set("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
	vim.keymap.set("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
	vim.keymap.set("n", "<space>j", ":<C-u>CocNext<cr>", opts)
	vim.keymap.set("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
	vim.keymap.set("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
end

return M
