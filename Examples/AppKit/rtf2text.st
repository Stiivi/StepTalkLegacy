"
    rtf2text.st 
    
    Convert RTF document to plain text.
 
    ussage: stexec rtf2text infile outfile
    
"

| infile outfile rtfString |

Environment loadModule:'AppKit'.

((Args count) < 2)
ifTrue:
[
    Transcript showLine:'rtf2text: Please specify input and output filename'.
]
ifFalse:
[
    infile := Args @ 0.
    outfile := Args @ 1.

    rtfString := (NSAttributedString  alloc) 
                            initWithPath:infile documentAttributes:nil.

    (rtfString string) writeToFile:outfile atomically:YES.

]
