
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

" gui colors in tui " this breaks things on mac!
"set termguicolors


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

nnoremap <leader><space> :noh<cr>

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
    autocmd BufWritePre *.txt,*.py,*.c,*.cpp,*.cc,*.wiki,*.sh,*.tex,*.jl :call CleanExtraSpaces()
endif

" move in editor lines not code lines
nnoremap j gj
nnoremap k gk

" prevent command from showing in last line (simply distracts me visually)
set noshowcmd

" deactivate mouse in nvi-modes.
" I don't use it and accidentally clicking bothers me!
set mouse=


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

" Table of Contents for code files
Plug 'preservim/tagbar'
nmap <leader>t :TagbarToggle<CR>

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
    "let g:vimtex_view_method='zathura'
    let g:vimtex_view_method='skim'
    let g:vimtex_quickfix_mode=0
    "" added shell-escape option to compile {minted}
    "let g:vimtex_compiler_latexmk = {
    "    \ 'options' : [
    "    \   '-pdf',
    "    \   '-shell-escape',
    "    \   '-verbose',
    "    \   '-file-line-error',
    "    \   '-synctex=1',
    "    \   '-interaction=nonstopmode',
    "    \ ],
    "    \}
    "" make code more readable
    au FileType tex set conceallevel=1
    au FileType tex let g:vimtex_syntax_conceal = {
              \ 'accents': 1,
              \ 'ligatures': 1,
              \ 'cites': 1,
              \ 'fancy': 0,
              \ 'greek': 1,
              \ 'math_bounds': 0,
              \ 'math_delimiters': 1,
              \ 'math_fracs': 0,
              \ 'math_super_sub': 0,
              \ 'math_symbols': 1,
              \ 'sections': 0,
              \ 'styles': 1,
              \}
   

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
			    \'coc-sh',
			    \'coc-pyright',
			    \'coc-vimtex',
                \'coc-html',
                \'coc-htmldjango',
			    \'coc-snippets',]
			    "\'coc-clangd', 
			    "\'coc-julia',]


" Better readable code
"Plug 'yggdroot/indentline'


" colorschemes
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = 'hard'
Plug 'arcticicestudio/nord-vim'


" check out these ones:
" find more on vimawesome.com
call plug#end()


" set colorscheme
colorscheme gruvbox
syntax on

" mark 81st column as ruler when coding
au FileType c,cpp,javascript,java,julia,python,sh set colorcolumn=81

au FileType tex call coc#config("suggest.autoTrigger", "trigger")

" disable continuing comments on multiple lines
au FileType * set fo -=ro

" set virtual environment as root for pyright [coc.nvim]
au FileType python let b:coc_root_patterns = ['.git', '.venv']

" disable completion for TeX
"au FileType tex let b:coc_suggest_disable = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC suggested config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""
" Some coc-snippet configuration
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" pick first suggested completion entry
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

""" Tab for snippets
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

"" BACKUP: original solution from github
"inoremap <silent><expr> <TAB>
"      \ coc#pum#visible() ? coc#_select_confirm() :
"      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"      \ CheckBackspace() ? "\<TAB>" :
"      \ coc#refresh()

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END COC suggested config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
