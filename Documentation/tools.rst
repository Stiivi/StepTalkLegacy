############
StepTalk Tools
############

Contents:

    stexec
    stshell (from Examples directory)

`stexec` - execute StepTalk script
----------------------------------

Script gets executed in the GNUstep-base environment).

Usage::

    stexec [options] script [args ...] [ , script ...]

    Options:
    -help               print this message
    -list-all-objects   list all available objects
    -list-classes       list available classes
    -list-objects       list named instances

    -language lang      force use of language lang
    -list-languages     list available languages
    -continue           do not stop when one of scripts failed to execute

    -full               enable full scripting
    -environment env    use scripting environment with name env

(You do not have to specify full name of the option (for example, -env), but
when it is not clear, the behaviour is undefined)

Examples::

    $ stexec myScript.st
    $ stexec -env AppKit myAppKitScript.st

Running more than one script (preserves the environment through all scripts)::

    $ stexec myScript1.st , myScript2.st , myScript3.st


`stshell` - StepTalk shell
--------------------------

Usage::

    $ stshell [options] script

Options are::

    -help               this text
    -language lang      use language lang
    -environment env    use scripting environment with name env
