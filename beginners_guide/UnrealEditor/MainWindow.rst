MainWindow
==========
The main window contains most important settings and docks for the primary editor features.

Menu-Bar
--------

.. image:: MainMenuBar.jpg

Every window has a menu bar, but the menu bar of the main window is a little bit specail because it also contains entrys for global settings, project settings and file management.

Tab-Bar
-------

.. image:: TabBar.jpg

Every window has a tab bar which can hold multiple views/windows.
If the mainwindow/view get closed (as tab or the containing "real" window) the project gets completly closed, also all other windows.

Viewport
--------

.. image:: MainViewport.jpg

The viewport is simply a preview of the map, ther you can place and manipulate a world. Cuz we do not have SF world we can't use it there, that means the viewport is more or less useless to us.

Tool-Bar
--------

.. image:: MainToolBar.jpg

The tool-bar is strongly simplyfied version of the menubar and is icon base, but its the only place were you can find the access to the ``Alpakit`` window.
The Tool-bar contains manily shortcuts for the project settings, c++ building and source control, the rest ist mostly not useful without a map.

Outliner
--------

.. image:: MainOutliner.jpg

The outliner is here again prety useless because it simply contains the list of placed objects in the world.

Modes
-----

.. image:: MainModes.jpg

One more useless view cause we dont have a proper map to edit, but this would help you to place things into the world and contains a list of basic actors and edit tools for brushes, terrain and so on.

Content-Browser
---------------

.. image:: MainContentBrowser.jpg

Finnaly a very very usefull and important view.
This view is simply files browser through all contents of your mod project and SF/UE source like C++ classes.

In the left half you can see a tree structure based folder explorer where you can select a folder whichs contents get the displayed on the right hand side half of the view.

It also has in the left upper corner or in the context menu (r-click-menu) the abilty to create, import, export, deler or modify content.

You can find in the ``Content``-Root folder all "normal" assets and the ``C++-Classes`` root folder contains all c++ classes.