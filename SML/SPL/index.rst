Satisfactory Pak Loader
=======================
The SPL is a component of SML that makes so that pak modders don't need to write a .dll mod as well to make the game to load their pak mod. SPL offers two Actors that can be utilized by pak mods to perform actions such as adding recipes or executing blueprint code.

InitMod
-------
``InitMod`` is a special Actor which gets spawned in the boot-up process of the map, so that you can f.e. register new items.
The actors class needs to be located in a specific folder in your project root. That folder needs to have the exact name of the final pak you will deploy to the users.
f.e. if the pak you will deploy is called ``DocMod_p.pak`` you're actors path needs to be ``/Content/FactoryGame/DocMod/InitMod``

InitMenu
--------
``InitMenu`` is a special version of InitMod that gets spawned upon entering the main menu screen. Utilize InitMenu if you'd like to add something to the main menu scene, which can be useful for testing things without needing to load up a game, or to easily display to users that your mod installed correctly.

Init-Events
-----------
There are three init events you will need to add to the actor to ensure it gets executed properly.
``PreInit``, ``Init`` and ``PostInit``
PostInit is the ideal place to register new recipes and schematics. See the `simpleMod <modinst>`_ page for more info on how to do this.
