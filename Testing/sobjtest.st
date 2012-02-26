"   Test for script objects.

    Author: Stefan Urbanek
    Date: 2003 Aug 6 
"

| object method source engine |

    Environment includeFramework:'StepTalk'.

" Create a script object and set it's environment " 
    object := STScriptObject scriptObject.
    object setEnvironment:Environment.
    
" Get the proper engine "
    engine := STEngine engineForLanguageWithName:'Smalltalk'.

" This is the source of new method "
    source := 'sayHi Transcript showLine: \'Hi.\'. ^self'.

" Create method "
    method := engine methodFromSource:source 
                          forReceiver:object
                        inEnvironment:Environment.

" Add the method to the object "
    object addMethod:method.

" Add another method with an argument "
    source := 'sayHiTo:someone Transcript showLine: (\'Hi \', someone). ^self'.
    method := engine methodFromSource:source 
                          forReceiver:object
                        inEnvironment:Environment.
    object addMethod:method.


" Sent it! "
    object sayHi.
    object sayHiTo:'GNUstep'.
    
    
