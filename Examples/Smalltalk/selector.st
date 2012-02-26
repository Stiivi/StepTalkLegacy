" Selector example "

[|

main 
    self performSelector:#hello.
    
    ^nil
!

hello
    | b |
    Transcript showLine:'Hello!'.
    ^self
!
hello2
    Transcript showLine:'Hello!'.
    ^self

!

hello3
    |a|
    Transcript showLine:'Hello!'.
    ^self

]
