Buildable
=========
A buildable is simply something you will be able to place with the building gun. Even if it is just a foundation, it is still a ``FGBuildable``.

Adding the Actor
----------------
Making a buildable is pretty easy. Itself is an actor with just a bit more default values. And we don't need a conveyor mesh.
This time we create an own folder for the buildable to have textures, meshes and so on in one place.
Create it in a new folder called "Buildables" in the mod-root-folder, and call itself f.e. "DocBuild". Create the actor class of type ``FGBuildable`` with f.e. the name "Build_DocBuild".

Now we simply also need to add the buildable description by simply filling the default values.
Fille ``M Hologram Class`` with the standard ``FGBuildableHologram``, fill ``M Display Name`` with something like "Doc Counter" and ``M Descriptions`` with "this counts items".

As you can see, the actor already contains some components. But not any visuals, so, now add a new static mesh component in the center of the viewport. You need to know that the center is the position where the build gun targets for.
You can use `this <ExampleBuildableMesh.fbx>`_ example mesh.

Make it paintable
-----------------
We want to make our buildable paintable (paint it with the paint gun).
Because the ``FGBuidable``-class already provides a basic implementation for that, the example mesh already provides a proper UV map for the standard material.
You just need to make sure that you tell the mesh to use the "Factory_Inst" material.

.. hint:: If you want to learn how to UV map your models for the standard material or to implement your functionality, please refer to the `Paintable concept page <../../Concepts/Paintable.rst>`_.

Adding the Descriptor
---------------------
The descriptor is very similar to the ``FGItemDescriptor`` but with some simple additions, a ``FGBuildable``-Class reference, and some Build-Category stuff you can set up how you want to.
In our case simply add a new BP-Class of type ``FGBuildingDescriptor`` to the same folder as the buildable itself and call it f.e. "Desc_DocBuild".

.. error:: Make sure you use ``FGBuildingDescriptor`` and not ``FGBuildDescriptor``.

Define the Recipe
-----------------
Simply do the same as for the Item, but this time as Item-Class you need to use the ``FGBuildingDescriptor`` and set the ``ProducedIn``-field to ``FGBuildGun``.

That's it! You don't need to register anything else. When the recipe gets loaded, everything else also gets loaded and the buildable in the save file has soft references to the classes, and if they get loaded also the classes like out newly created buildable get loaded.