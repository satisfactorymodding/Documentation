Crafting
========
The crafting system of satisfactory is relatively straight forward and easy to implement.
Nonetheless, we will guide you through the process of creating and registering new Recipes and Items.

Items `(FGItemDescriptor)`
--------------------------
The native ``FGItemDescriptor`` class, who would have thought, describes an Item itself.
It holds information like:

- Name
    The actual displayed name to the user
- Description
    A description of the item itself. Most of the time it contains information about its usage but also some useless information.
- Inventory Icon
    The icon you can see in your inventory is no live rendering of the item, instead, it's just a simple image file.
- Conveyor Model
    This is a Static Mesh used to display the item in the 3D Environment like on a Conveyor belt.
- Radioactive Decay
    Some items like Uranium Ore have a radioactive decay, this is simply the nasty invisible shit why you can't get closer to nuclear reactors.
- Energy value (for use as Fuel)
    Different items have different amounts of energy storage when used as fuel. Coal has f.e. less energy than normal Fuel.

.. hint:: Sometimes you don't need to define everything. f.e. when you want to create a building descriptor you won't need a model for conveyors or an energy value cause you don't want to throw a building into a generator.

This is enough for basic Items, but what's about more complex ItemDescriptors like equipment?
For that we have other classes we will discuss later on.
You can look up how to create a ``FGItemDescriptor`` in our :doc:`Create-a-Item-Guide <../simpleMod/item>`

Recipes `(FGRecipe)`
--------------------
Describing recipes for the workbench, buildgun or other machines works through the usage of the native ``FGRecipe`` class.
Recipes allow you to describe what items and how many you need to deliver to get the given items with the given amounts.
Interestingly though is, also buildgun recipes are described in a ``FGRecipe``, that means when you want to add a new building to the buildgun you need to create a new ``FGRecipe`` class with proper default values and then register the recipe.

Satisfactory uses a recipe manager to register and store all recipes there are. That means when you want to add a normal workbench recipe or a smelting recipe, it doesn't matter... just create a recipe with your desired descriptors and amounts and then let it register in the manager.
The machines get their information from this manager so the can give the user a proper choice of what they can craft and what not.
To determine this, if a machine is capable of crafting this recipe, you will need to pass an object type implementing the "``Crafter``" interface.
