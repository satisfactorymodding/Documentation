**********************************
Satisfactory Modding Documentation
**********************************

Basics
------

This is the Satisfactory Modding Documentation where you can find most things for and about modding Satisfactory.
Modding for Satisfactory is more built out than you might think. There are multiple types of technologys, mods and repositorys to choce from. In this doc we will mainly focus on the genreal community, ficsit.app and SML.

.. hint:: If you want to take part of this great community we reccomend you to join our `Discord-Server <https://discord.gg/xkVJ73E>`_.

Technologys
-----------

Satisfactory Mod Repository `(aka. SMR aka. ficsit.app)`
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
The SMR is the biggest know collection of mods made for Satisfactory and also provides a list of tools and guides.
Uploaded content gets test for malware and other stuff.
Visit the `ficsit.app <https://ficsit.app/>`_ to learn more.

Satisfactory Mod Loader `(aka. SML)`
''''''''''''''''''''''''''''''''''''
SML is the most used Mod Loader for Satisfactory and is used by most mods.
SML provides two key features.

- Loading and initializing mods directly from so called "paks"
- Loading and initializing native mods written in C++

To get started in how to code mods, we reccomend beginning with the first one. Learn more in our :doc:`beginners_guide/index`

Installing Mods
---------------
If you just want to install, this just for you.
First of all you need to know a mod you want to install. F.e. visit ficsit.app and select one.
Now you should always read the mod description because some mods have different installation instructions like the Kronos mod.
If your selecte mod says it wants to be installed with SML, we will guide you how to do that.

Again visit `ficsit.app <https://ficsit.app/>`_ and open up the menu through the menu button in the upper left hand corner.
Select the SML tab and click on the newes release. You should now get redirected to the SML-GitHub page.
Click on the ``xinput1_3.dll`` download link.

Now open up your Satisfactory installation folder. Most of the times its in your program folder under ``EpicGames/SatisfactoryEarlyAccess``.
Follow the folders ``Binaries`` and ``Win64``. Now just copy the ``xinput1_3.dll`` into that folder.

Congrats! The first step is done, installing SML. Now just test it by booting up Satisfactory and looking if the ``mods`` folder gets created.

Ok, back to the mod it self.
On ficist.app you just go to your desired mod page, click on versions in the upper right hand corner and then select your desired version.

.. warning:: When you select a mod version. Always check if it uses your SML version, if not, you can try but we don't reccomend doing so.

Download it and then open it with a proper zip archive explorer like 7zip.
It contains multiply things like:

- data.json
    just leave it were it is, it is needed for SMR
- .pak files
    these files contain some mod logic, models, textures and so on. To install them you need to copy them again into the Satisfactory installation folder, but this time under ``Content\Paks``
    If there is no corresponding ``.sig``-File for each of the ``.pak`` files in the archive, you would need to copy the ``.sig`` file from Satisfactory (it's called ``FactoryGame.sig``) and rename it like the ``.pak``-File.
    Repeat this step for each ``.pak`` file there is.
- .sig files
    Copy them like the ``.pak`` files if you didn't done it already.
- .dll files
    These files contain just logic but they can speak to SML and Unreal directly, not like the .pak files.
    They go into the newly created mods folder.

Index
-----
.. toctree::
    :maxdepth: 2

    beginners_guide/index
