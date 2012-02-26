StepTalk
--------

Ahthor: Stefan Urbanek (Google the name for contact)
License: LGPL (see file COPYING)

**IMPORTANT**: This is legacy project and it is no longer maintained by me - the author.


What is StepTalk ?
------------------

StepTalk is a scripting framework for creating scriptable servers or
applications. StepTalk, when combined with the dynamism that the Objective-C
language provides, goes way beyond mere scripting.  It is written using
GNUstep.


Where to get it?
----------------

StepTalk requires GNUstep http://www.gnustep.org

You can download StepTalk from 

    http://www.gnustep.org/experience/StepTalk.html

Documentation for users and developers:

    http://wiki.gnustep.org/index.php/Scripting


Installation
------------

You need to have GNUstep which you can get from http://www.gnustep.org

To install StepTalk type:

    > make
    > make install

If you do not want to build AppKit extensions, then type

    > make appkit=no
    > make appkit=no install

If something goes wrong while build process and it is not while building in the
Source directory, then try to do make and make install in that directory first. 
In any case of problem, do not hesitate to contact the author.

StepTalk Shell is included in Examples/Shell directory. It requires libncurses.

Tools
-----
    stexec - execute a StepTalk script in the GNUstep Foundation environment
    stalk  - talk to named server
    stupdate_languages - update the available languages info

    stshell - StepTalk shell - interactive tool (in Examples/Shell)
    
    Predefined objects for executing scripts by 'stexec'
    
        Args          - command line arguments
        Engine        - scripting engine
        Environment   - scripting environment

        Transcript    - simple transcript


Sripting environment description
-------------------------------------------

Scripting environment description is used to translate the method names and/or
allow or deny the methods for concrete classes. Denying methods can be used to
create safe scripting  environment as prevention against script viruses.

It contains:
    - list of methods, that are available for scripting for particular class
    - symbolic selector (operator) to selector mapping
    - list of modules to be loaded
    - list of object finders


Standard vs. full scripting
---------------------------
Before each message send, selector is translated using scipting description.
When standard scripting is used and there is no such selector avilable for
scripting for target object, then an exception is raised. With full scripting,
any message should be sent to any target object.

Files
-----
    StepTalk is looking for its files in GNUSTEP_*_ROOT/Library/StepTalk
    
    There should be these directories:
    
    Configuration - Configuration files        
    Environments  - Directory containig environment descriptions
    Finders       - Object finders
    Languages     - StepTalk language bundles
    Modules       - StepTalk modules
    Scripts       - Directory containig StepTalk scripts

Defaults
--------
See Documentation/Defaults.txt


Feedback
--------
Send comments, questions and suggestions to: discus-gnustep@gnu.org

Send bug reports to: bug-gnustep@gnu.org
