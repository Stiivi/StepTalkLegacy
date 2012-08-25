StepTalk HowTo
--------------

NOTE: This file has to be written.

You may consult StepTalk header files.


How to create scripting environment
-----------------------------------

.. code-block:: objective-c

    STEnvironment *env;
    env = [STEnvironment defaultScriptingEnvironment];

or

.. code-block:: objective-c

    env = [STEnvironment environmentWithDescriptionName:envName];


How to register named objects in the scripting environment
----------------------------------------------------------

.. code-block:: objective-c

    [env setObject:object forName:@"ObjectName"];

like in:

.. code-block:: objective-c

    [env setObject:transcript forName:@"Transcript"];

See: STEnvironment

How to create a scripting engine
--------------------------------

.. code-block:: objective-c

    STEngine *engine;
    engine = [STEngine engineForLanguageWithName:langName];

See: STLanguage, STEngine

How to execute a code
---------------------

.. code-block:: objective-c

    STEngine *engine;
    id        result;

    NS_DURING
        result = [engine executeCode:string inEnvironment:env];
    NS_HANDLER
        /* handle the exception */        
    NS_ENDHANDLER

See: STEngine, NSException

How to create a language bundle
-------------------------------

See:

* Languages/Smalltalk/SmalltalkEngine.m
* Languages/Smalltalk/SmalltalkEngine.h
* Languages/Smalltalk/STBytecodeInterpreter.m
        ``- sendSelectorAtIndex:withArgCount:``
    
