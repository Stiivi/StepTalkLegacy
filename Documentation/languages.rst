+++++++++
Languages
+++++++++

How to create a language bundle?

In directory Languages/Smalltalk/ see files

* SmalltalkEngine.[hm]
* SmalltalkInfo.plist

and in STBytecodeInterpreter.m see method ``- sendSelectorAtIndex:withArgCount:``
    

LanguageInfo.plist
------------------

* ``STLanguageName``: Language name that will be used instead of bundle name.
* ``STEngine``: Engine class name. If there is no such class, then princicpial
  class will be used.
