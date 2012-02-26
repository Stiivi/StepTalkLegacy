"
plparse.st

    GNUstep plparse tool rewriten as Smalltalk script for StepTalk

Ussage:
    stexec plparse.st file1 [file2 ...]


"
[|

main

    | string result |

    ((Args count) < 1 ) 
    ifTrue: 
    [
            Transcript showLine:'No file names given to parse.'
    ]
    ifFalse:
    [
        Args do: 
        [ 
            :file | self parseFile:file
        ]
    ].

    ^self
!

parseFile: file

    Transcript show: ('Parsing ', file, ' - ').

    [

        string := NSString stringWithContentsOfFile:file.
        result := string propertyList.

        (result isNil) 
        ifTrue: 
        [ 
            Transcript showLine:'nil property list' 
        ]
        ifFalse:
        [
            (result isKindOfClass: (NSDictionary class)) 

            ifTrue: [ Transcript showLine:'a dictionary']
            ifFalse: 
            [
            (result isKindOfClass: (NSArray class)) 
                ifTrue: [ Transcript showLine:'an array']
                ifFalse: 
                [    
                (result isKindOfClass: (NSData class)) 
                ifTrue: [ Transcript showLine:'a data']
                ifFalse: 
                    [
                        (result isKindOfClass: (NSString class)) 
                        ifTrue: [ Transcript showLine:'a string']
                        ifFalse: 
                        [
                            Transcript showLine: ('unexpected class - ', 
                                              result class description )
                        ]
                    ]
                ]
            ]
        ]
    ]
    handler:
    [
        :localException |
    	Transcript showLine: (localException reason)
    ].
]
