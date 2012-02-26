| fileName flag |

fileName := '/tmp/TestFile.text'.

flag := NO.

[
    ('This is some file' writeToFile:fileName atomically:NO)
        ifTrue: 
            [ Transcript showLine:'File was succesfully created.']
        ifFalse:
            [ Transcript showLine:'File was not created.']
] 
handler: 
    [ :exception | 
        Transcript showLine:('Handled exception: ',(exception name)).
        Transcript showLine:('Reason           : ',(exception reason)).
        flag := YES
    ].

flag ifTrue:
        [
            Transcript showLine:'Finished with exception'
        ]
     ifFalse:
        [
            Transcript showLine:'Finished succesfully'
        ]

