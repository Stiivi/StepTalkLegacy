Modules
-------

Here is a brief list of available modules and list of what they provide.

To load a module use: Environment loadModule:'moduleName' or put name of a
module into a Modules list into a scripting environment you use, like:
    ~/.../Library/StepTalk/Environments/My.stenv
    
.. code-block:: json

    {
        Use = (Foundation);
        Modules = (moduleName);
    }


**Foundation:**

* public Foundation/gnustep-base classes
* extern variables, like exception and notification names

**AppKit:**

* public AppKit/gnustep-gui classes
* extern variables
    
**ObjectiveC:**

* object named `Runtime` with methods:
    * `- classWithName:string`
    * `- nameOfClass:class`
    * `- selectorsContainingString:` – returns an array of selectors that contain
      specified string
    * `- implementorsOfSelector:` returns an array of all classes that implement
      specified selector
            
* additions to `NSObject`:
    * `+ instanceMethodNames`
    * `- methodNames`
    * `+ methodNames`
    * `+ instanceVariableNames`

