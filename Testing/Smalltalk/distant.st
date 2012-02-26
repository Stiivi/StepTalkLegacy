" Distant environment example 
    
    Date: 2005 Aug 17
    Author: Stefan Urbanek
    
    Usage: 
        1. run: stenvironment -name test
        2. run: stexec distant.st
        3. repeat step 2. as many times as you like
    
    Step 1. creates a scripting environment. Step 2. executes this script.

"

"Create a conversation with distant environment"
conversation := (STDistantConversation alloc) initWithEnvironmentName:'test'
                                                                 host:nil
                                                             language:nil.

Transcript showLine: '-- Conversation created:', (conversation description).

"Interpret some scripts in the distant environment"
conversation interpretScript:'Transcript showLine:\'Hello StepTalk!\'.'.
conversation interpretScript:'Environment class description'.

"Get run count"

conversation interpretScript:'runCount'.
result := conversation resultByCopy.

"If there is no run count, then we are running first time and we have to 
 define and set the run count to 1"
 
result ifNil:
    [
    Transcript showLine: ('This script was run for first time.').
        conversation interpretScript:'runCount := 0'.
        result := 1.
    ].
    
conversation interpretScript:'runCount := runCount + 1'.
result := conversation resultByCopy.

Transcript showLine: ('This script was run ', (result description), ' times.').

conversation close.
