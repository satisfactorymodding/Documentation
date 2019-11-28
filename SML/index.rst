SML
===
The Satisfactory Mod Loader provides utilities for injection, altering and removing of Satisfactory Logic assets.
Over time, numerous other systems have been merged into SML such as the BPI (Blueprint Interface) and SPL (Satisfactory Pak Loader) to allow for additional functionality.

.. toctree::
    :maxdepth: 2

    SPL/index
    SBL
    SDK/index
    BPI/index
    simpleMod/index

Mod "Types"
-----------
There are two main ways to load a mod into a game, each of which have advantages and disadvantages discussed in detail on other pages. Below is a quick summary of each.
 
- .dll (C++) Mods
   ``.dll`` mods are written in C++ and provide deep access to the Satisfactory runtime. These mods are loaded through a process called dll injection and can add just about anything to the game given some time and effort.
- Pak Mods
   Pak Mods are mods made in the Unreal Editor which have basic access to the Satisfactory runtime. Although adding assets such as buildings or models is possible with dll mods, it is much easier to use the Pak modding system to do so.
