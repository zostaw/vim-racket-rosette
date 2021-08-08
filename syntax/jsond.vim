" Vim syntax file
" Language:     #lang jsond

if exists("b:current_syntax")
  finish
endif

" Hack: the syntax/json.vim file only permits numbers followed by blanks
" followed by some kind of object or array delimiter
" JSON the spec says a JSON is an element is a whitespace-delimited value, which
" can be any of an object, an array, a string, a number, or the keywords
" true/false/null
" Ref: https://www.json.org/json-en.html
syntax match jsonNumber "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>"
syntax keyword jsonBoolean true false
syntax keyword jsonNull null

syntax cluster json contains=jsonObject,jsonArray,jsonNumber,jsonStringMatch,jsonBoolean,jsonNull

syntax region jsonArray matchgroup=jsonBraces start=/\[/ end=/]/ contains=@json fold
syntax region jsonObject matchgroup=jsonBraces start=/{/ end=/}/ contains=jsonKeyMatch fold

syntax match jsonKeyMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*:/ contains=jsonKey nextgroup=@json skipwhite
syntax region jsonKey start=/"/ end=/"\ze[[:blank:]\r\n]*:/ contained

syntax match jsonStringMatch /"\([^"]\|\\\"\)\+"/ contains=jsonString
syntax region jsonString oneline start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=jsonEscape contained

syntax match jsonEscape ,\\["\\/bfnrt], contained
syntax match jsonEscape /\\u\x\{4\}/ contained

" syntax iskeyword 33,35-39,42-58,60-90,94,95,97-122,126,_
" converted from decimal to char
" :s/\d\+/\=submatch(0)->str2nr()->nr2char()/g
" but corrected to remove duplicate _, move ^ to end
" also exclude comma, for JSON
syntax iskeyword @,!,#-',*-:,<-Z,a-z,~,_,^,,^
" expanded
" syntax iskeyword !,#,$,%,&,',*,+,,,-,.,/,0-9,:,<,=,>,?,@,A-Z,_,a-z,~,^,,^

syntax match jsondSyntax "#lang " nextgroup=jsondLang
syntax keyword jsondLang jsond

syntax keyword jsondName #:name nextgroup=jsondVarName skipwhite skipempty
syntax match jsondVarName ,\<\k\+\>, contained nextgroup=@json skipwhite skipempty

" Comments
syntax match jsondComment /;.*$/ contains=jsondTodo,jsondNote,@Spell
syntax region jsondMultilineComment start=/#|/ end=/|#/ contains=jsondMultilineComment,jsondTodo,jsondNote,@Spell

syntax keyword jsondTodo FIXME TODO XXX contained
syntax match jsondNote /\CNOTE\ze:\?/ contained

highlight default link jsondSyntax Statement
highlight default link jsondName Type

highlight default link jsondComment Comment
highlight default link jsondMultilineComment Comment

highlight default link jsondTodo Todo
highlight default link jsondNote SpecialComment

highlight default link jsonNumber Number
highlight default link jsonBoolean Boolean
highlight default link jsonNull Constant
highlight default link jsonString String
highlight default link jsonEscape Special
highlight default link jsonKey Label

let b:current_syntax = "jsond"
