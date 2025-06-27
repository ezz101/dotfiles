" ftplugin/tex.vim
" Minimal LaTeX ftplugin for Neovim

" Enable spell check
setlocal spell
setlocal spelllang=en_us

" Find project root (where main.tex is located)
function! FindProjectRoot()
  let l:current_file = expand('%:p')
  let l:current_dir = expand('%:p:h')
  
  " Start from current directory and walk up
  let l:search_dir = l:current_dir
  while l:search_dir != '/'
    if filereadable(l:search_dir . '/main.tex')
      return l:search_dir
    endif
    let l:search_dir = fnamemodify(l:search_dir, ':h')
  endwhile
  
  " Fallback to current directory
  return l:current_dir
endfunction

" Set errorformat for LaTeX
setlocal errorformat=
    \%E!\ LaTeX\ %trror:\ %m,
    \%E!\ %m,
    \%+WLaTeX\ %tarning:\ %m,
    \%+W%.%#Warning:\ %m,
    \%Cl.%l\ %m,
    \%+C\ \ %m.,
    \%+C%.%#-%.%#,
    \%+C%.%#[]%.%#,
    \%+C[]%.%#,
    \%+C%.%#%[{}\\]%.%#,
    \%+C<%.%#>%.%#,
    \%C\ \ %m,
    \%-GSee\ the\ LaTeX%m,
    \%-GType\ \ H\ <return>%m,
    \%-G\ ...%.%#,
    \%-G%.%#\ (C)\ %.%#,
    \%-G(see\ the\ transcript%.%#),
    \%-G\\s%#,
    \%+O(%f)%r,
    \%+P(%f%r,
    \%+P\ %\\=(%f%r,
    \%+P%*[^()](%f%r,
    \%+P[%\\d%[^()]%#(%f%r,
    \%+Q)%r,
    \%+Q%*[^()])%r,
    \%+Q[%\\d%*[^()])%r

" Set makeprg for LaTeX compilation
function! SetMakeprg()
  let l:project_root = FindProjectRoot()
  let l:build_dir = l:project_root . '/build'
  
  " Create build directory if it doesn't exist
  if !isdirectory(l:build_dir)
    call mkdir(l:build_dir, 'p')
  endif
  
  " Set makeprg to compile main.tex from project root
  let &l:makeprg = 'cd ' . shellescape(l:project_root) . ' && pdflatex -interaction=nonstopmode -output-directory=build main.tex'
endfunction

function! BuildLatex()
  " Save current file
  silent write

  " Set up makeprg
  call SetMakeprg()

  " Run make silently, suppressing output
  silent! make | redraw!

  " Check quickfix list for actual errors
  let l:qflist = getqflist()
  let l:has_errors = 0
  for l:item in l:qflist
    if has_key(l:item, 'type') && l:item.type ==# 'E'
      let l:has_errors = 1
      break
    endif
  endfor

  if l:has_errors
    copen
    echomsg 'Build failed - check quickfix window'
  else
    cclose
    echomsg 'LaTeX build successful'
  endif
endfunction
" Open PDF with Zathura
function! OpenPdf()
  let l:project_root = FindProjectRoot()
  let l:pdf_file = l:project_root . '/build/main.pdf'
  
  if filereadable(l:pdf_file)
    call system('zathura ' . shellescape(l:pdf_file) . ' &')
    echo 'Opened PDF with Zathura'
  else
    echo 'PDF file not found: ' . l:pdf_file
  endif
endfunction

" Key mappings
nnoremap <buffer> <leader>c :call BuildLatex()<CR>
nnoremap <buffer> <leader>S :call OpenPdf()<CR>
