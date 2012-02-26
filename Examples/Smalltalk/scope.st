" Variable scope example 

    try to run:
    
    > stexec scope.st , scope.st
    
"

[| :global

main
    | local |
    
    Transcript showLine: ':: Start'.

    (extern isNil) ifTrue: 
    [
        Transcript showLine: 'Script was run for first time. Setting extern.'.
        extern := 100.
    ]
    ifFalse:
    [
        Transcript showLine: 'Extern: ', (extern stringValue).
    ].
    
    local := 10.
    Transcript showLine: 'Local: ', (local stringValue).

    self setLocal:20.
    Transcript showLine: 'Local after call: ', (local stringValue),
                         ' (has to be 10 not 20)'.

    global := 10.
    Transcript showLine: 'Global: ', (global stringValue).

    self setGlobal:20.
    Transcript showLine: 'Global after call 1: ', (global stringValue),
                         ' (has to be 20 not 10)'.

    self testGlobal.
    Transcript showLine: 'Global after call 2: ', (global stringValue),
                         ' (has to be 20 not 0)'.

    ^nil
!

setLocal:val
    | local |
    local := val.
    ^self
!

setGlobal:val
    global := val.
    ^self
!
    
testGlobal
    | global |
    global := 0.
    ^self

]
