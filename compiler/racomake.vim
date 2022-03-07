" Vim compiler file
" Compiler:     raco make (Racket command-line tools)
" Maintainer:   D. Ben Knoble <ben.knoble+github@gmail.com>
" URL:          https://github.com/benknoble/vim-racket

let current_compiler = 'racomake'

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=raco\ make\ --\ %
