Environment loadModule:'ReadlineTranscript'.
Transcript showLine: 'Readline test'.
line := Transcript readLine:'Write something: '.
Transcript showLine: line uppercaseString.
