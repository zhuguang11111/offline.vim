"==============================基本设置==============================
set number
set ruler
syntax on
set mouse=a
:set ts=4
:set expandtab
:%retab!
:colorscheme torte
":colorscheme darkblue
":colorscheme desert
let mapleader=";"

"cursor setting,only do this part when compiled with support for autocommands.

if has("autocmd")

 " Enable file type detection.
 " Use the default filetype settings, so that mail gets 'tw' set to 72,
 " 'cindent' is on in C files, etc.
 " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")


"===========================vundle 插件安装==========================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"插件安装格式说明：
"Plugin username/projectname'
"username:github用户名
"projectname:vim插件工程名
Plugin 'VundleVim/Vundle.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'zivyangll/git-blame.vim'
call vundle#end()

filetype on

"==============================插件设置==============================
"taglist 和tagbar只需要其中一个即可
"tagbar对c++类的显示更详细，对中文支持更好，这里使用tagbar
"----------------taglist----------------
"Bundle 'taglist.vim'
"let Tlist_Ctags_Cmd='ctags'
"let Tlist_Show_One_File=1               "不同时显示多个文件的tag，只显示当前文件的
"let Tlist_WinWidt =28                   "设置taglist的宽度
"let Tlist_Exit_OnlyWindow=1             "如果taglist窗口是最后一个窗口，则退出vim
""let Tlist_Use_Right_Window=1           "在右侧窗口中显示taglist窗口
"let Tlist_Use_Left_Windo =1             "在左侧窗口中显示taglist窗口 

"----------------tagbar----------------
"Bundle 'majutsushi/tagbar'
nmap <Leader>tb :TagbarToggle<CR>      "快捷键设置
let g:tagbar_ctags_bin='ctags'          "ctags程序的路径
let g:tagbar_width=38                   "窗口宽度的设置
let g:tagbar_right =1             "在左侧窗口中显示taglist窗口 
map <F3> :Tagbar<CR>
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() "如果是c语言的程序的话，tagbar自动开启
"vim7.4以下版本无法使用当前最新的tagbar，需要checkout到tag:v2.7
"vim7.4以下版本在最后只剩tagbar窗口的时候可能无法自动退出，需要添加以下命令
"autocmd bufenter * if (winnr("$") == 1 && exists("g:loaded_tagbar")) | q | endif

"--------------nerdtree----------------
set tags+=tags;/
nnoremap<leader>nt :exe'NERDTreeToggle'<CR>
map <F2> :NERDTreeToggle<CR>

"----------------rust----------------
"" 开启rust的自动reformat的功能
let g:rustfmt_autosave = 1

"----------------airline----------------
"Bundle 'bling/vim-airline'
"let g:airline_theme="molokai" 
" 显示颜色
set t_Co=256
set laststatus=2 
" 使用powerline打过补丁的字体
let g:airline_powerline_fonts = 1
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
" 映射<leader>num到num buffer
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>

"----------------cscope----------------------
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"----------------youcompleteme----------------
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0 
"-----------------git-blame------------------
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>
