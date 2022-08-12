" Vim indent file
" Language:     Racket (#lang info)
" Maintainer:   D. Ben Knoble <ben.knoble+github@gmail.com>
" URL:          https://github.com/benknoble/vim-racket
" Last Change: 2022 Aug 12

if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

setlocal lisp autoindent nosmartindent
setlocal lispwords=define

let b:undo_indent = "setlocal lisp< ai< si< lw<"
