" Load pathogen bundles
execute pathogen#infect()

" Custom
set clipboard=unnamed " use os clipboard
set history=1000
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Set to auto read when a file is changed from the outside
set autoread

""""""""""""""""""
" => UI Config
""""""""""""""""""
" Colors
syntax on
colorscheme darcula

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Always show line numbers in relative mode
set number relativenumber

" Toogle relative line numbers
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
:augroup END

set showcmd

" Highlight cursor line
set cursorline

"Always show current position
set ruler

" Turn on the WiLd menu
set wildmenu

" Show matching brackets when text indicator is over them
set showmatch
set scrolloff=3
set fileformat=unix
syntax on
filetype on
filetype plugin on
filetype indent on
set splitright
set colorcolumn=80
set textwidth=80 "set tw=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" A buffer becomes hidden when it is abandoned
set hid

""""""""""""""""""""
" => Spaces & Tabs
""""""""""""""""""""
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2 
set smarttab
set ai "Auto indent
set si "Smart indent

""""""""""""""""""""
" => Searching
""""""""""""""""""""

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Makes search act like search in modern browsers
set incsearch

" Highlight search results
set hlsearch

" Complete
set complete=.,b,u,]

""""""""""""""""""""""
" => Keys mapping
""""""""""""""""""""""
let mapleader = "\<Space>"
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nmap <F3> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F3> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>
imap <Tab> <C-P>
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
" FuzzyFinder
nmap ,f :FufFileWithCurrentBufferDir<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>
inoremap <CR> <Esc>

""""""""""""""""""""""
" => Filetype setup
""""""""""""""""""""""
au FileType python setl sw=2 sts=2 et
au FileType html setl sw=2 sts=2 et

""""""""""""""""""""""
" => Plugins setup
""""""""""""""""""""""
" Custom syntastic settings:
let g:syntastic_javascript_checkers = ['closurecompiler', 'eslint', 'jshint']

function s:find_jshintrc(dir)
    let l:found = globpath(a:dir, '.jshintrc')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_jshintrc(l:parent)
    endif

    return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_jshintrc(l:dir)
    let g:syntastic_javascript_jshint_args = l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()

" Custom NERDTree settings:
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufEnter * NERDTreeMirror
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Airline setup
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1

" Emmet setup
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.vim/snippets.json')), "\n"))

