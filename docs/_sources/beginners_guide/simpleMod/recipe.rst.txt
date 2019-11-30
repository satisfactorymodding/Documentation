Recipe vs Schematic
===================
'Recipes' are used to define the item input/cost and output of crafting items, buildables, etc. Recipes are not only used for the craft bench or the workshop, but also for the build gun, smelters, manufacturers and more.

.. hint:: Note that recipes are used to define both crafting recipes in the craft bench and machines *and* construction prices when using the build gun. All buildables actually have an item equivalent in game as well.

'Schematics' define `Milestones <https://satisfactory.gamepedia.com/Milestones>`_, the shipments submitted to FICSIT via the HUB in order to unlock new recipes and features. 

Initial Mod Setup
-----------------
To keep your folder structure organized, let's create a folder where all of your mod content will go.

Create a folder, for example,``Content/FactoryGame/DocMod``, to serve as your mod-project-root. All of the assets for our mod will go in this folder and will be turned into a pak when we're done.

Create a Recipe
---------------
First of all, we want to add a recipe to the game which will get unlocked with the schematic we will create afterwards.
Create a folder, ``Content/FactoryGame/DocMod/Recipes`` which will contain all our recipes.

Now, back in Unreal, we can create a new BP Class in this folder which extends ``FGRecipe`` to serve as our recipe.

Finally, we can define the recipe description itself. Open up the class and go to the class defaults and set the properties to the values you want.

- M Display Name
    If you want to define a name for your recipe, check this and type the name in. For our tutorial recipe, we'll check it and call it "Doc Recipe"
- M Ingredients
    This is an array of structs, each of which contains the information of one crafting component. Together, the array forms the input items for the recipe.
    For this example, we'll add one entry and set ``Desc_Leaves`` as the ``Item Class`` and 42 as the ``Amount``.
- M Manufacturing Duration
    This determines the time it takes for a machine to process this recipe. It also corresponds to the number of clicks required to craft the recipe at a crafting station. We'll keep it at 1 for now, cuz we are super speedy pioneers. TODO Find out seconds here to clicks in bench ratio, probably 1 to 1
- M Produced In
    Here we need to select the machine that can use the recipe, for example, ``FGWorkBench``.
- M Product
    This is again an array of structs containing information regarding the item types and amounts that form the output of recipe.
    In our case we'll add an entry with ``Desc_Wood`` as the ``Item Class`` and 1 as the ``Amount``

.. image:: CreateDocRecipe.gif

.. warning:: Note that although recipes with more than out output item type will still compile and load properly, they will crash the game if you try to use them, even if you were to make a modded machine with more than one output to craft it in. If you'd like to make a recipe with more than one output, ask for help with this on the discord, as the only way to do this right now is a bit roundabout until Coffee Stain makes such recipes not crash the game.

Ok, now you've created your first recipe! Next, let's add it to a schematic to make it available ingame.

Create a Schematic
------------------
Schematics are what Satisfactory uses to grant additional recipes and capabilities to the player. Schematics are the 'package' groupings you'll see in the HUB that have rewards associated with them. You'll note that even though alternate recipes are researched at the MAM, you still need to submit items at the HUB to unlock the milestone associated with them.
Schematics are also used for the Tier 0 tutorial phases.
To get started, create a folder in your main mod folder for your schematics, for example, ``Content/FactoryGame/DocMod/Schematics``.

Inside this folder create again a new BP Class but this time of type ``FGSchematic`` and f.e. with the name "Schem_Doc". Open it and go again to its defaults.

- M Type
    The type of the schematic, which determines if it's part of the tutorial system or if it's a Milestone.
    We'll use ``hub upgrade`` because we don't want our schematic to be part of the tutorial phase.
- M Display Name
    The in-game name of our schematic exactly as it is displayed to the user, for example, "Doc Hub Upgrade".
- M Schematic Category
    Defines the category in which this schematic gets grouped into. Go ahead and pick one; it doesn't matter for our example.
- M Tech Tier
    Determines which Tier the schematic will appear under in the HUB. We'll set it to 1 so that our content is available as soon as you finish the tutorial.
- M Schematic Icon
    The icon displayed on the schematic in the HUB. We can use `this example image <Icon_SchemDoc.png>`_.
- M Depends on Schematic
    Setting this option will require the selected schematic to be activated first before this one can be activated. We'll leave this empty because we don't our content to require any other particular schematic to be unlocked first.
- M Additional Schematic Dependencies
    Similar to ``M Depends on Schematic``. Additional schematics to be dependent on can be listed here.
- M Cost
    A list of item amounts which are needed to activate the schematic in the HUB. We'll add two entries, one with 100 ``Desc_Leaves`` and another one with 100 ``FGWood``
- M Ship Travel Time after Purchase
    Determines how long in seconds the HUB will wait before allowing the player to submit another milestone after completing this one. We'll set this to 100 so that the drop pod will fly away for 100 seconds.
- M Recipes
    The list of Recipes which will get unlocked when the player completes this schematic. Here we'll add our ``Desc_DocRecipe`` from before as an entry.
- M Resources to Add to Scanner
    A list of resource types which should get added to the resource scanner when this schematic gets unlocked. We don't need to add anything here.
- M Unlocks Map
    If this schematic unlocks the in-game map feature. Why should your schematic do that? So no, leave it unchecked.
- M Unlocks Build Efficiency
    If this schematic unlocks the build efficiency display. Again, leave it alone.
- M Unlocks build Overclock
    If this schematic unlocks the ability to overclock buildings. Ours doesn't, so we can leave it as is.
- M Num Inventory Slots to Unlock
    The number of additional main inventory slots to grant the player. We'll put 0.
- M Arm Equipment Slots to Unlock
    The number of additional arm equipment slots to grant the player. Another 0 here.
- M Include In Builds
    Set this to 'public builds' so that your content is included in the build. Presumably, this is what Coffee Stain uses to keep their developer milestones made for testing from being shipping with the main game.

Finally! What a class. Now we just need to register this schematic in the runtime.

Register the Schematic
----------------------
Registering a schematic works by using the schematic manager subsystem. To register now a schematic you can simply call the ``Add Available Schematic`` node with the schematic class as input.
Problem is, if you were  to do just this, every time ``PostInit`` of the ``InitMod`` is called (for example when the game loads) the schematic will be added multiple times and show up in the HUB multiple times. To prevent this, we need to check if the schematic is already "registered" by getting the available and purchased schematics list with the corresponding ``GetAvailableSchematics`` and ``GetPurchasedSchematics`` and then we search for our schematic. If it is **not** in one of these lists, then trigger the node to add it.

.. hint:: If you accidentally clutter up a savegame with duplicates of a milestone, you can remove the duplicates using a savegame editor such as one found on `the ficsit.app tools page <https://ficsit.app/tools>`_.

.. image:: RegisterSchematic.jpg

.. tip:: The SML example mod's ``ModInit`` class contains a good and dynamic implementation of this, which simply iterates over an array of classes which contains the schematics to register.

And we're set! Our recipe and schematic are registered and should show up in the game now.