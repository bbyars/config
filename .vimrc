" pieced together from various sources, including:
" vimcasts.org

colorscheme torte

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
set listchars+=extends:>,precedes:< " show horizontal continuation
"set listchars=eol:¬
set nowrap
set list
set autowrite                   " auto-save when switching buffers or shelling command
set showmatch                   " match brackets
set sidescroll=20               " show 20 more characters when scolling horizontally
set mouse=a                     " allow mouse in terminal version
set foldenable                  " allow folding in syntax foldmethod
set foldcolumn=3                " show folding in margin

" Directories for swp files
set directory=~/.vim/backup
set backupdir=~/.vim/backup

"Invisible character colors
"highlight NonText guifg=#4a4a59
"highlight SpecialKey guifg=#4a4a59

"set wrapmargin=10  " for non-program text

if has("autocmd")
    " Enable file type detection
    filetype on

    " Enable intelligent indenting
    " may require set paste before pasting, and set nopaste after?
    filetype indent on

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

    autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG     setf gitcommit
    autocmd BufNewFile,BufRead *.git/config,.gitconfig  setf gitconfig
    autocmd BufNewFile,BufRead git-rebase-todo          setf gitrebase
    autocmd BufNewFile,BufRead .msg.[0-9]*
        \ if getline(1) =~ '^From.*# This line is ignored.$' |
        \   setf gitsendemail |
        \ endif
    autocmd BufNewFile,BufRead *.git/**
        \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
        \   setf git |
        \ endif

    " Auto strip whitespace on save for whitelisted file types
    autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

    " Enable filetype detection
    filetype plugin indent on

    " Restore cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

    " Auto detect filetype for extensionless files
    augroup newFileDetection
    autocmd CursorMovedI * call CheckFileType()
    augroup END
endif

if &t_Co > 2 || has("gui_running")
  " Enable syntax highlighting
  syntax on
endif

" Colemak remappings; use backspace for left
noremap h k
noremap j h
noremap k j

" TODO: Need equivalent remappings for window movements:
" remap ^W^h and ^Wh to ^Wk and capital equivalents (^W^H)
" remap ^W^k and ^Wk to ^Wj
" remap ^W^j and ^Wj to ^Wh

" NERDTree remappings
cnoreabbr nt    NERDTree
cnoreabbr ntm   NERDTreeMirror

" Opens file relative to current file
let mapleader=','
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabedit %%

" Enable sane soft-wrapping, which doesn't work in conjunction with set list
command! -nargs=* Wrap set wrap linebreak nolist

" Use the command key with navigation keys to move through displayed lines
" The default navigation is only for numbered lines, which can be disorienting with line wrapping
" TODO: Change for Colemak
" TODO: Move all colemak remappings into a separate script, or figure out how to import only if set
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

" Map autocompletion to tab key (use ^V prefix to insert literal tab)
":imap Tab <C-P>

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

" Automatically detect filetype for new files based on content
function CheckFileType()
    if exists("b:countCheck") == 0
        let b:countCheck = 0
    endif

    let b:countCheck += 1

    " Don't start detecting until approx. 20 characters in buffer
    if &filetype == "" && b:countCheck > 20 && b:countCheck < 200
        filetype detect
    endif

    " If we've exceeded the count threshold, or a filetype has been detected,
    " delete the autocmd
    if b:countCheck >= 200 || &filetype != ""
        autocmd! newFileDetection
    endif
endfunction
