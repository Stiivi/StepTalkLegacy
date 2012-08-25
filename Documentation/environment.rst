Scripting environment descriptions
----------------------------------

Property list containing dictionary with keys:

* ``Name``: Name of scripting description
* ``Use``: Array of scripting descriptions to include.
* ``Modules``: Array of modules to be loaded
* ``Finders``: Array of object finder names to be used
* ``Behaviours``: Dictionary of behaviour descriptions, that can be adopted by
  a class or another behaviour.
* ``Classes``: Dictionary of class descriptions.
* ``DefaultRestriction``
* ``Aliases``: object name aliases (not impl.)


``Behaviours``:

* ``Use``: Adopt behaviour
* ``SymbolicSelectors``: Map of symbolic selectors.
* ``Aliases``: Method name aliases.
* ``AllowMethods``: List of allowed methods.
* ``DenyMethods``: List of denied methods.


``Classes``:

(Same items as in ``Behaviours``)

* ``Super``: Super class name.
* ``Restriction``: Values might be ``DenyAll`` or ``AllowAll``. ``DenyAll``
  deny all methods except those in ``AllowMethods`` list or in ``Aliases``
  ``AllowAll`` allow all methods except those in ``DenyMehods`` list.

