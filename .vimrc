" pieced together from various sources, including:
" vimcasts.org

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
set softtabstop=4               " use 4 spaces for backspace
set hidden                      " you can change buffers without saving
set listchars=tab:▸\ ,trail:-   " show tabs and trailing
"set listchars=eol:¬
set nowrap
set list
set autowrite                   " auto-save when switching buffers or shelling command
set showmatch                   " match brackets
set sidescroll=20               " show 20 more characters when scolling horizontally

"Invisible character colors
"highlight NonText guifg=#4a4a59
"highlight SpecialKey guifg=#4a4a59

"set exrc  " allows you to have .exrc files in directories that override this file
"set wrapmargin=10  " for non-program text

if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style
  autocmd FileType html setlocal ts=2 sts=2 sw=2 noexpandtab
  autocmd FileType xml setlocal ts=2 sts=2 sw=2 noexpandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 noexpandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab

  autocmd BufNewFile,BufRead *.as set filetype=actionscript
  autocmd BufNewFile,BufRead *.properties,*.targets,*.proj,*.build,*.csproj set filetype=xml

  " depends on copying contrib/vim/syntax/gitcommit.vim from git tarball to ~/.vim/syntax
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit

  " Auto strip whitespace on save for whitelisted file types
  autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()
endif

if has("gui_running")
    set lines=40
    set columns=130
    set guifont=Consolas:h12

    autocmd VimEnter * NERDTree
    autocmd VimEnter * wincmd p
    autocmd BufEnter * NERDTreeMirror
endif

" Colemak remappings; use backspace for left
noremap h k
noremap j h
noremap k j

" NERDTree remappings
cnoreabbr nt    NERDTree
cnoreabbr ntm   NERDTreeMirror

" opens commands in a new tab
"cnoreabbr <expr> h    (getcmdtype() . getcmdline() != ':h'    ? 'h'    : 'tab help')
"cnoreabbr <expr> he   (getcmdtype() . getcmdline() != ':he'   ? 'he'   : 'tab help')
"cnoreabbr <expr> hel  (getcmdtype() . getcmdline() != ':hel'  ? 'hel'  : 'tab help')
"cnoreabbr <expr> help (getcmdtype() . getcmdline() != ':help' ? 'help' : 'tab help')
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

" Strip whitespaces without changing search history or cursor position
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
