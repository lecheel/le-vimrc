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
	Bundle 'bling/vim-airline'
	Bundle 'scrooloose/nerdtree'
	Bundle 'tomtom/tcomment_vim'
	Bundle 'tomtom/tlib_vim'
	Bundle 'marcweber/vim-addon-mw-utils'
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
    call vundle#end()
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
au Filetype python set ts=4 sw=4 et

" ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

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
let loaded_matchparen = 1
set t_Co=256
set number
set relativenumber
set laststatus=2
set noeb vb t_vb=
set backspace=2
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

function MapAllModes(key, cmd)
    let str = a:cmd.'<cr>'
    exec 'noremap <silent> '.a:key.' '.str
    exec 'noremap! <silent> '.a:key.' <c-o>'.str
endfunction

function MapToggle(key, opt)
    call MapAllModes(a:key, ':set '.a:opt.'!')
endfunction

command -nargs=+ MapAllModes call MapAllModes(<f-args>)
command -nargs=+ MapToggle call MapToggle(<f-args>)

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

function! Toggle_hlsearch()
	MapToggle <leader>= hlsearch
endfunction

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

function ToggleWrap()
 if (&wrap == 1)
   set nowrap
 else
   set wrap
 endif
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

let mapleader = ","

nnoremap <silent> <F9> :GitGutterToggle <cr>
inoremap <silent> <F9> <Esc>:GitGutterToggle <cr>
nmap <silent> <Leader>]h :GitGutterNextHunk<cr>
nmap <silent> <Leader>[h :GitGutterPrevHunk<cr>
nmap <silent> <Leader>hs :GitGutterStageHunk<cr>
nmap <silent> <Leader>hr :GitGutterRevertHunk<cr>
nmap <silent> <Leader>hp :GitGutterPreviewHunk<cr>

" NERDTree mappings
nnoremap <silent> <F1> :NERDTreeToggle <cr>
inoremap <silent> <F1> <Esc>:NERDTreeToggle <cr>

MapToggle <F4> hlsearch
set pastetoggle=<F5>

nmap <F10> :TagbarToggle<CR> 

noremap <leader>tw :call ToggleWrap()<CR>
noremap <leader>th :call Toggle_hlsearch()<cr>
noremap <leader>tt :TagbarToggle<cr>
noremap <leader>tn :set nonu relativenumber!<cr>

map <SPACE> <Plug>(easymotion-s2)
nmap s <Plug>(easymotion-s)
