Code & Content
==============
On this page we will describe what we refer to as 'content' and 'code.' There are two kinds of code, ``Native Code`` and ``Blueprint Code``.

Content
-------
"Content" in terms of 3D models, sounds, textures, materials and so on are called ``Assets``.
You use these assets to make stuff in your game f.e. visible to the user.
There are multiple types of assets:

- StaticMesh
    A model, a 3D object in a file format such as .obj or .fbx
- Sound
    Audio files to be played in game, for example music or sound effects. Because Satisfactory uses Wwise, it is currently NOT possible for us to add sounds to the game. Ask on the discord if you would like a further explanation as to why this is the case.
- Skeleton
    Characters like the player or enemies have a skeleton to tell the game engine where bones and joints are to enable the a model to be animated.
- TextureSample
    Images such as grass texture, FICSIT logo, and item/building icons are simple images called "Texture Samples"
- Materials
    Every surface of a model has a material applied to it that tells the rendering engine how to display the surface.
    Materials combine image textures with properties such as roughness and reflectiveness to form what is seen in-game.
- Blueprints
    A system of programming further described on the `Concept-Page <BluePrints>`_ page.

Native Code
-----------
The term 'Native code' refers to code written in C++ which can't be directly changed in the Unreal Editor. The editor itself uses C++ code as well.
This kind of code can interact with the computer on a very low level and is often used when performance is really important.
Much of Satisfactory is written in C++, and you will often find that using native code allows you to access functionality can't with the``Blueprints`` system.
Native code is compiled directly into machine code, meaning that for every platform (ex. Windows, Linux, Mac) you support, you would need to compile this code separately for each.

.. warning:: Native code needs to be updated and recompiled for every Satisfactory update. Be aware of this if you decide to make a mod utilizing native code.

Native code allows you to perform low-level manipulation of the engine environment and thus allows you to implement utilize third-party libraries, such as Discord, Curl, Twitch integrations, and Lua.

Blueprint Code
--------------
'Blueprint code' refers to code written in the Unreal Engine blueprint scripting system. The blueprint system is a visual scripting language, a high level language that is considerably less efficient than native code but can be much easier to learn and much more convenient to work with. Blueprint code is executed via the Unreal BP VM, meaning recompilation for every platform is not necessary.

.. hint:: To learn more about ``Blueprints``, visit the `Concept-Page <BluePrints>`_ about that topic.