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

" some tips for python
"https://realpython.com/vim-and-python-a-match-made-in-heaven/

set nocompatible    	"required
filetype off		"required

set viminfo='100,n$HOME/.vim/files/info/viminfo'

" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler :PluginInstall
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
	Bundle 'JuliaEditorSupport/julia-vim'
	Bundle 'airblade/vim-gitgutter'
	Bundle 'jlanzarotta/bufexplorer'
	Bundle 'tpope/vim-fugitive'
	Bundle 'tpope/vim-markdown'
	Bundle 'Raimondi/delimitMate'
	Bundle 'itchyny/lightline.vim'
	Bundle 'scrooloose/nerdtree'
	Bundle 'scrooloose/nerdcommenter'
	Bundle 'tpope/vim-surround'
	Bundle 'kien/rainbow_parentheses.vim'
	Bundle 'rking/ag.vim'
	Bundle 'int3/vim-extradite'
	Bundle 'mileszs/ack.vim'
	Bundle 'kien/ctrlp.vim'
	Bundle 'NLKNguyen/papercolor-theme'
	Bundle 'chrisbra/Colorizer'
	Bundle 'sts10/vim-mustard'
	Bundle 'vim-scripts/taglist.vim'
	Bundle 'burnettk/vim-angular'
	Bundle 'digitaltoad/vim-pug'
"	Bundle 'ramele/agrep'
	Bundle 'vim-scripts/AnsiEsc.vim'
	Bundle 'leafgarland/typescript-vim'
	Bundle 'vim-scripts/indentpython.vim'
	Bundle 'nvie/vim-flake8'

        Bundle 'hecal3/vim-leader-guide'
	Bundle 'Shougo/unite.vim'
	Bundle 'junegunn/vim-easy-align'
	Bundle 'majutsushi/tagbar'
	Bundle 'mhinz/vim-startify'
	Bundle 'wincent/command-t'

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


autocmd FileType make set expandtab shiftwidth=4 softtabstop=0

au BufRead,BufNewFile *.logcat set filetype=logcat
au BufRead,BufNewFile *.grp set filetype=grp
au BufRead,BufNewFile *.log set filetype=messages
au BufRead,BufNewFile *.cr set filetype=c
au BufNewFile,BufReadPost *.md set filetype=markdown
au QuickFixCmdPost *grep* cwindow
autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql
au Filetype make set expandtab
au Filetype pug set ts=2 sw=2 et
au FileType javascript setlocal expandtab sw=2 ts=2 sts=2
au BufNewFile,BufReadPost *.jade *.pug set filetype=pug

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" " needed, and have indentation at 8 chars to be sure that all indents are
" tabs
" " (despite the mappings later):

" PEP8 indent standard for python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.go
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix



highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/
let python_highlight_all=1


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
set t_RV=
set ts=4 sw=4
"set expandtab
let loaded_matchparen = 1
set t_Co=256
set number
set rnu relativenumber
set laststatus=2
set noeb vb t_vb=
set backspace=2
set nobackup
set noswapfile
set nowrapscan

map q <Nop>
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
"set shiftwidth=4

"vimgrep
"map <C-F>viwy:vimgrep /\<"\>/ **/*.[ch]pp
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
"Remove Space on write
autocmd BufWritePre * :%s/\s\+$//e
autocmd Filetype java setlocal omnifunc=javacomplete#Complete

:set noshowmode


"easy-vim-algin gaip= ??
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = 'M*'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '-*'
let g:gitgutter_escape_grep = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


"highlight clear SignColumn
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7


autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete
au BufRead,BufNewfile *.smali set filetype=smali

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

nmap <silent> <Leader>+ :GitGutterNextHunk<cr>
nmap <silent> <Leader>- :GitGutterPrevHunk<cr>

nmap <silent> <Leader>hs :GitGutterStageHunk<cr>
nmap <silent> <Leader>hr :GitGutterUndoHunk<cr>
nmap <silent> <Leader>hu :GitGutterUndoHunk<cr>
nmap <silent> <Leader>hv :GitGutterPreviewHunk<cr>
nmap <silent> <Leader>hd :GitGutterPreviewHunk<cr>
nmap <silent> <Leader>hp :GitGutterPrevHunk<cr>
nmap <silent> <Leader>hn :GitGutterNextHunk<cr>
nmap <silent> <Leader>n  :GitGutterNextHunk<cr>
nmap <silent> <Leader>p  :GitGutterPrevHunk<cr>
nmap <silent> <Leader>d  :GitGutterPreviewHunk<cr>


" NERDTree mappings
nnoremap <silent> <F1> :NERDTreeToggle <cr>
inoremap <silent> <F1> <Esc>:NERDTreeToggle <cr>

nnoremap <silent> <F2> :only <cr>
inoremap <silent> <F2> <Esc>:only <cr>

nnoremap <silent> <F3> :Gdiff <cr>
inoremap <silent> <F3> <Esc>:Gdiff <cr>

noremap <F4> :set hlsearch! hlsearch?<CR>
set pastetoggle=<F5>

nmap <F10> :TagbarToggle<CR>

"map <F3> :exec 'cs find d <C-R>=expand("<cword>")<CR>'<CR>
"map <F2> :exec 'cs find c <C-R>=expand("<cword>")<CR>'<CR>
"map <F3> :w<cr>
"inoremap <F3> <C-O>:w<cr>
nmap K :grep! <C-R><C-W> *<CR>:cc<CR>

"
" Toggle .....
"
noremap <leader>tw :call ToggleWrap()<CR>
noremap <leader>th :set hlsearch! hlsearch?<CR>
noremap <leader>tt :TagbarToggle<cr>
noremap <leader>tl :set nonu relativenumber!<cr>
noremap <leader>ii :call BundleRefresh()<CR>
noremap <leader>tf :call ToggleF12()<CR>
noremap <leader>tz :call ToggleZip()<CR>

nmap <leader>l <Plug>(easymotion-lineanywhere)
nmap <silent> ,/ :nohlsearch<CR>

"Ability to cancel a search with Escape:
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

command! -nargs=+ Ggs execute 'silent Ggrep!' <q-args>|cw|redraw!|cc
"
" for git operator
"
nmap <leader>gg :Ggs <C-R><C-W><CR>
nmap <leader>gr :Ggr <CR>
nmap <leader>gs :Gstatus <CR>
nmap <leader>gd :Gdiff <CR>
nmap <leader>go :Gitonly<CR>
nmap <leader>gl :Glog %
nmap <leader>gb :Git branch<Space>
nmap <leader>gf :Extradite<CR>
nmap <leader>gv :Gitv<CR>
nmap <leader>br :Git branch<Space>
nmap <leader>gx :Extradite<CR>

nmap <leader>k  :bd<CR>
nnoremap <leader>w <C-w>v<C-w>l
nmap <leader>x     <C-w>c
nmap <leader>ff :Unite file <CR>
nmap <leader>fb :Unite buffer <CR>
nmap <leader>fr :Unite file file_rec<CR>
nmap <leader>fm :Unite menu:file<CR>
nmap <leader>fg :Agrep -r <C-R><C-W>
nmap <leader>fc :CommandT<CR>
nmap <leader>.  :CommandT<CR>
nmap <leader>;  <Plug>NERDCommenterInvert
vmap <leader>;  <Plug>NERDCommenterInvert

"
" T-command
"
"
set wildignore+=*.log,*.sql,*.cache

if &diff
nmap Ok dp
nmap Om do
nmap Oo ]c
nmap Oj [c
endif

" kp-plus /kp-substract
nmap Ok :GitGutterNextHunk<cr>
nmap Om :GitGutterPrevHunk<cr>

"
"check quickfix window
"

let g:fn12 = 1
" Check quickfix window is available
function QFwinnr()
    let i=1
    while i <= winnr('$')
	if getbufvar(winbufnr(i), '&buftype') == 'quickfix'
	    return i
	endif
	let i += 1
    endwhile
    return 0
endfunction

"
" Toggle cn/cp <---> Anext/Aprev
"
noremap <F12> :cnext<Cr>
inoremap <F12> <C-O>:cnext<CR>
nmap <S-F12> :cprev<CR>
inoremap <S-F12> <C-O>:cprev<CR>

let g:fnZip = 0
function! ToggleZip()
	if (g:fnZip == 1)
		let g:fnZip = 0
		set nofoldenable
	else
		set foldenable
	    set foldmethod=indent foldlevel=1 foldclose=all
	    let g:fnZip = 1
	endif
endfunction

function! ToggleF12()
    if (g:fn12 == 1)
	noremap <F12> :cnext<Cr>
	inoremap <F12> <C-O>:cnext<CR>
	nmap <S-F12> :cprev<CR>
	inoremap <S-F12> <C-O>:cprev<CR>
	let g:fn12 = 0
	echo "cnext/cpnext"
    else
	noremap <F12> :Anext<Cr>
	inoremap <F12> <C-O>:Anext<CR>
	nmap <S-F12> :Aprev<CR>
	inoremap <S-F12> <C-O>:Aprev<CR>
	let g:fn12 = 1
	echo "Anext/Aprex"
    endif
endfunction

nmap <SPACE> <Plug>(easymotion-s)
nmap s <Plug>(easymotion-s2)
nmap \| <C-W>H

"let g:leaderGuide_default_group_name = "+group"
let g:lmap = {}
let g:lmap.b = {"name" : "+Buffers"}
let g:lmap.c = {"name" : "+Comments"}
let g:lmap.g = {"name" : "+git"}
let g:lmap.s = {"name" : "+cScope"}
let g:lmap.t = {"name" : "+Toggle"}
let g:lmap.f = {"name" : "+File"}
let g:lmap.h = {"name" : "+Hunk gitGutter"}

call leaderGuide#register_prefix_descriptions(",", "g:lmap")

nmap <silent> <Leader> :<c-u>LeaderGuide '<Leader>'<CR>
vmap <silent> <Leader> :<c-u>LeaderGuideVisual '<Leader>'<CR>
"map <leader>. <Plug>leaderguide-global
"
let g:unite_source_menu_menus = get(g:, 'unite_source_menu_menus',{})
let g:unite_source_menu_menus.file ={'description' : '- file menu',}
let g:unite_source_menu_menus.file.command_candidates = [
    \['▷ Files    ⌘    ,ff','normal ,ff'],
    \['▷ Buffer   ⌘    ,fb','normal ,fb'],
    \]

let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']
