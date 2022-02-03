let current_compiler = 'racosetup'

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=raco\ setup
CompilerSet errorformat=%f:%l:%c:%m
