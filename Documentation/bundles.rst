+++++++
Bundles
+++++++

Any bundle, including an application or a framework, can provide information
about scripting.

Info dictionary
---------------

* `STClasses` - array of public classes
* `STScriptingInfoClass` - name of a scripting controller. Default value is
  bundleNameScriptingInfo.
* `STExportAllClasses` - exports all classes (ignore STClasses; not used yet)


Scripting Controller
--------------------

Scripting controller is a class object that provides information about bundle
scripting abilities. At this time it provides information only about available
named objects.

Informal protocol:

.. code-block:: objective-c

    + (NSDictionary *)namedObjectsForScripting;

Returns a dictionary with named objects.


TODO:

STBundle methods
----------------

.. code-block:: objective-c

    + bundleWithApplication:
        Search in */Applications
    
    + bundleWithFramework:
        Search in */Library/Frameworks
    
    + bundleWithName:
        Search in */Library/Bundles
