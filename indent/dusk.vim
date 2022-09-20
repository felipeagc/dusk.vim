if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

if (!has("cindent") || !has("eval"))
    finish
endif

setlocal cindent
setlocal cinoptions=L0,m1,(s,j1,J1,l1
setlocal cinkeys=0{,0},0),0],!^F,o,O

setlocal indentexpr=GetDuskIndent(v:lnum)

function! GetDuskIndent(lnum)
    let curretLineNum = a:lnum
    let currentLine = getline(a:lnum)

    " cindent doesn't handle multi-line strings properly, so force no indent
    if currentLine =~ '^\s*\\\\.*'
        return -1
    endif

    let prevLineNum = prevnonblank(a:lnum-1)
    let prevLine = getline(prevLineNum)

    " for lines that look line
    "   },
    "   };
    " try treat them the same as a }
    if prevLine =~ '\v^\s*},$'
        if currentLine =~ '\v^\s*};$' || currentLine =~ '\v^\s*}$'
            return indent(prevLineNum) - 4
        endif
        return indent(prevLineNum-1) - 4
    endif
    if currentLine =~ '\v^\s*},$'
        return indent(prevLineNum) - 4
    endif
    if currentLine =~ '\v^\s*};$'
        return indent(prevLineNum) - 4
    endif


    " cindent doesn't handle this case correctly:
    " switch (1): {
    "   1 => true,
    "       ~
    "       ^---- indents to here
    if prevLine =~ '.*=>.*,$' && currentLine !~ '.*}$'
       return indent(prevLineNum)
    endif

    return cindent(a:lnum)
endfunction
