Buildable
=========
A buildable is simply something you will be able to place with the build gun. Even if it ist just a foundation, it is still a ``FGBuildable``.

Adding the Actor
----------------
Making a buildable is pretty easy. Itself is a actor with just a bit more default values. And we actually don't need a conveyor mesh.
This time we create a own folder for the buildable to have textures, meshes and so on in one place.
Create it in a new folder called "Buildables" in the mod-root-folder, and call it self f.e. "DocBuild". Create the actor class of type ``FGBuildable`` with f.e. the name "Build_DocBuild".

As you can see, the actor already contains some components. But not any visuals, so, now add a new static mesh component in the center of the viewport. You need to know that the center is the position where the buildgun targets for.
You can used `this <ExampleBuildableMesh.fbx>`_ example mesh.

Make it paintable
-----------------
We want to make our buildable paintable (paint it with the paint gun).
Because the the ``FGBuidable``-class already provides a basic implementation for that, the example mesh already provides a proper UV map for the standard material.
You just need to make sure that you tell the mesh to use the "Factory_Inst" material.

.. hint:: If you want to learn how to UV map your models for the standard material or to implement your own functionality, please refer to the `Paintable concept page <../../Concepts/Paintable.rst>`_.

Adding the Descriptor
---------------------
The descriptor is very similar to the ``FGItemDescriptor`` but with one addition, a ``FGBuildable``-Class reference.
In our case simply add a new BP-Class of type ``FGBuildingDescriptor`` to the same folder as the buildable itself and call it f.e. "Desc_DocBuild".

.. error:: Make sure you use ``FGBuildingDescriptor`` and not ``FGBuildDescriptor``.

Define the Recipe
-----------------
Simply do the same as for the Item, but this time as Item-Class use the ``FGBuildingDescriptor`` and set the ``ProducedIn``-field to ``FGBuildGun``.

That's it! You don't need to register anything else. When the recipe gets loaded, everything else also gets loaded and the buildables in the save file have soft references to the classes, and if they get loaded also the classes like out newly created buildable get loaded.