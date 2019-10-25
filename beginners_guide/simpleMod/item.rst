Create an item
============
Now that you created a custom recipe and schematic, you might want to create a custom Item.
For this, we need an Idea what name the item should have, how it should look like and stuff like that.
We decided to make a new ingot called 'Doc Ingot'.

Creating the BP-Class
---------------------
The item system is a bit special but overall we simply just need to describe our item in a ``FGItemDescriptor`` class.
To create it go to the content browser in the unreal editor. Go to the Mod-Root and create a new folder and call it f.e. "Items".
And create a new BlueprintClass in it. Call it what every you want, but we will call it ``Desc_DocItem`` ("Desc" stands for descriptor).

Describe the Item
-----------------
Now open the class and you should see the default settings of the classes attributes. If not, just click on "Default Settings" and they should appear in the settings browser of the class editor.
In here you will find multiple attributes with the different properties such a Item can have.

- M Use Display Name and Description
    Because we have just a simple Item we need to check this (set the boolean to true) so that the item name and description is used directly of this class.
- M Display Name
    Set this to "Doc Item" so that the item gets called like that ingame.
- M Description
    This should get set to a simple description of the item. In our case we use the text "This is the starter Item of the SFM-Doc."
- M Stack Size
    Set this to f.e. Big, this is just a simple description of how big you should be able to stack this item.
- M Can get Discarded
    Leave this unchecked so that you cant throw the item into the trashcan, because FicsIt does not waste.
- M Energy Value
    Our it is not organic, so it shouldn't be able to get burned in any generator. This value describes how much energy this item should release if it gets burned in a generator. And we use 0.0 for that value.
- M Radioactive Decay
    I don't think that your Item is so exiting that it should emit radioactivity, so we set this value to 0.0 because it describes how radioactive this item is.
- M Conveyor Mesh
    As we know, a item is 3-Dimensional so we need a 3D-model for the item how it should look look if it gets transported on a conveyor belt.
    We have a example model `here <Mesh_DocItem.fbx>`_.
- M Item Category
    This groups the item into a category, we don't need this so we leave it on "None" and so the item gets categorized under "Other".
- M Small Icon
    This is a simple texture image of the object used f.e. in the inventory to visualize what the given stack is.
    We have image ready for use `here <Icon_DocItem.png>`_.
- M Big Icon
    This is the same as the small icon but, bigger.

Make the item available
-----------------------
The item is available to the user when it gets loaded at least once. Because Unreal loads assets just in time, we somehow need to force the asset to get loaded.
And we can simply do that when our item gets used in a Recipe and this also allows the user to somehow get the item xD
So just change the outcome of our already created recipe to this item. And you're done.