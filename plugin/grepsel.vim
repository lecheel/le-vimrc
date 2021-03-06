" File: grepsel.vim
" Author: Lechee.Lai 
" Version: 1.0
" 

if exists("loaded_grepsel") || &cp
    finish
endif
let loaded_grepsel = 1
let GNUgrep = 1
let Grepsel_Output = '~/legrep.grp'

let g:GREPSEL_DIRS=getcwd()

if !exists("Glist_Key")
    let Glist_Key = "<F12>"
endif

" DelGgrepselClrDat()
"
function! s:RunGrepselClrDat()
    let tmpfile = g:Grepsel_Output
    if filereadable(tmpfile)
	let del_str = 'del ' . tmpfile
	if (g:GNUgrep == 1)
	    let del_str = 'rm -f ' . tmpfile 
	endif  
	call delete(tmpfile)
    endif
endfunction

" RunGrepselCmd()
" Run the specified grep command using the supplied pattern
function! s:RunGrepselCmd(cmd, pattern)

    let cmd_output = system(a:cmd)
    if cmd_output == ""
        echohl WarningMsg | 
        \ echomsg "Error: Pattern " . a:pattern . " not found" | 
        \ echohl None
        return
    endif
    let tmpfile = g:Grepsel_Output
    let old_verbose = &verbose
    set verbose&vim

    silent echon cmd_output

endfunction

" EditFile()
"
function! s:EditFile()
    let Done = 0    
    let chkerror = 0
    exe 'edit ~/legreprc'
    let fpath=getline('.')
    exe 'bdelete' 
    " memory the last location 
    exe 'normal ' . 'mZ'    

    let chkline = getline('.')
"    let foundln = stridx(chkline,':')
"    let fname = strpart(chkline,0,foundln)
    let item=[]
    for i in split(chkline,":")
	call add(item, i)
    endfor	
    let fnnnn=strpart(item[0],2,strlen(item[0]))
    let fname=fpath.fnnnn
    let fline=str2nr(item[1])
    if fline > 0 
	if filereadable(fname) 
	    exe 'edit ' . fname
	    if strlen(fline)
		exe 'normal ' . fline . 'gg'
	    endif  
	else
	    echo "Invaild filename"
	endif
    else 
	echo "Line Error"	
    endif

endfunction	


" RunGrepsel()
" Run the specified grep command
function! s:RunGrepsel(...)

    " No argument supplied. Get the identifier and file list from user
    let pattern = input("Grep for pattern: ", expand("<cword>"))
    if pattern == ""
	echo "Cancelled."    
	return
    endif
    let grepseldir = input("grepsel dir: ", g:GREPSEL_DIRS)
    if grepseldir == ""
	echo "Cancelled."    
	return
    endif 
    let g:GREPSEL_DIRS = grepseldir
    let cmd = "grepsel " .pattern 
    let last_cd = getcwd()
    exe 'cd ' . grepseldir
    call s:RunGrepselCmd(cmd, pattern)
    exe 'cd ' . last_cd

    if filereadable(g:Grepsel_Output)
	setlocal modifiable 
	exe 'edit ' . g:Grepsel_Output
	setlocal nomodifiable
    endif       

    nnoremap <buffer> <silent> <CR> :call <SID>EditFile()<CR>
    nmap <buffer> <silent> <2-LeftMouse> :call <SID>EditFile()<CR>
    nmap <buffer> <silent> o :call <SID>EditFile()<CR>
    nmap <buffer> <silent> <ESC> :bdelete<CR>
endfunction

function! s:RunGlist()
    setlocal modifiable
    exe 'edit ' . g:Grepsel_Output
    nnoremap <buffer> <silent> <CR> :call <SID>EditFile()<CR>
    nmap <buffer> <silent> <2-LeftMouse> :call <SID>EditFile()<CR>
    nmap <buffer> <silent> o :call <SID>EditFile()<CR>
    nmap <buffer> <silent> <ESC> :bdelete<CR>
    setlocal nomodifiable
endfunction


exe "nnoremap <unique> <silent> " . Glist_Key . " :call <SID>RunGlist()<CR>"
exe "inoremap <unique> <silent> " . Glist_Key . " <C-O>:call <SID>RunGlist()<CR>"

" Define the set of grep commands
command! -nargs=* Gs call s:RunGrepsel(<q-args>)
command! -nargs=* Grepsel call s:RunGrepsel(<q-args>)
command! Glist call s:RunGlist()
silent! nnoremap <unique> <silent> <Leader>ov :Glist<CR>

" vim:tabstop=4:sw=4
