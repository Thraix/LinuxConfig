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

" Colorscheme for glsl
Plugin 'tikhomirov/vim-glsl'

" Colorscheme and shows json errors
Plugin 'elzr/vim-json'

" Base16 colorscheme for vim
Plugin 'danielwe/base16-vim'

" C++ Plugins for formatting and auto completion
Plugin 'rdnetto/YCM-Generator'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rhysd/vim-clang-format'

" LaTeX autocompletion?
Plugin 'lervag/vimtex'

call vundle#end()

filetype plugin indent on

let g:indentLine_conceallevel=2

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

" Show error if end of line is whitespace
match ExtraWhitespace /\s\+$/

" Switch header/cpp
noremap <C-s> :call SwitchSourceHeader()<CR>

" Move current buffer to next/prev tab
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>
" Move around tabs
noremap <C-b> :tabm -1<CR>
noremap <C-n> :tabm +1<CR>

" Open nerdtree in directory of the current file
noremap <C-o> :NERDTree %<CR>
noremap <C-q> :q<CR>
noremap <C-w> :w<CR>
map <F12> :!make -j8<CR>
map <C-S-b> :!makegen -j8<CR>

" Format the code and center cursor
noremap <S-tab> gg=G''zz
noremap <C-G> :YcmCompleter GoTo<CR>

" Center when going to next search
noremap n nzz
noremap N Nzz


" Make search appear in the center of the screen
cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'

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

" Shows indentation as a pipe
let g:indentLine_char = '|'

" Switches between header and source files.
" If in a source file and the h file doesn't exist nothing happens.
" Should maybe change it to open .h file or .cpp file.
function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp" || expand("%:e") == "cc" || expand("%:e") == "c")
    if filereadable(join([expand("%<"),".h"],""))
      tab drop %:r.h
    elseif filereadable(join([expand("%<"),".hpp"],""))
      tab drop %:r.hpp
    else
      let l:confirmed = confirm("Cpp file doesn't exist. Do you want to create it?", "&Yes\n&No\nYes as &hpp", 3)
      if l:confirmed == 1
        tab drop %:r.h
      elseif l:confirmed == 3
        tab drop %:r.hpp
      endif
    end
  elseif (expand ("%:e") == "hpp" || expand("%:e") == "h")
    if filereadable(join([expand("%<"),".cc"],""))
      tab drop %:r.cc
    elseif filereadable(join([expand("%<"),".cpp"],""))
      tab drop %:r.cpp
    elseif filereadable(join([expand("%<"),".c"],""))
      tab drop %:r.c
    else
      let l:confirmed = confirm("Cpp file doesn't exist. Do you want to create it?", "&Yes\n&No\nYes as &c", 3)
      if l:confirmed == 1
        tab drop %:r.cpp
      elseif l:confirmed == 3
        tab drop %:r.c
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
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set undodir=~/.vim/undo//

" YouCompleteMe configurations
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command="new-or-existing-tab"

" NERDTree configuration
let NERDTreeQuitOnOpen=1

" Clang format
let g:clang_format#style_options = {
      \ "AccessModifierOffset": -2,
      \ "AllowShortIfStatementsOnASingleLine": "false",
      \ "AllowShortFunctionsOnASingleLine": "false",
      \ "IndentWidth": 2,
      \ "BreakBeforeBraces": "Custom",
      \ "BraceWrapping" : {
      \       "AfterClass": "true",
      \       "AfterControlStatement": "true",
      \       "AfterEnum": "true",
      \       "AfterFunction": "true",
      \       "AfterNamespace": "true",
      \       "AfterObjCDeclaration": "true",
      \       "AfterStruct": "true",
      \       "AfterUnion": "true",
      \       "AfterExternBlock": "true",
      \       "BeforeCatch": "true",
      \       "BeforeElse": "true",
      \       "IndentBraces": "false",
      \       "SplitEmptyFunction": "false",
      \       "SplitEmptyRecord": "false",
      \       "SplitEmptyNamespace": "false",
      \     },
      \ "CompactNamespaces" : "true",
      \ "ConstructorInitializerAllOnOneLineOrOnePerLine": "true",
      \ "ConstructorInitializerIndentWidth": 2,
      \ "ContinuationIndentWidth": 2,
      \ "FixNamespaceComments": "false",
      \ "MaxEmptyLinesToKeep": 2,
      \ "NamespaceIndentation": "All",
      \ "UseTab": "Never"
      \}
