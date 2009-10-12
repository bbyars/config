colorscheme torte
syntax on

set autoindent
set nocompatible                " make Vim behave in a more useful way
set nostartofline               " keep cursor in the same column if possible
set whichwrap=b,s,[,],<,>,h,l   " allow cursor to wrap between lines
set virtualedit=block           " allow virtual editing in Visual block mode
set lazyredraw                  " don't redraw screen while executing macros/mappings
set scrolloff=1                 " minimal number of screen lines to keep above and below the cursor
set incsearch                   " enable incremental search
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set winaltkeys=no               " allow mapping of alt (meta) key shortcuts
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set hlsearch                    " highlight search patterns
set ignorecase                  " ignore case
set smartcase                   " ignore case when the pattern contains lowercase letters only
set showtabline=2               " always show tab page labels
set number                      " display line numbers
set expandtab                   " use soft tabs
set tabstop=4                   " use 4 spaces for tabs
set shiftwidth=4                " use 4 spaces for auto-indent
set hidden                      " you can change buffers without saving
set listchars=tab:>-,trail:-    " show tabs and trailing

au BufNewFile,BufRead *.as set filetype=actionscript

au BufNewFile,BufRead *.properties set filetype=xml
au BufNewFile,BufRead *.targets set filetype=xml
au BufNewFile,BufRead *.proj set filetype=xml
au BufNewFile,BufRead *.build set filetype=xml

au BufNewFile,BufRead *.properties set tabstop=2
au BufNewFile,BufRead *.targets set tabstop=2
au BufNewFile,BufRead *.proj set tabstop=2
au BufNewFile,BufRead *.build set tabstop=2

au BufNewFile,BufRead *.properties set shiftwidth=2
au BufNewFile,BufRead *.targets set shiftwidth=2
au BufNewFile,BufRead *.proj set shiftwidth=2
au BufNewFile,BufRead *.build set shiftwidth=2

if has("gui_running")
    set lines=40
    set columns=130
    set guifont=Consolas:h12
endif

" Colemak remappings; use backspace for left
noremap h k
noremap j h
noremap k j

" NERDTree remappings
cnoreabbr nt    NERDTree
cnoreabbr ntm   NERDTreeMirror

" opens commands in a new tab
cnoreabbr <expr> h    (getcmdtype() . getcmdline() != ':h'    ? 'h'    : 'tab help')
cnoreabbr <expr> he   (getcmdtype() . getcmdline() != ':he'   ? 'he'   : 'tab help')
cnoreabbr <expr> hel  (getcmdtype() . getcmdline() != ':hel'  ? 'hel'  : 'tab help')
cnoreabbr <expr> help (getcmdtype() . getcmdline() != ':help' ? 'help' : 'tab help')
cnoreabbr <expr> e    (getcmdtype() . getcmdline() != ':e'    ? 'e'    : 'tabedit' )
cnoreabbr <expr> ed   (getcmdtype() . getcmdline() != ':ed'   ? 'ed'   : 'tabedit' )
cnoreabbr <expr> edi  (getcmdtype() . getcmdline() != ':edi'  ? 'edi'  : 'tabedit' )
cnoreabbr <expr> edit (getcmdtype() . getcmdline() != ':edit' ? 'edit' : 'tabedit' )

" (GUI) Live line reordering (very useful)
nnoremap <silent> <C-S-Up> :move .-2<CR>|
nnoremap <silent> <C-S-Down> :move .+1<CR>|
vnoremap <silent> <C-S-Up> :move '<-2<CR>gv|
vnoremap <silent> <C-S-Down> :move '>+1<CR>gv|
inoremap <silent> <C-S-Up> <C-o>:move .-2<CR>|
inoremap <silent> <C-S-Down> <C-o>:move .+1<CR>|

" Local autocomplete
inoremap <M-?> <C-p>|
inoremap <M-/> <C-n>|

" Omni completion
inoremap <C-S-Space> <C-p>|
inoremap <expr> <C-Space> (&omnifunc == '' <bar><bar> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>")
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"Tip #1386, Make Vim completion popup menu work just like in an IDE
set completeopt=longest,menuone
inoremap <expr> <C-n> pumvisible() ? "\<lt>C-n>" : "\<lt>C-n>\<lt>C-r>=pumvisible() ? \"\\<lt>Down>\" : \"\"\<lt>CR>"
inoremap <expr> <M-;> pumvisible() ? "\<lt>C-n>" : "\<lt>C-x>\<lt>C-o>\<lt>C-n>\<lt>C-p>\<lt>C-r>=pumvisible() ? \"\\<lt>Down>\" : \"\"\<lt>CR>"

