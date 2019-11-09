Satisfactory Pak Loader
=======================
The SPL makes it possible that modders don't need to write a .dll mod to initiate the mod loading.

InitMod
-------
``InitMod`` is a special Actor which gets spawned in the boot-up process of the map, so that you can f.e. register new items.
The actors class needs to be located in a specific folder in your project root. That folder needs to have the exact name of the final pak you will deploy to the users.
f.e. if the pak you will deploy is called ``DocMod_p.pak`` you're actors path needs to be ``/Content/FactoryGame/DocMod/InitMod``

Init-Events
-----------
There are three init events you will need to add to the actor so that they get executed properly.
``PreInit``, ``Init`` and ``PostInit``
PostInit is the ideal place to register new recipes and schematics.
