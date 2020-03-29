call plug#begin('~/.local/share/nvim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'luisjure/csound-vim', { 'for': 'csound' }
Plug 'junegunn/goyo.vim' | Plug 'junegunn/limelight.vim'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'supercollider/scvim'
Plug 'godlygeek/tabular'
Plug 'wellle/tmux-complete.vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'plasticboy/vim-markdown'

" vim-markdown-composer
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo +stable build --release --locked
    else
      !cargo +stable build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
" END vim-markdown-composer

Plug 'junegunn/vim-plug'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'benmills/vimux'

call plug#end()

" General configuration

let g:loaded_python_provider = 1
let g:python3_host_prog = $HOME . '/.local/share/pyenv/versions/py3nvim/bin/python'

set rnu
set number
syntax on
set hlsearch
set incsearch
set backspace=indent,eol,start
set visualbell
filetype on
filetype plugin on
filetype plugin indent on
set clipboard+=unnamedplus

if has('autocmd')
    " set different indent rules
    autocmd FileType make setlocal tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
    autocmd FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

    " only show ruler for python
    autocmd BufEnter * if &filetype == 'python' | match ErrorMsg '\%>159v.\+' | else | match ErrorMsg '' | endif
    " wrap markdown, restructuredtext and regular text but don't wrap anything else
    autocmd FileType markdown setlocal wrap
    autocmd FileType rst setlocal wrap
    autocmd FileType text setlocal wrap

    " terminal setup
    autocmd TermOpen * startinsert
    autocmd TermOpen * setlocal scrollback=100000
    autocmd TermOpen * setlocal modified
    autocmd TermOpen * setlocal bufhidden=hide
    autocmd TermOpen * setlocal statusline=%{b:term_title}
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * match ErrorMsg ''
endif

set expandtab
set nowrap
set shiftwidth=4
set softtabstop=4
set smarttab
set encoding=utf-8
set nofoldenable
set linebreak
set showbreak=↪\ 
set breakindent

" Look/feel configuration 

if !has('gui-running')
    set termguicolors
endif
set background=dark
colors base16-horizon-dark

" Airline configuration

function! CurrentSymbol()
    if exists("b:coc_current_function") && get(b:, 'coc_current_function', '') =~ '.\+'
        return ' > ' . get(b:, 'coc_current_function', '')
    else
        return ' '
    endif
endfunction

let g:airline_skip_empty_sections = 1
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1
let g:airline_section_a = airline#section#create(['paste', 'mode'])
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.paste = '📋 '
let airline#extensions#coc#error_symbol = '✕ :'
let airline#extensions#coc#warning_symbol = '⚠ :'
let g:airline#extensions#whitespace#enabled = 0
call airline#parts#define_raw('linenr', '%l')
call airline#parts#define_accent('linenr', 'bold')
call airline#parts#define_raw('colnmr', '%c')
call airline#parts#define_accent('colnmr', 'italic')
call airline#parts#define_function('currfunc', 'CurrentSymbol')
let g:airline_section_c = airline#section#create(['%<', 'file', ' ', 'readonly', 'currfunc', 'coc_status'])
let g:airline_section_z = airline#section#create(['%3p%%  ', 'linenr', ':', 'colnmr'])
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#coc#enabled = 1

" Gitgutter configuration

let g:gitgutter_sign_added = '█'
let g:gitgutter_sign_modified = '█'
let g:gitgutter_sign_removed = '█'
let g:gitgutter_sign_modified_removed = '█'
let g:gitgutter_diff_args = '-w --ignore-blank-lines'

" fugitive configuration
nnoremap <leader>g :<C-u>Gstatus<cr>

" NERDTree configuration
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

noremap <F8> :NERDTreeToggle<CR>

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

" Undotree configuration
nnoremap <F5> :UndotreeToggle<cr>

let g:indentLine_char = '▏'
let g:indentLine_defaultGroup = 'Whitespace'
set list lcs=tab:\▏\ 
au FileType help set nolist
au FileType help IndentLinesDisable
au TermOpen * IndentLinesDisable
au TermOpen * set nolist

autocmd FileType qf nmap <buffer> <cr> <cr>:lcl<cr><Paste>

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

tnoremap <Esc> <C-\><C-n>

" Vim markdown
let g:vim_markdown_folding_disabled = 1

" Goyo (distraction-free mode)
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

map <Leader>z :Goyo<CR><CR>
xmap <Leader>z :Goyo<CR>

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

let g:term_buf = 0
let g:term_win = 0

function! Term_toggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize ". a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            keepalt file Terminal
            let g:term_buf = bufnr("")
        endtry
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <Leader>t :call Term_toggle(15)<CR>

" coc.nvim settings
" Plugins
let g:coc_global_extensions = [
      \'coc-css',
      \'coc-elixir',
      \'coc-go',
      \'coc-html',
      \'coc-json',
      \'coc-lists',
      \'coc-python',
      \'coc-rls',
      \'coc-sh',
      \'coc-tsserver',
      \'coc-yaml'
      \]
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <F3> :<C-u>CocList buffers<cr>
nnoremap <silent> <F4> :<C-u>CocList files<cr>
nnoremap <silent> <F6> :<C-u>CocList grep<cr>
" Find symbol of current document
nnoremap <silent> gO  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> ws  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" I like comments in italics
highlight Comment cterm=italic gui=italic

" SCVim
let g:scFlash = 1
