" hello

  Say hello to someone specified as an argument.

  Ussage:
      stexec hello.st name
"

" Is name specified? (Is there some script argument?) "

((Args count) > 0 ) 
ifTrue: 
    [
        " Args is an array of script arguments. "

        Transcript showLine: ('Hello ', (Args @ 0), '!').
    ]
ifFalse:
    [
        Transcript showLine:'Hello ... who?'
    ]
