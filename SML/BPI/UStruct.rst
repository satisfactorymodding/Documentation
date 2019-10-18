UStruct
=======
A `UStruct <UStruct>`_ is simply a special data structure which can hold multiple `UFields <UField>`_ and is self a `UField`_. These children describe the instance and its contents like datatypes, array lengths and so on.

Children
--------
These children are simply a row of references until the reference of one `UField <UField>`_ is equal to nullptr.
The first children in that row is reffered by the ``childs`` attribute.

Iterating over children
------------------------
As already said, the children of a `UStruct <UStruct>`_ are additional information of a `UStruct <UStruct>`_ about its f.e. functions, attributes and components.
Each of those are representated through an instance of an `UField <UField>`_ . Important to not is that each `UField <UField>`_ points with the ``next`` attribute to next one of the class.
Iterating is simply following this next-pointer until it reaches nullptr.

.. code-block:: c++

    UStruct* struc;
    UField* field = struc->childs;
    while (field) {
        // Do something with the field
        field = field->next;
    }

If you want to also iterate over extended fields, you will need to switch to the super class when the field pointer reaches nullptr.

.. code-block:: c++

    UStruct* struc;
    UField* field = struc->childs;
    while(field || clazz) {
        if (!field) {
            struc = (UStruct*) struc->super;
            field = struc->childs;
            continue;
        }
        // do stuff
        field = field->next;
    }

and because this is so much to write the ``SML::Objects::UStruct`` implements a C++ iterator.
With that said you can use a c++ for-each loop to iterate over the fields of a `UStruct <UStruct>`_ recursively with following code:

.. code-block:: c++

    UStruct* struc;
    for (UField* field : *struc) {
        // do stuff
    }

Inheritance
-----------
To get the super class of an `UClass <UClass>`_ just simply follow the ``super`` attribute. It contains the pointer to inherited `UStruct <UStruct>`_.
Multiple inheritance is not possible.
