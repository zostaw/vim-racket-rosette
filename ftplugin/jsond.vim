" Language:     jsond

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Enable auto begin new comment line when continuing from an old comment line
setl comments=:;;;;,:;;;,:;;,:;
setl formatoptions+=r

"setl commentstring=;;%s
setl commentstring=#\|\ %s\ \|#

let b:ale_linter_aliases = ['racket']

" Undo our settings when the filetype changes away from jsond
" (this should be amended if settings/mappings are added above!)
let b:undo_ftplugin =
      \  "setl comments< formatoptions<"
      \. "| setl commentstring<"
      \. "| unlet b:ale_linter_aliases"
