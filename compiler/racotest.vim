let current_compiler = 'racotest'

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=raco\ test\ %
CompilerSet errorformat=location:%f:%l:%c
