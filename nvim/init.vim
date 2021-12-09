
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" init.vim -- Author: Gerrit Wellecke
"
" complete rewrite of my original vimrc for switching to neovim
" The mentioned scripts NEED TO BE UPDATED
"
" many things taken from https://github.com/amix/vimrc
"
" to setup:
" just use the setup script from github, else:
" 1. -- install vundle
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" 2. -- install plugins
" then open vim and run :PluginInstall
"
" 3. -- install YCM
" $ cd ~/.vim/bundle/YouCompleteMe
" $ ./install.py --clang-completer
"
" this should do the job
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" height of the command bar
set cmdheight=1

" buffer becomes hidden whe it is abandoned
set hid

" ignore case when searching
set ignorecase
" when seraching try to be smart about cases
set smartcase

" show matching brackets when text indicator is over them
set showmatch
set mat=0

" time in ms to wait for a mapped sequence to complete
set tm=500

" Hide -- INSERT -- and such as already show by airline
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Unix as the standard file type
set ffs=unix,mac,dos

" line numbers
set nu

" gui colors in tui
set termguicolors


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

au FileType javascript,html,css call SetJSoptions()
function SetJSoptions()
    setlocal shiftwidth=2
    setlocal tabstop=2
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Useful mappings for managing tabs
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove 
" map <leader>t<leader> :tabnext 
" not sure if the next two will prove useful
" map <leader>l :tabnext<cr>
" map <leader>h :tabprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=1
catch
endtry

" merge clipboards
set clipboard+=unnamedplus

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    "autocmd BufWritePre *.txt,*.js,*.py,*.c,*.cpp,*.cc,*.wiki,*.sh,*.tex,*.jl :call CleanExtraSpaces()
    autocmd BufWritePre *.txt,*.c,*.cpp,*.cc,*.wiki,*.sh,*.tex,*.jl :call CleanExtraSpaces()
endif

" move in editor lines not code lines
nnoremap j gj
nnoremap k gk

" prevent command from showing in last line (simply distracts me visually)
set noshowcmd


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug auto-install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" include lilypond code for nvim
set runtimepath+=/usr/share/lilypond/2.20.0/vim/

" Vim-Plug
call plug#begin(stdpath('data') . '/plugged')

" Auto indentation for python
Plug 'vim-scripts/indentpython.vim'

" Julia support
Plug 'julialang/julia-vim'

" NERDTree file explorer
Plug 'scrooloose/nerdtree'

" autocompletion of brackets, quotes, etc
Plug 'Raimondi/delimitMate'
    let delimitMate_expand_cr=1
    " expand space in bash as it is needed by bash-syntax
    au FileType cpp,sh let b:delimitMate_expand_space=1
    " add $ to autoclose symbols to type inline math in LaTeX
    au FileType tex let b:delimitMate_quotes="\" ` $"

" status bar on the bottom
Plug 'vim-airline/vim-airline'

" LaTeX in VIM
Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
    " added shell-escape option to compile {minted}
    let g:vimtex_compiler_latexmk = {
        \ 'options' : [
        \   '-pdf',
        \   '-shell-escape',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
    " make code more readable
    au FileType tex set conceallevel=1
    au FileType tex let g:vimtex_syntax_conceal={
                \    "accents": 1,
                \    "fancy": 0,
                \    "greek": 1,
                \    "math_bounds": 1,
                \    "math_delimiters": 1,
                \    "math_fracs": 0,
                \    "math_super_sub": 0,
                \    "math_symbols": 1,
                \    "styles": 1,
                \}
   
    
Plug 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = '<C-n>'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
			    \'coc-sh',
			    \'coc-pyright',
			    \'coc-vimtex',]
			    ""\'coc-clangd', 
			    "\'coc-julia',
			    "\'coc-snippets']

" snippets
Plug 'sirver/UltiSnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'
    let g:UltiSnipsEditSplit = 'horizontal'
    let g:UltiSnipsSnippetDirectories=[stdpath('data') . '/plugged/UltiSnips']


" Better readable code
"Plug 'yggdroot/indentline'


" colorschemes
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = 'hard'
Plug 'arcticicestudio/nord-vim'

" django template highlighting
Plug 'vim-scripts/django.vim'

" check out these ones:
" find more on vimawesome.com
call plug#end()


" set colorscheme
colorscheme gruvbox
syntax on

" mark 81st column as ruler when coding
au FileType c,cpp,javascript,java,julia,python,sh set colorcolumn=81

au FileType tex noremap <leader>us :UltiSnipsEdit<CR>
au FileType tex call coc#config("suggest.autoTrigger", "trigger")

" disable continuing comments on multiple lines
au FileType * set fo -=ro

" disable completion for TeX
"au FileType tex let b:coc_suggest_disable = 1
