" Vim syntax file
" Language:     Racket (#lang info)
" Maintainer:   D. Ben Knoble <ben.knoble+github@gmail.com>
" URL:          https://github.com/benknoble/vim-racket

" Initializing:
if exists("b:current_syntax")
  finish
endif

" Highlight unmatched parens
syntax match infoError ,[]})],

" syntax match fallbackError /./

if version < 800
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
else
  " syntax iskeyword 33,35-39,42-58,60-90,94,95,97-122,126,_
  " converted from decimal to char
  " :s/\d\+/\=submatch(0)->str2nr()->nr2char()/g
  " but corrected to remove duplicate _, move ^ to end
  syntax iskeyword @,!,#-',*-:,<-Z,a-z,~,_,^
  " expanded
  " syntax iskeyword !,#,$,%,&,',*,+,,,-,.,/,0-9,:,<,=,>,?,@,A-Z,_,a-z,~,^
endif

" https://docs.racket-lang.org/raco/info_rkt.html?q=info

syntax keyword infoSyntax define quote quasiquote if

syntax keyword infoPrimitive cons car cdr list list* reverse append equal?
syntax keyword infoPrimitive string-append make-immutable-hash hash hash-set
syntax keyword infoPrimitive hash-set* hash-remove hash-clear hash-update
syntax keyword infoPrimitive path->string build-path collection-path
syntax keyword infoPrimitive system-library-subpath getenv

syntax match datumDelimiter !\<\.\>!

syntax cluster infoTop contains=infoSyntax,infoPrimitive,datumDelimiter

syntax match infoConstant ,\<\*\k\+\*\>,
syntax match infoConstant ,\<<\k\+>\>,

" Non-quoted lists, and strings
syntax region infoStruc matchgroup=infoParen start="("rs=s+1 end=")"re=e-1 contains=@infoTop
syntax region infoStruc matchgroup=infoParen start="#("rs=s+2 end=")"re=e-1 contains=@infoTop
syntax region infoStruc matchgroup=infoParen start="{"rs=s+1 end="}"re=e-1 contains=@infoTop
syntax region infoStruc matchgroup=infoParen start="#{"rs=s+2 end="}"re=e-1 contains=@infoTop
syntax region infoStruc matchgroup=infoParen start="\["rs=s+1 end="\]"re=e-1 contains=@infoTop
syntax region infoStruc matchgroup=infoParen start="#\["rs=s+2 end="\]"re=e-1 contains=@infoTop

for lit in ['hash', 'hasheq', 'hasheqv']
  execute printf('syntax match infoLit "\<%s\>" nextgroup=@infoParen containedin=ALLBUT,.*String,.*Comment', '#'.lit)
endfor

for lit in ['rx', 'rx#', 'px', 'px#']
  execute printf('syntax match infoRe "\<%s\>" nextgroup=@infoString containedin=ALLBUT,.*String,.*Comment,', '#'.lit)
endfor

unlet lit

" Simple literals
syntax region infoString start=/\%(\\\)\@<!"/ skip=/\\[\\"]/ end=/"/
syntax region infoString start=/#<<\z(.*\)$/ end=/^\z1$/

syntax cluster infoTop add=infoError,infoConstant,infoStruc,infoString

" Numbers

" anything which doesn't match the below rules, but starts with a #d, #b, #o,
" #x, #i, or #e, is an error
syntax match infoNumberError "\<#[xdobie]\k*"

syntax match infoContainedNumberError "\<#o\k*[^-+0-7delfinas#./@]\>"
syntax match infoContainedNumberError "\<#b\k*[^-+01delfinas#./@]\>"
syntax match infoContainedNumberError "\<#[ei]#[ei]"
syntax match infoContainedNumberError "\<#[xdob]#[xdob]"

" start with the simpler sorts
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\?\d\+/\d\+\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\?\d\+/\d\+[-+]\d\+\(/\d\+\)\?i\>" contains=infoContainedNumberError

" different possible ways of expressing complex values
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?i\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?[-+]\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?i\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f][-+]\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?i\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?[-+]\(inf\|nan\)\.[0f]i\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?@[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f]@[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?@[-+]\(inf\|nan\)\.[0f]\>" contains=infoContainedNumberError

" hex versions of the above (separate because of the different possible exponent markers)
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?\>"
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\x\+/\x\+\>"
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\x\+/\x\+[-+]\x\+\(/\x\+\)\?i\>"

syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?i\>"
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?[-+]\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?i\>"
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\(inf\|nan\)\.[0f][-+]\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?i\>"
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?[-+]\(inf\|nan\)\.[0f]i\>"
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?@[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?\>"
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\(inf\|nan\)\.[0f]@[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?\>"
syntax match infoNumber "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?@[-+]\(inf\|nan\)\.[0f]\>"

" these work for any radix
syntax match infoNumber "\<\(#[xdobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f]i\?\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[xdobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f][-+]\(inf\|nan\)\.[0f]i\>" contains=infoContainedNumberError
syntax match infoNumber "\<\(#[xdobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f]@[-+]\(inf\|nan\)\.[0f]\>" contains=infoContainedNumberError

syntax keyword infoBoolean #t #f #true #false #T #F

syntax match infoError "\<#\\\k*\>"

syntax match infoChar "\<#\\.\w\@!"
syntax match infoChar "\<#\\space\>"
syntax match infoChar "\<#\\newline\>"
syntax match infoChar "\<#\\return\>"
syntax match infoChar "\<#\\null\?\>"
syntax match infoChar "\<#\\backspace\>"
syntax match infoChar "\<#\\tab\>"
syntax match infoChar "\<#\\linefeed\>"
syntax match infoChar "\<#\\vtab\>"
syntax match infoChar "\<#\\page\>"
syntax match infoChar "\<#\\rubout\>"
syntax match infoChar "\<#\\\o\{1,3}\>"
syntax match infoChar "\<#\\x\x\{1,2}\>"
syntax match infoChar "\<#\\u\x\{1,6}\>"

syntax cluster infoTop add=infoNumber,infoBoolean,infoChar

syntax match infoSyntax "#lang " nextgroup=infoLang
syntax keyword infoLang info setup/infotab
syntax match infoExtSyntax "#:\k\+"

syntax cluster infoTop add=infoExtFunc,infoExtSyntax

" syntax quoting, unquoting and quasiquotation
syntax match infoQuote "#\?['`]"

syntax match infoUnquote "#,"
syntax match infoUnquote "#,@"
syntax match infoUnquote ","
syntax match infoUnquote ",@"

" Comments
syntax match infoComment /;.*$/ contains=infoTodo,infoNote,@Spell
syntax region infoMultilineComment start=/#|/ end=/|#/ contains=infoMultilineComment,infoTodo,infoNote,@Spell
syntax match infoFormComment "#;" nextgroup=@infoTop

syntax keyword infoTodo FIXME TODO XXX contained
syntax match infoNote /\CNOTE\ze:\?/ contained

syntax cluster infoTop add=infoQuote,infoUnquote,infoComment,infoMultilineComment,infoFormComment

" Synchronization and the wrapping up...
syntax sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

" Define the default highlighting.
highlight default link infoSyntax Statement
highlight default link infoPrimitive Function

highlight default link infoString String
highlight default link infoChar Character
highlight default link infoBoolean Boolean

highlight default link infoNumber Number
highlight default link infoNumberError Error
highlight default link infoContainedNumberError Error

highlight default link infoQuote SpecialChar
highlight default link infoUnquote SpecialChar

highlight default link datumDelimiter Delimiter
highlight default link infoParen Delimiter
highlight default link infoConstant Constant

highlight default link infoLit Type
highlight default link infoRe Type

highlight default link infoComment Comment
highlight default link infoMultilineComment Comment
highlight default link infoFormComment SpecialChar
highlight default link infoTodo Todo
highlight default link infoNote SpecialComment
highlight default link infoError Error
highlight default link fallbackError Error

highlight default link infoExtSyntax Type
highlight default link infoExtFunc PreProc

let b:current_syntax = "racket-info"
