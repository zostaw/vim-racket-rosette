let g:racket_hash_lang_modifiers = [
      \ 'at-exp',
      \ 'pollen/mode',
      \ ]

let g:racket_hash_lang_modifiers_regex = '\%('.mapnew(g:racket_hash_lang_modifiers, {_, v -> printf('\<%s\>', escape(v, '\'))})->join('\|').'\)'

let g:racket_hash_lang_regexp = '^#lang\s\+\%\('.g:racket_hash_lang_modifiers_regex.'\s\+\)\?\([^][)(}{[:space:]]\+\)'
let g:racket_hash_lang_dict = get(g:, 'racket_hash_lang_dict',
      \ {
      \   'racket/base': 'racket',
      \   'typed/racket': 'racket',
      \   'typed/racket/base': 'racket',
      \   'br': 'racket',
      \   'br/quicklang': 'racket',
      \   'scribble/base': 'scribble',
      \   'scribble/manual': 'scribble',
      \   'info': 'racket-info',
      \   'setup/infotab': 'racket-info',
      \ })

" Tries to detect filetype from #lang line; defaults to ft=racket.
function! RacketDetectHashLang()
  let matches = matchlist(getline(1), g:racket_hash_lang_regexp)
  if ! empty(matches)
    execute 'set filetype='.get(g:racket_hash_lang_dict, matches[1], substitute(matches[1], '[/\*?[|<>]', '', 'g'))
  else
    set filetype=racket
  endif
endfunction

au BufRead,BufNewFile *.rkt,*.rktl call RacketDetectHashLang()
