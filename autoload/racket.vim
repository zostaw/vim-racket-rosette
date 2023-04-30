vim9script

export def Indent(): number
  return lispindent(v:lnum)
enddef
