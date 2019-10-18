UClass
======
A `UClass`_ is a `UStruct <UStruct>`_ containing information about a native class and how to use it properly.
Every `UObject <UObject>`_ is created by a `UClass`_ instance. Such instance contains information like constructor pointer, property/attribute array, functions and name.

Containing information
----------------------
- Name
    The name of an `UClass`_ not only names it, but also gives base information about its usage. Such name has a one character based prefix. ``U`` describes the use as a normal UObject. ``A`` describes the use as an Actor in a scene.
    
    f.e. ``UClass``, ``UTutorialObj`` and ``ATutorialBuilding``
- Class Flags
    This is a flag register about typical stats of a class like if it's abstract or if its visible to the BP VM.
- Cast Flags
    This is a flag register describes to which basic unreal types a ``UObject`` of this ``UClass`` is castable to.

Building
--------

Building is the most complex thing in the BPI cause there are just so many parameters which need to get set properly.
The beginning makes the ``SML::Paks::ClassBuilder``-Builderclass in ``assets/BPInterface.h``
This builder class is a bit special because it has a template which should be your class you want to reflect.
The builderclass will automaticaly use the native name of your class to call ``name(std::string name)`` 

.. warning:: Your native class name should due to this contain a ``A`` or ``U`` as prefix. If not, please call the ``name(std::string name)`` function manually to set the reflected name to a name with this prefix.

Example:

.. code-block:: c++

    class UDocClass {}

    SML::Paks::ClassBuilder<UDocClass>::Basic();

as you can see you need to use the ``Basic()`` function to get the proper ClassBuilder reference.
Its just a reference because this class builder needs to exist all the time and works like a singelton and this ``Basic()`` function just initializes the singelton with a basic setup and returns the reference to the singeltons instance.

Flags
'''''
You can define class flags, like if it should be visible, with the flag functions.
``addFlag(SML::Objects::EClassFlags flags)``, ``addFlag(int flags)`` and ``removeFlag(SML::Objects::EClassFlags flags)`` are used to help defining the class-flag-register.
The same principle applies to class cast flags but with the classes f.e. ``addCastFlag(...)``

Extending
'''''''''
You need to explicitly tell the builder which reflected superclass your class has (even if its just the basic `UObject <UObject>`_).
To make this more easy the builder class implements two function which takes each of them a class type to execute their ``StaticClass()`` functions.
If you don't want to do this through templates you can also use the ``superFunc(UClass*(*classFunc)())`` and pass a function pointer returning the `UClass`_ of your super class.

- ``extend<class T>()`` is used if the given class has a function with the declaration ``UClass* staticClass()`` to return the `UClass`_
- ``extendSDK<class sdkT>()`` is used if the given class has a function with the declaration ``SDK::UClass* StaticClass`` to return the `UClass`_

*jeah ik, it's wierd, but hey! It makes it more easy to use! And if you don't like it, you can just use* ``superFunc(UClass*(*classFunc)())``

.. warning:: Unreals reflection system does not support multi inheritance like c++ does, that means you can't the extend function twice to have two classes inherited, instead you would probably just overwrite the old one.

Example:

.. code-block:: c++

    class UDocClass : public SML::Objects::UObject {}
    class UDocActor : public SDK::AActor {}

    SML::Paks::ClassBuilder<UDocClass>::Basic().extend<SML::Objects::UObject>()
    SML::Paks::ClassBuilder<UDocClass>::Basic().extendSDK<SDK::AActor>();

Attributes
''''''''''
Attributes (aka. member-variables) which need to get reflected get defined with the ``param(SML::Paks::PropertyBuilder builder)`` function.
Simply pass the **unbuilt** PropertyBuilder to this function and it gets reflected. If your property needs a offset value and you didn't manually provide a value, automaticaly the last available/defined offset gets used. Also the last available/offset gets increased by the size of the given property.
The first param uses the the size of the super class as offset.

.. info:: That means order is important! But you can rearrange or completly ignore the order by explicitly setting the offset value in the property builder. The last available/defined offset gets automaticaly set to the previous property offset + size.

For examples please refer to `UProperty <UProperty>`_

Functions
'''''''''
Functions (static and member) which need to get reflected get defined with the ``func(SML::Paks::FunctionBuilder builder)`` function.
Pass this function the needed FunctionBuilder and it will get registered.

Interfaces
''''''''''
Because Unreals reflection system doesn't support multiple inheritance like we know it doesn't mean there is no.
Unreal uses interfaces to implement this concept but without any private functions or member variables.

To declare the implementation of a interface you will need the ``implementInterface(UInterface* interface, size_t offset)`` function.
Simply pass this function the ``UInterface`` and the offset to the vtable-pointer refering to the interface implementation in your class.

.. warning:: The Interface support is very, very difficult because the SDK currently doesn't provide the information needed to implement this. Only some interfaces are written into SML (like ``ISaveGame``) and if your desired interface is not implemented you will need to get the information with Detours and IDA. To find more out pleas talk to the Discord Members.

Example:

.. code-block:: c++

    class UDocClass : public SML::Objects::UObject, public SML::Objects::ISaveGame {
        virtual bool shouldSave() overwrite { return true; }
    }

    SML::Paks::ClassBuilder<UDocClass>::Basic()
        .extend<SML::Objects::UObject>()
        .implementInterface(SML::Objects::ISaveGame::staticInterface(), (SML::Objects::ISaveGame*)(UDocClass*)nullptr);

Constructor
'''''''''''
The constructor of a BPI generated class is very special. We cant use the normal constructor because that one whouldn't call the right constructors of the child classes.
That means you need to explicitly set the constructor to member-function of your class with declaration ``void constructor()`` (name not important) and call the ``constructor(void(BuildClassT::*)())`` to define it.
Because we cant use the C++ constructor here (even not the default one) we would need to call the constructors or define them by our self.

.. note:: You need to know that the BuilderClass generates a second internal one which manages the pointers, super class construction and much more, but you're able to define your own one if you desire to. (We do **not** recommend that)

Destructor
''''''''''
The destructor works just like the constructor. But important to note is that you need to call the destructor on every member which needs that. And you need to use the ``destructor`` function to define it.

.. error:: Do not delete the members here! They get (automaticaly freed by the reflection system! Just call the destructors if needed.

Example (destructor & constructor):

.. code-block:: c++

    class UDocClass : public SML::Objects::UObject {
        float testNum;
        std::string testString;

        void constructor() {
            testNum = 0.0;
            new (&testString) std::string();
        }

        void destructor() {
            testString.~string();
        }
    }

    SML::Paks::ClassBuilder<UDocClass>::Basic()
        .extend<SML::Objects::UObject>()
        .constructor(&UDocClass::constructor)
        .destructor(&UDocClass::destructor);


Finishing
'''''''''
To finish building just call the ``build`` function of the builderclass.

StaticClass
'''''''''''
The classbuilder generate through the template multiple functions specific for the given class like the ``static UClass* staticClass()``-function which returns the "StaticClass" of the object.
Call this function only after build or if you know what you're doing.
