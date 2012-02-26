"
pldes.st

    GNUstep plpdes tool rewriten as Smalltalk script for StepTalk

Ussage:
    stexec pldes.st file1 [file2 ...]


"
[| :locale

main
    locale := (NSUserDefaults standardUserDefaults) dictionaryRepresentation.

    ((Args count) < 1 ) 
    ifTrue: 
    [
            Transcript showLine:'No file names given to deserialize.'
    ]
    ifFalse:
    [
        Args do: 
        [  :file | 
            [self deserializeFile:file] 
            handler:
            [ :exception |
                Transcript showLine:'Loading \'', file, '\' - ', (exception reason).
            ]
        ]
    ].

    ^self
!

deserializeFile:file
    | myData myString result out |

    myData := NSData dataWithContentsOfFile: file.
    result := NSDeserializer deserializePropertyListFromData: myData
                                           mutableContainers: NO.

    (result isNil) 
        ifTrue: [
            Transcript showLine:'Loading \'',file, '\' - nil property list'.
        ] 
        ifFalse: [

            myString := result descriptionWithLocale: locale indent: 0.
            myData := myString dataUsingEncoding: NSASCIIStringEncoding.

            out := NSFileHandle fileHandleWithStandardOutput.
            out writeData: myData;
                synchronizeFile.
        ].

    ^self
]
