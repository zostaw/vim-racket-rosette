" Vim filetype plugin
" Language:             Racket
" Maintainer:           D. Ben Knoble <ben.knoble+github@gmail.com>
" Previous Maintainer:  Will Langstroth <will@langstroth.com>
" URL:                  https://github.com/benknoble/vim-racket
" Last Change: 2022 Aug 12

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" quick hack to allow adding values
setlocal iskeyword=@,!,#-',*-:,<-Z,a-z,~,_,94

" Enable auto begin new comment line when continuing from an old comment line
setl comments=:;;;;,:;;;,:;;,:;
setl formatoptions+=r

"setl commentstring=;;%s
setl commentstring=#\|\ %s\ \|#

" Undo our settings when the filetype changes away from Racket
" (this should be amended if settings/mappings are added above!)
let b:undo_ftplugin =
      \  "setl iskeyword< lispwords< lisp< comments< formatoptions<"
      \. " | setl commentstring<"

if !exists("no_plugin_maps") && !exists("no_racket_maps")
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
  nmap <buffer> K <Plug>RacketDoc

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

  xnoremap <buffer> <Plug>RacketDoc :call <SID>Racket_visual_doc()<cr>
  xmap <buffer> K <Plug>RacketDoc

  let b:undo_ftplugin .=
      \  " | silent! execute 'nunmap <buffer> K'"
      \. " | silent! execute 'vunmap <buffer> K'"
endif

if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
  let b:browsefilter = "Racket Source Files (*.rkt *.rktl)\t*.rkt;*.rktl\n" .
        \              "All Files (*.*)\t*.*\n"
  let b:undo_ftplugin .= " | unlet! b:browsefilter"
endif

if exists("loaded_matchit") && !exists("b:match_words")
  let b:match_words = '#|:|#'
  let b:undo_ftplugin .= " | unlet! b:match_words"
endif

