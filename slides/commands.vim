set nowrapscan
set shiftwidth=4
set tw=200
set fdm=marker
nnoremap <space><space> /start slide<cr>zz
noremap <F4> :silent !zathura %:r-Handout.pdf &<cr>
noremap <F5> :silent !./makefile.lua Working_List.txt &<cr>
let @r='y$  lf{;;a pwDxb'
let @s='y$  lf{;;a pF l'
noremap <leader><leader> :update <cr> :AsyncRun! ./makefile.lua Working_List.txt <cr>

