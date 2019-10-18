UObject
=======
A `UObject`_ is the most basic thing in the unreal reflection system. Heck, it even gave the system a name, the ``UObject-System`` which is found in the ``UObjectCore`` of the unreal engine.
Every `Uobject`_ contains flags and pointers to information which describes the object it self (not the class/type).

Flags
-----
The object flags describe its propertys. (f.e. if it's abstract)

Class
-----
Every `UObject`_ has a valid attribute ``clazz`` which points to the `UClass <UClass>`_ describing the class/type of the `UObject`_