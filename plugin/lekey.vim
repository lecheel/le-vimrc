" File: lekey.vim for VIM 7.1
" Purpose: Basic Brief Like emulation for vim
" Author: Lechee.Lai
" Version: 1.0
"
" TODO:
"
"
" ---------- B r i e f E X  l i k e -----------------------------------
"-----------------------------------------------------------------------
if !exists("vim_mask")
    if $bmask == ""   
	let g:vim_mask = '*'
    else 
	let g:vim_mask = $bmask
    endif
endif	


function! s:UnderOccurences()
    let s:skip = 0
    try     
	exec "normal [I"
    catch /^Vim(\a\+):E349:/
	echo v:exception
	let s:skip = 1   
    endtry
    if s:skip == 0
	let nr = input("Which one: ")
	if nr == ""
	    return
	endif
	exec "normal " . nr . "[\t"
    endif
endfunction!

function! s:leOccur()
    let pat = expand("<cword>")
    let pattern = input("leOccur (" . pat . "): ")
    if pattern == ""
	let pattern = pat
	if pattern ==""
	    echo "Cancelled.!"
	    return
	endif  
    endif
    exec 'let @/ = "'.pattern.'"'
    exec 'vimgrep ' . pattern . ' ' . expand('%') | :copen |:cc
endfunction!

function! s:leGitGrep()
	exec "mark g"
    let pat = expand("<cword>")
    let pattern = input("GitGrep (" . pat . "): ")
    if pattern == ""
	let pattern = pat
	if pattern ==""
	    echo "Cancelled.!"
	    return
	endif  
    endif
    let pat = expand("<cword>")
    exec 'let @/ = "'.pattern.'"'
    exec 'silent! Ggrep ' . pattern . ' ' | :copen |redraw!|:cc
endfunction


function! s:FindOccurences(method)
    if a:method == "auto"
	let pat = expand("<cword>")
	let pattern = input("Prompt Find (".pat."): ")
	if pattern == ""
	    let pattern = pat
	    if pattern ==""
		echo "Cancelled.!"
		return
	    endif  
	endif
    else 
	let pattern = input("Prompt Find: ")
	if pattern == ""
	    echo "Cancelled.!"
	    return
	endif
    endif   
    let s:skip = 0
    try
	exec "ilist! /" . pattern
    catch /^Vim(\a\+):E389:/
	echo v:exception ." \"" . pattern ."\""
	let s:skip = 1
    endtry
    if s:skip == 0
	exec 'let @/ = "'.pattern.'"'
	let nr = input("Which one: ")
	if nr == ""
	    return
	endif
	try
	    exec "ijump! " . nr . "/".pattern."/" 
	catch /^Vim(\a\+):E387:/
	    echo "BAD :-( ---%<---"
	endtry
    endif
endfunction

function! s:BriefSave()
    if expand("%") == ""
	if has("gui_running")
	    browse write
	else
	    let fname = input("Save file as: ")
	    if fname == ""
		return
	    endif
	    execute "write " . fname
	endif
    else
	write!
    endif
endfunction

function! s:BriefSaveAs()
    if has("gui_running")
	browse saveas
    else
	let fname = input("Save file as: ")
	if fname == ""
	    return
	endif
	execute "saveas " . fname
    endif
endfunction

function! s:leJumpMark()
    let mark = input("m(c-z) for BookMark, Jump to bookmark(c-z): ")
    if mark == ""
	return
    endif

    try     
	exec "normal `".mark
    catch /^Vim(\a\+):E20:/  
	echo "set BookMark m(c-z) first, empty for BookMark(".mark.")" 
    endtry 
endfunction

function! s:leGotoLine()
    let linenr = input("Line number to jump to: ")
    if linenr == ""
	return
    endif

    execute "normal " . linenr . "gg"
endfunction

"vim substitute/replace
function! s:leReplace()
"    call inputsave()
    let pat = expand("<cword>")
    let s:lePAT = input("Replace: (".pat."): ")
    if s:lePAT == ""
	let s:lePAT = pat
	if s:lePAT == ""
	    return
	endif  
    endif
    let s:leREP = input("Replace (" . s:lePAT . ") with: ")
    exec '%s/' . s:lePAT . '/' . s:leREP . '/gc'
    call inputrestore()
endfunction

" from http://www.vim.org/tips/tip.php?tip_id=79 and modified
function! s:ShowFunc(sort) 
    let gf_s = &grepformat 
    let gp_s = &grepprg 
    if ( &filetype == "c" || &filetype == "php" || &filetype == "python" ||
		\ &filetype == "sh" )
	let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m'
	let &grepprg = 'ctags -x --'.&filetype.'-types=f --sort='.a:sort
    elseif ( &filetype == "perl" )
	let &grepformat='%*\k%*\ssubroutine%*\s%l%*\s%f %m'
	let &grepprg = 'ctags -x --perl-types=s --sort='.a:sort
    elseif ( &filetype == "vim" )
	let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m'
	let &grepprg = 'ctags -x --vim-types=f --language-force=vim --sort='.a:sort
    endif 
    if (&readonly == 0) | update | endif 
    silent! grep % 
    cwindow 10 
    redraw   
    let &grepformat = gf_s
    let &grepprg = gp_s 
endfunction  

function! s:BufferNext()
    exec "bnext!"
endfunction

function! s:BufferPrev()
    exec "bprevious!"
endfunction

function! s:leQuit()
    exec "confirm qa"
endfunction

function! s:leClose()
    exec "bdelete"
endfunction

function! s:leCMD()
    exec ":"
endfunction

function! s:leBuffer()
    "    exec "buffers"
    exec "BufExplorer"
endfunction

function! s:leDelLine()
    exec "norm dd"
endfunction

function! s:leDired()
    exec "e! ."
endfunction

function! s:leFile()
    exec "file"
endfunction

function! s:leComplete()
    exec "norm <C-P>"
endfunction

function! s:leFinfo()
    let finfo = expand("%:p")
    let ww = expand("<cword>")
    echo '"' . finfo . '"'
endfunction

function! s:leFind()
"    call inputsave()
    let g:pat = expand("<cword>")
    let @" = g:pat
"    call inputrestore()
    exec 'let @a ="' . g:pat .'"'       
    exec 'let @/ ="' . g:pat .'"'
    exec ":stopinsert"
    echo "<".g:pat."> Marked!! n/N for repeat search CTRL-Y for yank"
endfunction

function! s:leTAG()
"    call inputsave()
    let g:pat = expand("<cword>")
    if $TAGFILE != ""
	exec 'set tags='.$TAGFILE.';'	
    endif
"    exec 'tselect ' . g:pat 
    exec 'tjump ' . g:pat 
endfunction

function! s:leTAB(direction)
    let col = col('.') - 1        
    if !col || getline('.')[col -1] !~ '\k'
	return "\<tab>"
    elseif "forward" == a:direction    
	return "\<c-p>"
    endif 
endfunction!

function! TabCompletion()
    if mapcheck("\<tab>", "i") != ""
	:iunmap <tab>
	echo "TAB completion off"
    else 
	:imap <tab> <c-p>
	echo "TAB completion on"
    endif
    "map <Leader>tc :call TabCompletion()<CR>
endfunction

function! s:leSave()
    if expand("%") == ""
	if has("gui_running")
	    browse write
	else
	    let fname = input("Save file as: ")
	    if fname == ""
		return
	    endif
	    execute "write " . fname
	endif  
    else
	write!
    endif
endfunction

function! s:levimgrep()
    " No argument supplied. Get the identifier and file list from user
    let pattern = input("vimGrep for pattern: ", expand("<cword>"))
    if pattern == ""
	echo "Cancelled."    
	return
    endif

    if g:vim_mask == "*"
	let ff = expand("%:e")
	if ff != ""
	    let g:vim_mask = "*.".ff
	endif
    endif

    let filenames = input("vimGrep in files: ", g:vim_mask)
    if filenames == ""
	echo "Cancelled."    
	return
    endif
    if filenames == "*"
	let ff =expand("%:e")
	if ff != ""
	    let filenames = "*.".ff
	endif
    endif

    exec "vimgrep /" . pattern . "/ **/" . filenames 

endfunction

" Return last visually selected text or '\<cword\>'.
" what = 1 (selection), or 2 (cword), or 0 (guess if 1 or 2 is wanted).
function! s:Pattern(what)
    if a:what == 2 || (a:what == 0 && histget(':', -1) =~# '^H')
	let result = expand("<cword>")
	if !empty(result)
	    let result = '\<'.result.'\>'
	endif
    else
	let old_reg = getreg('"')
	let old_regtype = getregtype('"')
	normal! gvy
	let result = substitute(escape(@@, '\.*$^~['), '\_s\+', '\\_s\\+', 'g')
	normal! gV
	call setreg('"', old_reg, old_regtype)
    endif
    return result
endfunction


function! s:adbRemove()
    exe "1"
    exe "g/.*RvInternalLog.*/d"
    exe "1"
    exe "g/.*ActivityManager.*/d"
    exe "1"
    exe "g/.*AndroidRuntime.*/d"
    exe "1"
    exe "g/.*WindowManager.*/d"
    exe "1"
"    exe "g/.*com\.radvision\.beehd.*/d"
"    exe "1"
    exe "g/.*TabletStatusBar.*/d"
    exe "1"
    exe "g/.*dalvikvm.*/d"
    exe "1"
    exe "g/.*BootReceiver.*/d"
    exe "1"
    exe "g/.*InputManagerService.*/d"
    exe "1"
    exe "g/.*ThrottleService.*/d"
    exe "1"
    exe "g/.*Resources.*/d"
    exe "1"    
    exe "g/.*AwesomePlayer.*/d"
    exe "1"
    exe "g/.*wpa_supplicant.*/d"
    exe "1"
    exe "g/.*WifiStateMachine.*/d"
    exe "1"

    exe "g/.*MODEMMONITOR.*/d"
    exe "1"

    exe "g/.*AudioFlinger.*/d"
    exe "1"
     
    exe "g/.*DisplayEventReceiver.*/d"
    exe "1"


    exe "g/.*Keyguard.*/d"
    exe "1"

    exe "g/.*InputReader.*/d"
    exe "1"


    exe "g/.*ActivityThread.*/d"
    exe "1"

    exe "g/.*IPCThreadState.*/d"
    exe "1"


    exe "g/.*OpenGLRenderer.*/d"
    exe "1"

    exe "g/.*Provider.*/d"
    exe "1"

    exe "g/.*BufferQueue(.*/d"
    exe "1"

    exe "g/.*SurfaceFlinger(.*/d"
    exe "1"

    exe "g/.*PowerManager.*/d"
    exe "1"


endfunction

function! s:BriefJumpMark()
    let mark = input("Jump to bookmark: ")
    if mark == ""
        return
    endif
    if mark == "0"
        normal `0
    endif
    if mark == "1"
	echo "MARK"
        normal `1
    endif
    if mark == "2"
        normal `2
    endif
    if mark == "3"
        normal `3
    endif
    if mark == "4"
        normal `4
    endif
    if mark == "5"
        normal `5
    endif
endfunction

function! s:_cdo(args, type)
  let no_confirmation_needed = matchstr(a:args,'^/c') == ""
  let command = substitute(a:args, '^/c', '', '')

  exe a:type.'rewind'
  let error_count = a:type == 'c' ? len(getqflist()) : len(getloclist(0))
  let i = 0
  while i < error_count
    let i = i + 1
    exe a:type.a:type." ".i
    let confirm_msg = "Change this line? - ".getline(".")
    if no_confirmation_needed || confirm(confirm_msg, "&yes\n&no") == 1
      exe command
    endif
  endwhile
endfunction

command! -nargs=1 -bar Cdo :call s:_cdo(<q-args>, 'c')
command! -nargs=1 -bar Ldo :call s:_cdo(<q-args>, 'l')


" you can use "CTRL-V" for mapping real key in Quote
if has("gui_running")
    let Occur_Key    = '<M-o>'
    let lequit_Key   = '<M-q>'
    let legoto_Key   = '<M-g>'
    let lesave_Key   = '<M-w>'
    let leclose_Key  = '<M-x>'
    let lefind_Key   = '<M-s>'
    let leedit_Key   = '<M-e>'
    let lewmark_Key  = '<M-y>'
    let ledelln_Key  = '<M-d>'
    let bn_Key       = '<M-.>'
    let bp_Key       = '<M-,>'
    let lecomp_Key   = "<M-/>"
    let lebuff_Key   = "<M-b>"
    let leinfo_Key   = "<M-f>"
    let leRepl_Key   = "<M-t>"
    let leMarkLn     = "<M-l>"
else	
    let Occur_Key    = "o" 
    let lequit_Key   = "q" 
    let legoto_Key   = "g"
    let lesave_Key   = "w"
    let leclose_Key  = "x"
    let lefind_Key   = "s"
    let lefile_Key   = "f"
    let leedit_Key   = "e"
    let lewmark_Key  = "y"
    let ledelln_Key  = "d"
    let bn_Key       = "." 
    let bp_Key       = ","
    let bn0_Key      = "=" 
    let bp0_Key      = "-"
    let lecomp_Key   = "/"
    let lebuff_Key   = "b"
    let leinfo_Key   = "f"
    let leRepl_Key   = "t"
    let leMarkLn     = "l"
    let leJump       = "j"
endif

"noremap <F4> :qa!<CR>
noremap <silent> <C-]> :call <SID>leTAG()<CR>
inoremap <silent> <C-]> <C-O>:call <SID>leTAG()<CR>
noremap <silent> <F6> <C-W>w
inoremap <silent> <F6> <C-O><C-W>w
noremap <silent> <F7> %
inoremap <silent> <F7> <C-O>%
noremap <silent> <C-X>o <C-W>w
inoremap <silent> <C-X>o <C-W>w
noremap <silent> <C-W>k <C-W>c
noremap <silent> <C-W>0 <C-W>c
noremap <silent> <C-X>k :bd<CR>
noremap <silent> <C-X>0 <C-W>c
noremap <silent> <C-X>\| <C-W>H
noremap <silent> <C-X>1 :only<CR>
noremap <silent> <C-X>2 <C-W>i
noremap <silent> <C-X>3 <C-W>v

"GitGutter Mapping
noremap <silent> <C-X>n :GitGutterNextHunk<cr>
noremap <silent> <C-X>p :GitGutterPrevHunk<cr>
inoremap <silent> <C-X>n <C-O>:GitGutterNextHunk<cr>
inoremap <silent> <C-X>p <C-O>:GitGutterPrevHunk<cr>
noremap <silent> <C-X>vr :GitGutterRevertHunk<cr>
noremap <silent> <C-X>vs :GitGutterStageHunk<cr>

noremap <silent> <C-Y> "ap
noremap <silent> <C-L> n
noremap <silent> <C-P> N
noremap <silent> <C-N> n
inoremap <silent> <C-L> <C-O>n
inoremap <silent> <C-P> <C-O>N
inoremap <silent> <C-N> <C-O>n
"noremap <silent> <C-[> :ts<CR>
noremap <F8> :TlistToggle<CR>
inoremap <silent> <ESC>/ <C-P>
"map <F2> :exec "vimgrep /" . expand("<cword>") . "/j **/*." . expand("%:e") <Bar>  cw<CR>
nmap 0 :ts<CR>
nmap ' :cn<CR>
nmap ; :cp<CR>
" hint for no-map usage 
"
" replace %s/foo/xxx/gc    <A-t>
"
" Toggle line marking mode
inoremap <silent> <ESC>l <C-O>V
noremap <silent> <ESC>l V
vnoremap <silent> <ESC>l V
inoremap <silent> <C-Y> <C-O>p
" Jump to a bookmark
"inoremap <silent> <ESC>j <C-O>:call <SID>BriefJumpMark()<CR>
"noremap <silent> <ESC>j call <SID>BriefJumpMark()<CR>

"-----------------------
"" Bookmark
"-----------------------
"
"" Mark bookmark 0
"inoremap <silent> <C-0> <C-O>mb
" Mark bookmark 1
"inoremap <silent> <C-1> <C-O>mc
" Mark bookmark 2
"inoremap <silent> <C-2> <C-O>md

exec "nnoremap <unique> <silent> " . bn_Key .    " :call <SID>BufferNext()<CR>"
exec "inoremap <unique> <silent> " . bn_Key .    " <C-O>:call <SID>BufferNext()<CR>"

exec "nnoremap <unique> <silent> " . bp_Key .    " :call <SID>BufferPrev()<CR>"
exec "inoremap <unique> <silent> " . bp_Key .    " <C-O>:call <SID>BufferPrev()<CR>"

exec "nnoremap <unique> <silent> " . bn0_Key .    " :call <SID>BufferNext()<CR>"
exec "inoremap <unique> <silent> " . bn0_Key .    " <C-O>:call <SID>BufferNext()<CR>"

exec "nnoremap <unique> <silent> " . bp0_Key .    " :call <SID>BufferPrev()<CR>"
exec "inoremap <unique> <silent> " . bp0_Key .    " <C-O>:call <SID>BufferPrev()<CR>"

exec "nnoremap <unique> <silent> " . lequit_Key . " :call <SID>leQuit()<CR>"
exec "inoremap <unique> <silent> " . lequit_Key . " <C-O>:call <SID>leQuit()<CR>"

exec "nnoremap <unique> <silent> " . lesave_Key . " :call <SID>leSave()<CR>"
exec "inoremap <unique> <silent> " . lesave_Key . " <C-O>:call <SID>leSave()<CR>"

exec "nnoremap <unique> <silent> " . leedit_Key . " :call <SID>leDired()<CR>"
exec "inoremap <unique> <silent> " . leedit_Key . " <C-O>:call <SID>leDired()<CR>"

exec "nnoremap <unique> <silent> " . ledelln_Key . " :call <SID>leDelLine()<CR>"
exec "inoremap <unique> <silent> " . ledelln_Key . " <C-O>:call <SID>leDelLine()<CR>"

exec "nnoremap <unique> <silent> " . lebuff_Key . " :call <SID>leBuffer()<CR>"
exec "inoremap <unique> <silent> " . lebuff_Key . " <C-O>:call <SID>leBuffer()<CR>"

exec "nnoremap <unique> <silent> " . leclose_Key . " :call <SID>leClose()<CR>"
exec "inoremap <unique> <silent> " . leclose_Key . " <C-O>:call <SID>leClose()<CR>"

exec "nnoremap <unique> <silent> " . lewmark_Key . " :call <SID>leFind()<CR>"
exec "inoremap <unique> <silent> " . lewmark_Key . " <C-O>:call <SID>leFind()<CR>"

exec "nnoremap <unique> <silent> " . leRepl_Key . " :call <SID>leReplace()<CR>"
exec "inoremap <unique> <silent> " . leRepl_Key . " <C-O>:call <SID>leReplace()<CR>"

exec "nnoremap <unique> <silent> " . lefile_Key . " :call <SID>leFinfo()<CR>"
exec "inoremap <unique> <silent> " . lefile_Key . " <C-O>:call <SID>leFinfo()<CR>"

exec "nnoremap <unique> <silent> " . lefind_Key . " :call <SID>levimgrep()<CR>"
exec "inoremap <unique> <silent> " . lefind_Key . " <C-O>:call <SID>levimgrep()<CR>"

exec "nnoremap <unique> <silent> " . Occur_Key . " :call <SID>leOccur()<CR>"
exec "inoremap <unique> <silent> " . Occur_Key. " <C-O>:call <SID>leOccur()<CR>"

exec "nnoremap <unique> <silent> " . legoto_Key . " :call <SID>leGotoLine()<CR>"
exec "inoremap <unique> <silent> " . legoto_Key . " <C-O>:call <SID>leGotoLine()<CR>"

exec "nnoremap <unique> <silent> " . leJump . " :call <SID>BriefJumpMark()<CR>"
exec "inoremap <unique> <silent> " . leJump . " <C-O>:call <SID>BriefJumpMark()<CR>"
command! -nargs=* Adb call s:adbRemove()
command! -nargs=* Ggr call s:leGitGrep()

" vim:sw=4:tabstop=4

