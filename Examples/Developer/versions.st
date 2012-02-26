" Print versions of all (public) GNUstep classes 

    Use: 
        > stexec versions.st
    
    To include AppKit classes:
        > stexec -environment AppKit versions.st

"

| classes versions names |

    classes := Environment objectDictionary allValues.

    classes := classes select: [ :class | class isClass].
    classes := classes select: [ :class | class respondsToSelector:#className].
    classes := classes select: [ :class | class respondsToSelector:#version].

    versions := NSMutableDictionary dictionary.
    
    classes do: 
    [ :class | 
        versions setObject: (class version) 
                    forKey: (class className).
    ].
                                       

    names := versions allKeys sortedArrayUsingSelector: #compare:.
    
    names do: 
    [ :key | 
        Transcript showLine: ( key, ' ', 
                                ((versions objectForKey:key) stringValue)) 
    ].
