" Language:     info

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal lisp
" quick hack to allow adding values
setlocal iskeyword=@,!,#-',*-:,<-Z,a-z,~,_,94
setlocal lispwords=define

" Enable auto begin new comment line when continuing from an old comment line
setl comments=:;;;;,:;;;,:;;,:;
setl formatoptions+=r

" Simply setting keywordprg like this works:
"    setl keywordprg=raco\ docs
" but then vim says:
"    "press ENTER or type a command to continue"
" We avoid the annoyance of having to hit enter by remapping K directly.
function s:RacketDoc(word) abort
  execute 'silent !raco docs --' shellescape(a:word)
  redraw!
endfunction
nnoremap <buffer> <Plug>RacketDoc :call <SID>RacketDoc(expand('<cword>'))<CR>
if maparg("K", "n") == ""
  nmap <buffer> K <Plug>RacketDoc
endif

" For the visual mode K mapping, it's slightly more convoluted to get the
" selected text:
function! s:Racket_visual_doc()
  try
    let l:old_a = @a
    normal! gv"ay
    call system("raco docs '". @a . "'")
    redraw!
    return @a
  finally
    let @a = l:old_a
  endtry
endfunction

vnoremap <buffer> <Plug>RacketDoc :call <SID>Racket_visual_doc()<cr>
if maparg("K", "v") == ""
  vmap <buffer> K <Plug>RacketDoc
endif

"setl commentstring=;;%s
setl commentstring=#\|\ %s\ \|#

" Undo our settings when the filetype changes away from Racket
" (this should be amended if settings/mappings are added above!)
let b:undo_ftplugin =
      \  "setl iskeyword< lispwords< lisp< comments< formatoptions<"
      \. "| setl commentstring<"
      \. "| nunmap <buffer> K"
      \. "| vunmap <buffer> K"
