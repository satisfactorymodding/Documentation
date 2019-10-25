Mod-Init
========
Like everything, a mod has a start where everything else gets invoked. In our case this the InitMod-Actor from SPL. That dude will implement events which get in the world-bootup called.

Create the Actor
----------------
First of all, we need to create the proper path for the actor. That one depends on the mod name, specifically on the name of the pak we will provide.
Our mod name will be ``Doc Mod`` and the pak file name will be ``DocMod_p.pak`` that means we need to create a folder in the SF asset root with our name.
So we create the folder ``Content/FactoryGame/DocMod``.
And finally in there you now just need to add a new Actor called ``InitMod``

Add the Init-Events
-------------------
This initialization actor needs three custom events you now just need to add by opening the actor class, click on to Event Graph and the r-click into it and then add the custom events with the name ``PreInit``, ``Init`` and ``PostInit``.
Click on the ``Init`` node and add a new input parameter of type string in the details panel. Do the same for PostInit.

Done, now you will be able to register recipes and other stuff in here.