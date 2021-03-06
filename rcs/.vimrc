set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set path+=**
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Utilities
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'

" Colorscheme for glsl
Plugin 'tikhomirov/vim-glsl'

" Colorscheme and shows json errors
Plugin 'elzr/vim-json'

" Base16 colorscheme for vim
Plugin 'danielwe/base16-vim'

" C++ Plugins for formatting and auto completion
Plugin 'thraix/YCM-Generator'
Plugin 'Valloric/YouCompleteMe'

" LaTeX autocompletion?
Plugin 'lervag/vimtex'

call vundle#end()

filetype plugin indent on

let g:indentLine_conceallevel=2 " Show indentation lines
let g:vim_json_syntax_conceal=0 " Disable concealments in json files
let g:tex_flavor = "latex"


set langmenu=en_US
let $LANG = 'en_US'

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set winaltkeys=no

set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Colorscheme
syntax enable
set background=dark
set t_Co=256

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

hi link YcmErrorSection Error

" Show error if end of line is whitespace
hi link ExtraWhitespace Error
hi link TexFix Error

hi YcmWarningSign ctermfg=18 ctermbg=3
hi YcmWarningSection ctermfg=18 ctermbg=3

" Switch header/cpp
noremap <C-s> :call SwitchSourceHeader()<CR>

" Move current buffer to next/prev tab
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>
" Move around tabs
noremap <C-b> :tabm -1<CR>
noremap <C-n> :tabm +1<CR>

noremap <C-o> :NERDTree<CR>
noremap <C-q> :q<CR>
noremap <C-w> :w<CR>
noremap <C-f> :find 
map <F12> :!makegen<CR>

" Format the code and center cursor
noremap <S-tab> gg=G''zz
noremap <C-G> :YcmCompleter GoToInclude<CR>

" Center when going to next search
noremap n nzz
noremap N Nzz


" Make search appear in the center of the screen
cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'

set undofile
set undolevels=1000
set undoreload=10000
set laststatus=2                " Always show filename in bottom of vim
set wildignorecase              " Ignore tab completion case
set ignorecase                  " Ignore searching case
set wildignore+=**/node_modules/**
set wildignore+=**/bin/**
set comments=sl:/*,mb:\ *,elx:\ */
set conceallevel=0              " Disable all concealments
set backspace=indent,eol,start
set clipboard=unnamedplus       " Save all clipboard data to OS clipboard?
set cursorline                  " Show a cursor line
set lazyredraw                  " Don't redraw when executing macros
set showmode                    " Show commands allowed in insertmode
set mouse=a                     " Allow mouse in terminal
set nocompatible                " No need to make Vim Vi-compatible
set autoindent                  " Copy indent from previous line when using o-command
set smartindent                 " Mainly follows c-style indentation when typing code
set tabstop=2                   " tab width is 2 spaces
set shiftwidth=2                " indent also with 2 spaces
set expandtab                   " expand tabs to spaces
set wrap                        " Make lines wrap if they go out of the screen (only visually)
set linebreak
set textwidth=0
set wrapmargin=0
set showcmd                     " Show what commands are currently being writter (eg 10"+yy)
set wildmenu                    " Show tab autocompletion
set number                      " Show which line number you are on
set relativenumber              " Show all other lines relative to current one

" Set shader files to glsl file format
autocmd! BufNewFile,BufRead *.shader set filetype=glsl

" Disable arrow keys, because we are Vim users right?
map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>
" Sometimes I type swedish in vim so this bind enters the command line on swedish keyboard.
noremap Ö :

" There is probably a reason why I added these manually
noremap h <left>
noremap j g<down>
noremap k g<up>
noremap l <right>

noremap <S-j> 10j
noremap <S-k> 10k

" Shows indentation as a pipe
let g:indentLine_char = '|'

" Switches between header and source files.
" If in a source file and the h file doesn't exist nothing happens.
" Should maybe change it to open .h file or .cpp file.
function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp" || expand("%:e") == "cc" || expand("%:e") == "c")
    if filereadable(join([expand("%<"),".h"],""))
      e %:r.h
    elseif filereadable(join([expand("%<"),".hpp"],""))
      e %:r.hpp
    else
      let l:confirmed = confirm("Cpp file doesn't exist. Do you want to create it?", "&Yes\n&No\nYes as &hpp", 3)
      if l:confirmed == 1
        e %:r.h
      elseif l:confirmed == 3
        e %:r.hpp
      endif
    end
  elseif (expand ("%:e") == "hpp" || expand("%:e") == "h")
    if filereadable(join([expand("%<"),".cc"],""))
      e %:r.cc
    elseif filereadable(join([expand("%<"),".cpp"],""))
      e %:r.cpp
    elseif filereadable(join([expand("%<"),".c"],""))
      e %:r.c
    else
      let l:confirmed = confirm("Cpp file doesn't exist. Do you want to create it?", "&Yes\n&No\nYes as &c", 3)
      if l:confirmed == 1
        e %:r.cpp
      elseif l:confirmed == 3
        e %:r.c
      endif
    endif
  else
    echohl ErrorMsg
    echo 'Current file is not a C++ file'
    echohl None
  endif
endfunction

" Writes the .cpp.h file into the current line and replace CLASS_NAME with the current filename!
nnoremap ,cpp<CR> :-1read $HOME/.vim/.cpp.h<CR>:%s/CLASS_NAME/\=expand("%:t:r")/g<CR>
nnoremap ,engine<CR> :-1read $HOME/.vim/.engine.h<CR>:%s/CLASS_NAME/\=expand("%:t:r")/g<CR>

" Open vimrc when typing Vimrc
:command! Vimrc :tabe ~/.vimrc

" Setup swp files in their own directory in order to avoid them existing inside projects I'm working on
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/
set undodir=~/.vim/undo/

" YouCompleteMe configurations
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" NERDTree configuration
let NERDTreeQuitOnOpen=1

" Don't indent namespace and template
function! CppFormatting()
  let l:cline_num = line('.')
  let l:cline = getline(l:cline_num)
  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)

  let l:retv = cindent('.')
  let l:pindent = indent(l:pline_num)

  if l:cline =~# '^\s*\(#\|\};\|private:\|public:\|protected:\)\s*$'
    let l:retv = l:retv
  elseif l:cline =~# '^\s*->'
    let l:retv = l:pindent + &shiftwidth
  elseif l:pline =~# '^\s*\(private:\|public:\|protected:\)\s*$'
    let l:retv = l:pindent + &shiftwidth
  elseif l:pline =~# '^\s*template\s*<.*>\s*$'
    let l:retv = l:pindent
  elseif l:pline =~# '\s*typename\s*.*,\s*$'
    let l:retv = l:pindent
  elseif l:cline =~# '^\s*>\s*$'
    let l:retv = l:pindent - &shiftwidth
  elseif l:pline =~# '\s*typename\s*.*>\s*$'
    let l:retv = l:pindent - &shiftwidth
  elseif l:pline=~# '^\s*->'
    let l:retv = l:pindent - &shiftwidth
  endif
  return l:retv
endfunction

if has("autocmd")
  autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppFormatting()
  autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} match ExtraWhitespace /\s\+$/
  autocmd BufEnter * let b:ycm_hover=''
  autocmd BufEnter *.{fig,tex} match TexFix /\\fix{.\{-}}/
  autocmd BufEnter *.{fig,tex} set conceallevel=0
  autocmd BufEnter *.{fig} set filetype=tex
endif

" Goto last known cursor position
autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'  |  exe "normal! g`\"" | endif
