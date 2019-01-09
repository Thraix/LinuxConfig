set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Yggdroot/indentLine'

Plugin 'pangloss/vim-javascript' 
Plugin 'lervag/vimtex'

Plugin 'scrooloose/nerdtree'

Plugin 'prettier/vim-prettier'

Plugin 'vim-syntastic/syntastic'

Plugin 'tikhomirov/vim-glsl'

Plugin 'Valloric/YouCompleteMe'

Plugin 'chrisbra/Colorizer'

Plugin 'chriskempson/base16-vim'
Plugin 'Chiel92/vim-autoformat'

call vundle#end()

filetype plugin indent on

set backspace=indent,eol,start
set conceallevel=0
set cursorline
set lazyredraw
set noshowmode
set showcmd

set langmenu=en_US
let $LANG = 'en_US'


source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set winaltkeys=no

set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

set nocompatible
set autoindent
set smartindent


set tabstop=2        " tab width is 4 spaces
set shiftwidth=2     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

syntax enable
set background=dark
set t_Co=256
"colorscheme darkblue


"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"
" colorscheme solarized 

set number
set relativenumber

noremap <C-s> :call SwitchSourceHeader()<CR>

set comments=sl:/*,mb:\ *,elx:\ */

noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>
noremap <C-k> :m .-2<CR>==
noremap <C-j> :m .+1<CR>==
noremap <C-b> :tabm -1<CR>
noremap <C-n> :tabm +1<CR>
noremap <C-o> :NERDTree %<CR>
noremap <C-q> :q<CR>
map <F12> :!make<CR>
noremap <S-tab> gg=G''
noremap <C-G> :YcmCompleter GoTo<CR>

set wrap
set linebreak
set textwidth=0
set wrapmargin=0

map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>
noremap Ö :
noremap h <left>
noremap j g<down>
noremap k g<up>
noremap l <right>

let g:indentLine_char = '|'

function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "cpp" || expand("%:e") == "cc" || expand("%:e") == "c")
    if filereadable(join([expand("%<"),".h"],""))
      tab drop %:r.h
    elseif filereadable(join([expand("%<"),".hpp"],""))
      tab drop %:r.hpp
    end
  elseif (expand ("%:e") == "hpp" || expand("%:e") == "h")
    if filereadable(join([expand("%<"),".cc"],""))
      tab drop %:r.cc
    elseif filereadable(join([expand("%<"),".cpp"],""))
      tab drop %:r.cpp
    elseif filereadable(join([expand("%<"),".c"],""))
      tab drop %:r.c
    endif
  endif
endfunction

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Don't indent namespace and template
function! CppNoNamespaceAndTemplateIndent()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num-1)
        let l:pline = getline(l:pline_num)
    endwhile
    let l:retv = cindent('.')
    let l:pindent = indent(l:pline_num)
    if l:pline =~# '^\s*template\s*\s*'
        let l:retv = l:pindent
    elseif l:pline =~# '\s*typename\s*.*,\s*$'
        let l:retv = l:pindent
    elseif l:cline =~# '^\s*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '\s*typename\s*.*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    endif
    return l:retv
endfunction

if has("autocmd")
    autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
endif

hi Normal ctermbg=none
set showcmd
set wildmenu

:command! Vimrc :tabe ~/.vimrc

set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set undodir=~/.vim/undo//


let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command="new-or-existing-tab"
let g:javascript_plugin_jsdoc = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let NERDTreeQuitOnOpen=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'
let g:syntastic_javascript_eslint_args = ['--fix']
let g:syntastic_mode_map = { 'mode': 'passive'}
let g:vim_json_syntax_conceal = 0
