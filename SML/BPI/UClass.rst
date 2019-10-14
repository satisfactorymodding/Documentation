UClass
======
A UClass is a UStruct containing information about a native class and how to use it properly.
Every UObject is created by a UClass instance. Such instance contains information like constructor pointer, property/attribute array, functions and name.

Containing information
----------------------
- Name
    The name of an UClass not only names it, but also gives base information about its usage. Such name has a one character based prefix. ``U`` describes the use as a normal UObject. ``A`` describes the use as an Actor in a scene.
    
    f.e. ``UClass``, ``UTutorialObj`` and ``ATutorialBuilding``
- Children
    All "optional" information like attributes, functions and components are stored in this Field row.
    One field points to the next one with the ``next`` attribute until there is nothing left to describe the class.
- Class Flags
    This is a flag register about typical stats of a class like if it's abstract or if its visible to the BP VM.
- Cast Flags
    This is a flag register describes to which basic unreal types a ``UObject`` of this ``UClass`` is castable to.

Inheritance
-----------
To get the super class of an UClass just simply follow the ``super`` attribute (of base class UStruct)

Itterating over children
------------------------
As already said, the children of a ``UClass`` are additional information of a ``UClass`` about its f.e. functions, attributes and components.
Each of those are representated through an instance of an ``UField`` . Important to not is that each ``UField`` points with the ``next`` attribute to next one of the class.
Itterating is simply following this next-pointer until it reaches nullptr.

.. code-block:: c++

    UClass* clazz;
    UField* field = clazz->childs;
    while (field) {
        // Do something with the field
        field = field->next;
    }

If you want to also itterate over extended fields, you will need to switch to the super class when the field pointer reaches nullptr.

.. code-block:: c++

    UClass* clazz;
    UField* field = clazz->childs;
    while(field || clazz) {
        if (!field) {
            clazz = (UClass*) clazz->super;
            field = clazz->childs;
            continue;
        }
        // do stuff
        field = field->next;
    }


The problem is, 

Building
--------
