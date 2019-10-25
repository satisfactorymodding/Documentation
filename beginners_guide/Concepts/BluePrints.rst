Blue Prints
===========
``BluePrints`` is a node-based visual coding language for Unreal. It compiles into a kind of bytecode which gets executed by the Unreal BP VM.

.. tip:: Bytecode is a special fake machine code which gets executed by a machine running in a VM. This allows cross-platform compatibility without the need to compile the code for every platform individually.

Unreal BP VM
------------
This "blueprint-bytecode" needs to get executed by a custom machine cause a normal machine like your CPU can't understand that code. Unreal BP VM is that machine which runs itself in a virtual machine.

This creates a problem. Blueprint code can't use system functions like rendering with the GPU cause it got isolated through this VM. But communication is essential for something like this, unreal uses for this its own reflection-system, the `UObject-System <UObject>`_.

Nodes
-----
Other than f.e. scratch, `BluePrints` uses a node system for describing its behaviour.
Everything is a node, from functions and events to simple operators like addition.
A node can have multiple inputs and outputs. For values and flow (execution).

Pure Nodes
''''''''''
Pure nodes are a special kind of node which doesn't have any execution connections, but it can still have a internal execution flow.
These nodes get executed when a connected node (where one of its inputs is connected to one of the outputs of the pure node) wants to get executed.

Connection-Lines
----------------
These nodes get connected with lines to describe which output is used for which input and what should happen after the given node got executed.
There are two types of connection lines.

- Execution-Lines
    They describe which node should get explicitly get executed after the other node finished execution. You can connect multiple outputs to one input, but you cant connect multiple ints to one output because then the flow execution would break up into multiple threads and BP does not support real multithreading.
- Data-Lines
    These lines describe the flow of data like a simple float value. You can connect them, most of the time from one output to multiple inputs, but sometimes you can connect multiple outputs to one input.

Data Types
----------
There are multiple data types in BP.

Standard Types
''''''''''''''
Standard types are often types which are directly used for calculations.

- boolean (bool 8bits)
    Boolean values can store two states true and false. They are mostly used for logical comparisons.
- integer (int 32bits)
    Integers are countable (whole) numbers with negative space (-2,-1,0,1,2)
- float (float 32bit)
    Floats are like countable numbers but can also be everything between whole numbers (-1,0.5,0,0.3,0,75)
- string
    Strings are sequences of characters like a simple text.
- names
    Names are like strings but the characters are stored globally to make it more optimized and to make renaming easier.
- vectors
    Vectors are simply 3 floats, but you can do crazy math with them.
- List
    List of multiple values, sorted by their actual value. If you add a new value, the order can change.
- Array
    this is a list of multiple values of a given type, but every entry also corresponds to index and so the order of values never changes.
- Map
    like an array but instead of using numbers as the index, it uses a given type as the key, which is "linked" to value.

Structs
'''''''
Structures are simply just multiple values with different types grouped together.
You need a description of a struct to then create instances of it.
You can then use the description as a data type and the instances as values for the ``Value-Lines``.

Classes
'''''''
Classes are like structs but way more complex because they can have also methods, events and delegates.
Classes describe just a value, to get an actual value you would need to use special functions to get an Object which is an Instance of that class.
These objects then finally contain information like values for attributes or bounded functions of delegates.
When you use the class as the type and the objects as values, these values are just references to the objects. That means if you copy the value, and change something in that object like an attribute, "it changes in every other value too".

.. tip:: Functions can be marked as pure, then they still work like normal functions but when you use them, they're a pure node.

Functions
---------
Functions are subroutines. Capsulated code that has its own scope and is used more than once and is available to other scopes (function environments and also other f.e. classes).

Macros
''''''
Macros are like functions but without an own scope and are only callable within the class. They work like a template for multiple usages and are also compiled like they were a part of the calling function. Due to this, it can have multiple execution inputs and outputs and also a special "any" type.

Methods
'''''''
These are a special kind of function. They need the context of an object to execute because they can manipulate multiple values of that object. (so they get executes "as onto" an object)

Events
''''''
Events are a special kind of method. This method can't have any output values.

Delegates
---------
Delegates are holding a list of bound events. When a delegate gets executed, it calls all the bound events with the same input-values. (they can't have output values because ``BluePrints``won't know how to merge all the output values of all these event calls and because they are events and not functions)
This is like an array containing a reference to an event and also the corresponding bound context (Object) for use to call these events.
