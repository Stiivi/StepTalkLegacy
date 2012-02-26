| actor engine source method |

    actor := STActor actorInEnvironment:Environment.
"Set ivars"

    ivars := NSMutableDictionary dictionary.
    ivars setObject:1 forKey:'number'.
    actor setInstanceVariables:ivars.
    
" Get the proper engine "
    engine := STEngine engineForLanguage:'Smalltalk'.

" This is the source of new method "
    source := 'increment
                    number := number + 1. ^self'.

" Create method "
    method := engine methodFromSource:source 
                          forReceiver:actor
                            inContext:Environment.

" Add the method to the actor "
    actor addMethod:method.

" Add another method with an argument "
    source := 'setNumber:i number := i. ^self'.
    method := engine methodFromSource:source 
                          forReceiver:actor
                            inContext:Environment.
    actor addMethod:method.

    source := 'print
                    Transcript showLine: (\'The number is \', 
                                                (number description)). ^self'.
    method := engine methodFromSource:source 
                          forReceiver:actor
                            inContext:Environment.
    actor addMethod:method.

" Send it! "
    actor print.    
    actor increment.
    actor print.    
    actor increment.
    actor print.    
    actor setNumber:10.    
    actor print.    
    