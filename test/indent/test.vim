let v:errors = []

autocmd SwapExists * let v:swapchoice = 'e'
set debug=throw

profile start profile.log
profile func racket#Indent
profile func FindMatch
profile func FindBracket

try
  redir >>errors
    import autoload 'racket.vim'
    defcompile racket.Indent

    for f in glob('*.in', v:false, v:true)
      execute 'edit!' f
      set filetype=racket
      normal! gg=G
      call assert_equal((fnamemodify(f, ':r')..'.out')->readfile()->join("\n"), getline(1, '$')->join("\n"))
    endfor
  redir END
catch
  call assert_report(v:exception)
finally
  if !empty(v:errors)
    call writefile(v:errors, 'errors', 'a')
    1cquit
  endif
  qall!
endtry
