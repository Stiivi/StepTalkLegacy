| fileManager fileName data |

fileManager := NSFileManager defaultManager.

fileName := '/tmp/TestFile.text'.

('This is some file' writeToFile:fileName atomically:NO)
    ifTrue: 
        [
            Transcript showLine:'File was succesfully created.'
        ]
    ifFalse:
        [
            Transcript showLine:'File was not created.'
        ]


