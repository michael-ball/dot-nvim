call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'
Plug 'chriskempson/base16-vim'
Plug 'luisjure/csound-vim', { 'for': 'csound' }
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'for': 'go' }
Plug 'godoctor/godoctor.vim', { 'for': 'go' }
Plug 'Yggdroot/indentLine'
Plug 'Shougo/neco-syntax'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'ervandew/supertab'
Plug 'wellle/tmux-complete.vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'jodosha/vim-godebug', { 'for': 'go' }
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'natebosch/vim-lsc'
Plug 'junegunn/vim-plug'
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
    autocmd FileType go set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab
    autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2 et
    autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 et

    " only show ruler for python
    autocmd FileType * if &filetype == 'python' | match ErrorMsg '\%>79v.\+' | else | match ErrorMsg '' | endif
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
colors base16-classic-dark

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

" NERDTree configuration
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

noremap <F8> :NERDTreeToggle<CR>

" vim-lsc configuration
let g:lsc_server_commands = {'rust': 'rls',
    \ 'javascript': 'javascript-typescript-stdio',
    \ 'python': 'pyenv exec pyls',
    \ 'vue': 'vls',
    \ 'elixir': 'language_server.sh',
    \ 'c': 'ccls',
    \ 'cpp': 'ccls'
    \ }

let g:lsc_auto_map = v:true " Use defaults
noremap <F2> :LSClientRename<CR>

" Ale configuration 
let g:ale_completion_enabled = 0  " disable completion
let g:ale_set_highlights = 0
let g:airline#extensions#ale#enabled = 1
let g:ale_set_balloons = 1
if !has('gui-running')
    set mouse=a
endif

let g:ale_fixers = {
            \ 'python': ['yapf'],
\}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Vimux configuration

let g:VimuxUseNearest = 0
let g:VimuxResetSequence = ""

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

" Undotree configuration
nnoremap <F5> :UndotreeToggle<cr>

let g:indentLine_char = '▏'
set list lcs=tab:\|\ 
au FileType help set nolist
au FileType help IndentLinesDisable

" vim-go setup
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_metalinter_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

autocmd FileType qf nmap <buffer> <cr> <cr>:lcl<cr><Paste>
au FileType go nmap <silent> po :Denite decls<CR>
au FileType go nmap <silent> gd <Plug>(go-def)
au FileType go nmap <silent> <F2> :GoRename<CR>
au FileType go nmap <silent> fr :GoReferrers<CR>

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

au TermOpen * setlocal nonumber norelativenumber
au TermOpen * match ErrorMsg ''
tnoremap <Esc> <C-\><C-n>
