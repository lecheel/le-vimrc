"
" $ ln -s ~/.vim/ ~/.vimrc
"
" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

set nocompatible    	"required
filetype off		"required

" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    "Add your bundles here
	" original repos on github
	Bundle 'Lokaltog/vim-easymotion'
	Bundle 'airblade/vim-gitgutter'
	Bundle 'jlanzarotta/bufexplorer'
	Bundle 'tpope/vim-fugitive'
	Bundle 'tpope/vim-markdown'
	Bundle 'Raimondi/delimitMate'
	Bundle 'bling/vim-airline'
	Bundle 'scrooloose/nerdtree'
	Bundle 'tomtom/tcomment_vim'
	Bundle 'tomtom/tlib_vim'
	Bundle 'tpope/vim-surround'
	Bundle 'tpope/vim-unimpaired'
	Bundle 'marcweber/vim-addon-mw-utils'
	Bundle 'majutsushi/tagbar'
	Bundle 'kien/rainbow_parentheses.vim'
	Bundle 'rking/ag.vim'
	Bundle 'int3/vim-extradite'
	Bundle 'gregsexton/gitv'
	Bundle 'mileszs/ack.vim'
	"Plugin 'justinmk/vim-sneak'
	"Bundle 'garbas/vim-snipmate'
	Bundle 'sjl/gundo.vim'
	Bundle 'NLKNguyen/papercolor-theme'
	Bundle 'mrtazz/DoxygenToolkit.vim'
	Bundle 'ajh17/Spacegray.vim'
	Bundle 'will133/vim-dirdiff'
	Bundle 'chrisbra/Colorizer'
	Bundle '1995parham/vim-tcpdump'
	Bundle 'vim-multiple-cursors'
	Bundle 'lervag/vimtex'
	Bundle 'vim-scripts/taglist.vim'
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end
filetype plugin indent on	"required

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"au FilterWritePre * if &diff | set t_Co=256 | set bg=dark | colorscheme peaksea | endif

au BufRead,BufNewFile *.logcat set filetype=logcat 
au BufRead,BufNewFile *.grp set filetype=grp
au BufRead,BufNewFile *.log set filetype=messages
au BufRead,BufNewFile *.cr set filetype=c
au BufNewFile,BufReadPost *.md set filetype=markdown
au QuickFixCmdPost *grep* cwindow
au Filetype python set expandtab
au Filetype make set expandtab
au Filetype python set ts=4 sw=4 et

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" " needed, and have indentation at 8 chars to be sure that all indents are
" tabs
" " (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ack
"let g:ackprg='ack-grep -H --nocolor --nogroup --column'
let g:ag_working_path_mode="r"
let g:grepprg='grep -nH $*'
"let g:grepprg='ack -H --nocolor --nogroup --column'
"nnoremap K :grep! <C-R><C-W> *<CR>:cc<CR>
"nnoremap " :Ag<CR>
set keywordprg=trans\ :zh-TW

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif


" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set ignorecase incsearch
set noshowmatch
"set expandtab
let loaded_matchparen = 1
set t_Co=256
set number
set relativenumber
set laststatus=2
set noeb vb t_vb=
set backspace=2
set nobackup
set noswapfile
set nowrapscan

let mapleader=","

colorscheme PaperColor

if &diff
    set background=dark
else
    "colorscheme default
    colorscheme PaperColor
endif  


" Set K&R Style
"set cindent
"set equalprg=astyle
set shiftwidth=4

"vimgrep
"map <C-F>viwy:vimgrep /\<"\>/ **/*.[ch]pp
"noremap <F12> :cnext<CR>

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '

autocmd Filetype java setlocal omnifunc=javacomplete#Complete

:set noshowmode

let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = 'M*'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '-*'
let g:gitgutter_escape_grep = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" patch for cygwin powerline font --->
" let g:airline_symbols = {}
" let g:airline_left_sep = "\u2b80" "use double quotes here
" let g:airline_left_alt_sep = "\u2b81"
" let g:airline_right_sep = "\u2b82"
" let g:airline_right_alt_sep = "\u2b83"
" let g:airline_symbols.branch = "\u2b60"
" let g:airline_symbols.readonly = "\u2b64"
" let g:airline_symbols.linenr = "\u2b61"
" <-------- endof cygwin

"highlight clear SignColumn
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7


autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

"CTAGS
if filereadable("tags")
    set tags=tags
elseif $TAGFILE != ""
    set tags=$TAGFILE
endif

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! ToggleWrap()
 if (&wrap == 1)
   set nowrap
 else
   set wrap
 endif
endfunction

function! BundleRefresh()
    exe "w"
    exe "so %"
    exe "BundleInstall"
endfunction

"EasyGrep Options
let g:EasyGrepRecursive=1

"tagbar mapping
noremap ]= :tabnext<cr>
noremap ]- :tabprev<cr>
noremap ]` :tabnew 
noremap ]1 1gt 
noremap ]2 2gt 
noremap ]3 3gt 
noremap ]4 4gt 
noremap ]5 5gt 
noremap ]6 6gt 
noremap ]7 7gt 

nnoremap <silent> <F9> :GitGutterToggle <cr>
inoremap <silent> <F9> <Esc>:GitGutterToggle <cr>
nmap <silent> <Leader>]h :GitGutterNextHunk<cr>
nmap <silent> <Leader>[h :GitGutterPrevHunk<cr>
nmap <silent> <Leader>hs :GitGutterStageHunk<cr>
nmap <silent> <Leader>hr :GitGutterRevertHunk<cr>
nmap <silent> <Leader>hp :GitGutterPreviewHunk<cr>
nmap <silent> <Leader>n  :GitGutterNextHunk<cr>
nmap <silent> <Leader>p  :GitGutterPrevHunk<cr>
nmap <silent> <Leader>d  :GitGutterPreviewHunk<cr>


" NERDTree mappings
nnoremap <silent> <F1> :NERDTreeToggle <cr>
inoremap <silent> <F1> <Esc>:NERDTreeToggle <cr>

noremap <F4> :set hlsearch! hlsearch?<CR>
set pastetoggle=<F5>

nmap <F10> :TagbarToggle<CR> 

map <F3> :exec 'cs find d <C-R>=expand("<cword>")<CR>'<CR>
map <F2> :exec 'cs find c <C-R>=expand("<cword>")<CR>'<CR>
nmap <leader>so :vimgrep <C-R><C-W> *<CR>

"
" Toggle .....
"
noremap <leader>tw :call ToggleWrap()<CR>
noremap <leader>th :set hlsearch! hlsearch?<CR>
noremap <leader>tt :TagbarToggle<cr>
noremap <leader>tl :set nonu relativenumber!<cr>
noremap <leader>ii :call BundleRefresh()<CR>

nmap <leader>l <Plug>(easymotion-lineanywhere)
nmap <silent> ,/ :nohlsearch<CR>



command! -nargs=+ Ggs execute 'silent Ggrep!' <q-args>|cw|redraw!|cc
nmap <leader>gg :Ggs <C-R><C-W><CR>
nmap <leader>gr :Ggr <CR>
nmap <leader>gs :Gstatus <CR>
nmap <leader>gd :Gdiff <CR>
nmap <leader>gl :Glog %
nmap <leader>gb :Git branch<Space>
nmap <leader>gf :Extradite<CR>
nmap <leader>gv :Gitv<CR>
nmap <leader>br :Git branch<Space>
nmap <leader>k  :bd<CR>
nnoremap <leader>w <C-w>v<C-w>l

if &diff
nmap Ok dp
nmap Om do
nmap Oo ]c
nmap Oj [c
endif

nmap Oo ]c
nmap Oj [c

nmap <SPACE> <Plug>(easymotion-s)
nmap s <Plug>(easymotion-s2)
nmap \| <C-W>H
