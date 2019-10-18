UProperty
=========
A `UProperty`_ is a special kind of `UField <UField>`_ which contains a ref to some value of an object.
Also it helps to construct and destruct that value.

Get the value reference
-----------------------
Getting some value reference through a `UProperty`_ is pretty straight forward.
Fist you need to get the `UProperty`_ of the corresponding `UClass <UClass>`_ your `UObject <UObject>`_ uses, then you just need to call the ``getValue`` method and provide the object (context) it self so the `UProperty`_ know from where it should extract the value from.

.. code-block:: c++

    UObject* obj;
    UProperty* prop;
    ValueType* val = prop->getValue<ValueType>(obj);

As you can see, you need to give the function the c++ value type cause it casts the value for you directly.
To get the final value just dereference it.
You're also able to set the value by just using the c++ reference.

.. warning:: If the value stored in the instance is a pointer, you need to use as ValueType a pointer. f.e. a ``UObjectProperty`` contains not the `UObject`_ but a pointer to it!

Building
--------
The BPI provides the ``SML::Paks::PropertyBuilder``-Class in ``assets/BPInterface.h`` to make declaring and defining a custom `UProperty`_ easier.
This class has multiple types of static initializer function for different types of `UPropertys <UProperty>`.

- attrib
    This function initializes a PropertyBuilder for an attribute
- param
    This function initializes a PropertyBuilder for the use as a input paramter for a UFunction
- outParam
    This function initializes a PropertyBuilder for the use as a output paramter for a UFunction

.. Tip:: To get an Returnvalue-Property for a UFunction, add the ``EPropertyFlag::Prop_RetVal``-Flag to a outParam.

When you call one of this function you need to pass the property-type and the name of the property.

Flags
'''''
The builderclass provides the addFlag and removeFlag methods for manipulating the property flag register.

Class-Type
''''''''''
Some types like Object need a `UClass <UClass>`_ to know which `UObjects <UObjects>`_ are allowed in that reference.
For this purpose there is the ``classFunc`` method which wants a function pointer to a function which returns the wanted `UClass <UClass>`_.

.. Tip:: You can use the provided "StaticClass" function of default `UObject`_ -types for this.

Booleans
''''''''
Booleans are tricky. They need a so called bit-set-function. To make this easier the PropertyBuilder-Class provides the ``bool`` function.
This function has template which needs to be a C++ "pointer-to-member" which points to the attribute in your native class.

.. code-block:: c++

    class UTestObj {
        bool isSomething;
    }

    getPropBuilderRef().bool<&UTestObj::isSomething>()

Offset
''''''
Some properties need the offset of the value location to the object-base-pointer like generic ones (f.e. int and Object).
With the ``off`` function you can set that offset, but if you don't set that value then the other builderclasses set that offset automaticly.
The will look for the last given properties offset, add the used byte count onto the offset and then use that one as the new one.

Examples
''''''''

.. code-block:: c++

    class UTestClass {
        bool firstProp;
        float nonProp;
        int seccondProp;
        AActor* thirdProp;
    }

    struct FuncParams {
        int input;
        FString output;
        bool returnVal;
    }

    PropertyBuilder::attrib(EPropertyClass::Bool, "FirstProp").bool<&UTetsClass::firstProp>();
    PropertyBuilder::attrib(EPropertyClass::Int, "WierdName").off(sizeof(bool)+sizeof(float));
    PropertyBuilder::attrib(EPropertyClass::Object, "ThirdProp").classFunc(&AActor::StaticClass);

    PropertyBuilder::param(EPropertyClass::Int, "input");
    PropertyBuilder::outParam(EPropertyClass::Str, "output");
    PropertyBuilder::outParam(EPropertyClass::bool, "retVal").addFlag(EPropertyFlag::Prop_ReturnVal);

Finishing
'''''''''
To finish the build you just need to execute the ``build`` function which returns a pointer to the proper description structure.
This structure is managed by the PropertyBuilder, that means **when the PropertyBuilder runs out of scope, the description structure is invalid!**
That's why other builderclasses want the builder directly and not the build description.