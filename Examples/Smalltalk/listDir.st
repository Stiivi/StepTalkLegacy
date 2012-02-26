" List contents of current directory "

" Script variables "
| fileManager path files dict |

" Get default file manager "
fileManager := NSFileManager defaultManager.


" Get current path "
path := fileManager currentDirectoryPath.

" Write label on Transcript (for shell it is standard output) "
Transcript showLine:( 'Listing of directory: ', path ).

" Get files from 'path' "
files := fileManager directoryContentsAtPath:path.

" For each file from files do the following ..."
files do:
    [ :file |

        dict := fileManager fileAttributesAtPath: (path / file)
                            traverseLink:NO.
                            
        Transcript showLine:file.

        Transcript showLine: ('    Type: ', (dict @ NSFileType)).
        Transcript showLine: ('    Size: ', ((dict @ NSFileSize) stringValue)).
        Transcript showLine: ('    Date: ', ((dict @ NSFileModificationDate) 
                                                                  description)).

        Transcript showLine:''
    ]


