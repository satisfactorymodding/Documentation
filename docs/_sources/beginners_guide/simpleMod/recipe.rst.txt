Recipe/Schematic
================
Recipes describe everything were specific types and amounts of items go in, and a different amount and types of items come out.
Recipes are not only used for the craft bench or the workshop, but also for the build gun, smelters, manufacturers and more.

Schematics are the science package thingies you do I the hub. Those are your research packages which will add recipes and other function if they get unlocked in the hub.

Create a Recipe
---------------
First of all, we want to add a recipe to the game which will get unlocked with the schematic we will create afterwards.
To keep your folder structure organized we add a folder where all our recipes should go.
That means to create, the folder ``Content/FactoryGame/DocMod`` which will be your mod-project-root and all our assets will go.
And now add the folder ``Content/FactoryGame/DocMod/Recipes`` which will contain all our recipes.

Now we can create a new BP Class which extends ``FGRecipe``.

Finally, we can define the recipe description itself. The class and go to the class defaults and set the properties to the values you want.

- M Display Name
    If you want to define a name check this and type the name in. For our test recipe, we check it and call it "Doc Recipe"
- M Ingredients
    This is an array of structs containing the information of one crafting component.
    We add an entry and select for that one ``Desc_Leaves`` as the ``Item Class`` and 42 as the ``Amount``.
- M Manufacturing Duration
    the time you need to craft this recipe, we keep it at 1, cuz we are super pioneers.
- M Produced In
    Here we need to select the machine which will use the recipe like ``FGWorkBench``.
- M Product
    This is again an array of structs containing information of the item type and amount which you will get if you craft this recipe.
    In our case we add an entry with ``Desc_Wood`` as the ``Item Class`` and 1 as the ``Amount``

.. image:: CreateDocRecipe.gif

Ok, now you created your first recipe. Let's add it to some science and make it available to the game.

Create a Schematic
------------------
Science is good, science is important, and so it is in Satisfactory. And if you want the ability to craft something specific, you need to research it. And a schematic is exactly this.
But it also describes multiple other things like tutorials.
Science! Similar to recipes we add a folder in the mod-root-folder for our schematics, let's call him "Schematics".

In it, create again a new BP Class but this time of type ``FGSchematic`` and f.e. with the name "Schem_Doc". Open it and go again to its defaults.

- M type
    The type of the schematic like if it is hub upgrade or a tutorial.
    We use ``hub upgrade``.
- M Display Name
    This is the name of our schematic and how it gets directly displayed to the user. like "Doc Hub Upgrade"
- M Schematic Category
    Defines the category in which this schematic gets grouped to. Idk what the best option our case is so, you can decide this time.
- M Tech Tier
    Sets the tech tier of the recipe like the tiers in the hub. We use 1 cuz its very early but not in the tutorial.
- M Schematic Icon
    This is the icon used to display the schematic. We can use `this example image <Icon_SchemDoc.png>`_.
- M Depends on Schematic
    We leave this as it is because we don't depend on the other schematic. The selected schematic needs to be activated that this schematics can get activated.
- M Additional Schematic Dependencies
    This is a list of schematics just like ``M Depends on Schematic``
- M Cost
    This is a list of item amounts which are needed to activate the schematic. We add an entry with 100 ``Desc_Leaves`` and another one with 100 ``FGWood``
- M Ship Travel Time after Purchase
    Set this to 100 so that the space ship of the hup will fly away for 100 secs.
- M Recipes
    This finally the list of recipes which get unlocked when you activate this schematic. Here we add our ``Desc_DocRecipe`` as an entry.
- M Resources to Add to Scanner
    Simply a list of resource types which should get added to the resource scanner when this schematic gets unlocked. We don't need to add anything.
- M Unlocks Map
    If this schematic unlocks the map. Why should your schematic do that? So no, leave it unchecked.
- M Unlocks Build Efficiency
    If this schematic unlocks the build efficiency display. Again, leave it alone.
- M Unlocks build Overclock
    If this schematic unlocks the ability to overclock buildings. No, it doesn't.
- M Num Inventory Slots to Unlock
    0, because we don't want to give the player the ability to have more items in his inventory.
- M Arm Equipment Slots to Unlock
    again 0, because why should the user be able to have more items in his hands?
- M Include In Builds
    set this to public builds, cause we want it to, be, public.

Finally! What a class. Now we just need to register this schematic in the runtime.

Register the Schematic
----------------------
Registering a schematic works by using the schematic manager subsystem. To register now a schematic you simply call the ``Add Available Schematic`` node with the schematic class as input.
Problem is, if you do this now in every ``PostInit`` of the ``InitMod`` it gets added over and over again. To prevent this, we check if the schematic is already "registered" by getting the available and purchased schematics list with the corresponding ``GetAvailableSchematics`` and ``GetPurchasedSchematics`` and then we search for our schematic. If it is **not** in one of these lists, then we add it.

.. image:: RegisterSchematic.jpg

.. tip:: The example mods ``ModInit`` contains a good and dynamic implementation of this, which simply iterrates over an array of classes which contains the schematics to register.