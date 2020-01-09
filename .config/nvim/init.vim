let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
" My plugins
Plug 'jwalton512/vim-blade'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
Plug 'dart-lang/dart-vim-plugin'
Plug 'wakatime/vim-wakatime'
Plug 'mattn/emmet-vim'
Plug 'chiel92/vim-autoformat'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'thosakwe/vim-flutter'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'git-time-metric/gtm-vim-plugin'
Plug 'joonty/vdebug'
call plug#end()

set bg=dark
set go=a
set mouse=a
set hlsearch
set clipboard=unnamedplus

" Some basics:
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set ignorecase
set smartcase
set incsearch
map <silent> <leader><cr> :noh<cr>
" Solarized
let g:solarized_termtrans=1
colorscheme solarized
" Text tab and indent
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set autoindent
set smartindent
set wrap
" Enable autocompletion:
set wildmode=longest,list,full
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Turn persistent undo on
try
    set undodir=/tmp/nvim/undodir
    set undofile
catch
endtry

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Nerd tree
map <leader>nn :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>
map <leader>nb :NERDTreeFromBookmark<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimling:
nm <leader>d :call ToggleDeadKeys()<CR>
imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
nm <leader>i :call ToggleIPA()<CR>
imap <leader>i <esc>:call ToggleIPA()<CR>a
nm <leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Save file
map <leader>w :w<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


" Check file in shellcheck:
map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
map <leader>b :vsp<space>$BIB<CR>
map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>cp :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex<cr>
let g:vimwiki_list = [{'path': '~/repos/writings', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writting
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost *bmdirs,*bmfiles !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" Update dwmbar when changed.
autocmd BufWritePost *dwmbar !kill $(ps aux | grep 'sh' | grep 'dwmbar' | awk '{print $2}') & dwmbar &

" Super Retab
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

" GitGutter Plugin
autocmd BufWritePost * GitGutter

" Fugitive Plugin
map <leader>g :G<cr>

" Ctrl-p Plugin
let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee\|dist\|build'

" Personal Configuration
" Auto Format on Save
noremap <F3> :Autoformat<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" COC
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
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Flutter
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>
