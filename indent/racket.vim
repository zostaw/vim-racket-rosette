" Language:     Racket
" Maintainer:   Will Langstroth <will@langstroth.com>
" URL:          http://github.com/wlangstroth/vim-racket

if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

setlocal lisp autoindent nosmartindent

setlocal lispwords+=module,module*,module+,parameterize,let-values,let*-values,letrec-values,local
setlocal lispwords+=define/contract
setlocal lispwords+=λ
setlocal lispwords+=with-handlers
setlocal lispwords+=define-values,opt-lambda,case-lambda,syntax-rules,with-syntax,syntax-case,syntax-parse
setlocal lispwords+=define-for-syntax,define-syntax-parser,define-syntax-parse-rule,define-syntax-class,define-splicing-syntax-class
setlocal lispwords+=define-signature,unit,unit/sig,compund-unit/sig,define-values/invoke-unit/sig
setlocal lispwords+=define-opt/c,define-syntax-rule
setlocal lispwords+=define-test-suite
setlocal lispwords+=struct
setlocal lispwords+=with-input-from-file,with-output-to-file

" Racket OOP
setlocal lispwords+=class,define/public,define/private,define/override

" kanren
setlocal lispwords+=fresh,run,run*,project,conde,condu

" loops
setlocal lispwords+=for,for/list,for/fold,for*,for*/list,for*/fold,for/or,for/and,for*/or,for*/and
setlocal lispwords+=for/hash,for/hasheq,for/hasheqv,for/sum,for/flvector,for*/flvector,for/vector,for*/vector,for*/sum,for*/hash,for*/hasheq,for*/hasheqv
setlocal lispwords+=for/async
setlocal lispwords+=for/set,for*/set
setlocal lispwords+=for/first,for*/first

setlocal lispwords+=match,match*,match/values,define/match,match-lambda,match-lambda*,match-lambda**
setlocal lispwords+=match-let,match-let*,match-let-values,match-let*-values
setlocal lispwords+=match-letrec,match-define,match-define-values

setlocal lispwords+=let/cc,let/ec

" qi
setlocal lispwords+=define-flow,define-switch,flow-lambda,switch-lambda,on,switch,π,λ01
setlocal lispwords+=define-qi-syntax,define-qi-syntax-parser,define-qi-syntax-rule

let b:undo_indent = "setlocal lisp< ai< si< lw<"
