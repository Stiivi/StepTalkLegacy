[| :array

main
    
    self testBlock.
    self testExceptions.
    ^self
    
!    

testBlock
    | count array |

    Transcript showLine:'> Block test'.
    
    array := #( ).
    1 to: 5 do: [ :i | array addObject:i ].

    count := 0.
    array do: [ :element | count := count + 1. ].

    Transcript showLine:'count ', (count stringValue).
    
    array do: [ :i |
        array do: [ :j |
            Transcript show:((i stringValue), (j stringValue),' ').
        
        ].
        Transcript show:'\n'.
    ].
    
    ^self
    
    
!

testExceptions
    
    Transcript showLine:'> Exception handler test'.

    [ NSException raise:'Some exception' format:' '. ] 
    handler:
    [ :localException |
        Transcript showLine:('    Exception: ', localException name).
    ].

    ^self
]
