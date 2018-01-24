call plug#begin('~/.local/share/nvim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'ervandew/supertab'
Plug 'wellle/tmux-complete.vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'benmills/vimux'

call plug#end()

" General configuration

let g:loaded_python_provider = 1
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'

set rnu
set number
syntax on
set hlsearch
set incsearch
set backspace=indent,eol,start
filetype on
filetype plugin on
filetype plugin indent on

if has('autocmd')
    " set different indent rules
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
    autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2 et
    autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 et

    " only show ruler for python
    autocmd FileType python match ErrorMsg '\%>80v.\+'
endif

set et
set nowrap
set sw=4
set smarttab
set encoding=utf-8

let g:deoplete#enable_at_startup = 1

" Look/feel configuration 

if !has('gui-running')
    let base16colorspace=256
endif
set background=dark
colors base16-default-dark

" Airline configuration
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_a = airline#section#create(['paste', 'mode'])
let g:airline_symbols.paste = 'PASTE - '
let g:airline_symbols.linenr = ''
let g:airline_symbols.columnr = ''
let g:airline#extensions#whitespace#enabled = 0
call airline#parts#define_raw('linenr', '%l')
call airline#parts#define_accent('linenr', 'bold')
let g:airline_section_z = airline#section#create(['%3p%%  ', g:airline_symbols.linenr .' ', 'linenr', ':%c '])

" Gitgutter configuration

let g:gitgutter_sign_added = '█'
let g:gitgutter_sign_modified = '█'
let g:gitgutter_sign_removed = '█'
let g:gitgutter_sign_modified_removed = '█'
let g:gitgutter_diff_args = '-w --ignore-blank-lines'

" Indent guides configuration
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', '__Tagbar__']
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=234
hi IndentGuidesEven ctermbg=235

" NERDTree configuration
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

noremap <F8> :NERDTreeToggle<CR>

" LanguageClient configuration
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'go': ['go-langserver'],
    \ 'python': ['pyls']
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Vimux configuration

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>
" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" Denite settings

nnoremap <silent> <F3> :Denite buffer<CR>
nnoremap <silent> <F4> :Denite file_rec<CR>
nnoremap <silent> fr :Denite references<CR>
nnoremap <silent> o :Denite documentSymbol<CR>
nnoremap <silent> po :Denite workspaceSymbol<CR>

" Undotree configuration
nnoremap <F5> :UndotreeToggle<cr>
