"
    Script shell - shell written in script.
    
    This is just an example.
    
    Run it by: stexec shell.st
    
    Author: Stefan Urbanek
    Date:   2003 Oct 3

"

[| :done

main
    | line env engine result |
    
    Environment includeFramework:'StepTalk'.
    Environment loadModule:'ReadlineTranscript'.
    
    " Create environment "
    env := STEnvironment defaultScriptingEnvironment.
    env setObject:env forName:'Environment'.
    env setObject:Transcript forName:'Transcript'.
    env setObject:self forName:'Shell'.
    
    " Create and setup engine "
    engine := STEngine engineForLanguage:'Smalltalk'.

    " Do the loop! "
    
    [ done ] whileFalse: [ 
        line := Transcript readLine:'Shell > '.
        (line = 'exit') ifTrue: [ done := YES ].
        result := engine executeCode: (line, ' ') inEnvironment:env.
        Transcript showLine: result.
    ].
    ^self
!
    
exit
        Transcript showLine: 'BLAH'.
    done := YES.    
    ^self
]
