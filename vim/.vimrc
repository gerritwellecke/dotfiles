"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimrc -- Author: Gerrit Wellecke
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

set nocompatible		" required




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set to auto read when a file is changed from the outside
set autoread



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
" disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" turn on the Wild menu
set wildmenu

" ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" always show current position
set ruler

" height of the command bar
set cmdheight=1

" buffer becomes hidden whe it is abandoned
set hid

" ignore case when searching
set ignorecase
" when seraching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 

" show matching brackets when text indicator is over them
set showmatch
set mat=0

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb= "not actually sure what this does
set tm=500 "not actually sure what this does


" Properly disable sound on errors on MacVim
autocmd GUIEnter * set vb t_vb=

" Hide -- INSERT -- and such as already show by airline
set noshowmode

if has("gui_macvim")
    set guifont=Menlo-Regular:h15
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,mac,dos

" line numbers
set nu




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
" set lbr
" set tw=500

set autoindent "Auto indent
"set smartindent "Smart indent -- commented out as advised to only use if unhappy with current indentation
set wrap "Wrap lines




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
  set stal=2
catch
endtry

" merge clipboards
set clipboard^=unnamed

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

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.c,*.cpp,*.cc,*.wiki,*.sh,*.tex,*.coffee :call CleanExtraSpaces()
endif

" jj as Esc in input mode
inoremap jj <Esc>

" move in editor lines not code lines
nnoremap j gj
nnoremap k gk
nnoremap J 10gj
nnoremap K 10gk



filetype off			" required


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'


" Auto indentation for python
Plugin 'vim-scripts/indentpython.vim'


" NERDTree file explorer
Plugin 'scrooloose/nerdtree'

" autocompletion of brackets, quotes, etc
Plugin 'Raimondi/delimitMate'
    let delimitMate_expand_cr=2
    " expand space in bash as it is needed by bash-syntax
    au FileType sh let b:delimitMate_expand_space=1
    " add $ to autoclose symbols to type inline math in LaTeX
    au FileType tex let b:delimitMate_quotes="\" ' ` $"

" status bar on the bottom
Plugin 'vim-airline/vim-airline'

" LaTeX in VIM
Plugin 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='skim'
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
    
" get YCM and UltiSnips to not conflict
Plugin 'ervandew/supertab'

" Autocompletion
Plugin 'Valloric/YouCompleteMe'
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
    let g:ycm_autoclose_preview_window_after_completion=1
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:ycm_max_num_candidates = 25
    let g:ycm_max_num_identifier_candidates = 5
    let g:SuperTabDefaultCompletionType = '<C-n>'

    map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
    
    " LaTeX autocompletion with YCM
    if !exists('g:ycm_semantic_triggers')
        let g:ycm_semantic_triggers = {}
    endif
    au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
    au FileType tex let g:ycm_min_num_of_chars_for_completion = 99
    " make code more readable
    au FileType tex set conceallevel=1
    au FileType tex let g:tex_conceal='abdmg'
   
" snippets
Plugin 'sirver/UltiSnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'
    let g:UltiSnipsSnippetDirectories=["bundle/UltiSnips"]

" colorschemes
Plugin 'tomasr/molokai'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'arcticicestudio/nord-vim'

" check out these ones:
" find more on vimawesome.com

call vundle#end()		    " required
filetype plugin indent on 	" required


" enable syntax highlighting
syntax on

" set colorscheme
set background=dark
colorscheme gruvbox

" mark 81st character if line is too long
" highlight LineTooLongMarker ctermbg=magenta guibg=Magenta
" au Filetype python,c,cpp call matchadd('LineTooLongMarker', '\%81v', 100)

" mark 81st column as ruler when coding
au Filetype python,c,cpp,sh set colorcolumn=81

au FileType tex noremap <leader>tt :VimtexTocOpen<CR>
