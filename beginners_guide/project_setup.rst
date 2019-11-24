Project-Setup
#############
A key aspect of fast and efficient development is a proper Workspace and project setup. With a misconfigured or unoptimal setup, you'll lose valuable time.
That's why we will guide you now through making a good project setup for Satisfactory.

Starter-Project
---------------
For beginners, we recommend using the provided Starter Project. It contains already a good setup for modding where you can directly dive into modding itself.

Download/Cloning
----------------
First, we need to download the starter project. To do that you can either use git to clone the repository or download it as a zip file.
The repository URL is `https://github.com/satisfactorymodding/SatisfactoryUnrealProject.git <https://github.com/satisfactorymodding/SatisfactoryUnrealProject.git>`_
If you don't know how git works we recommend downloading it as a zip file, to do that visit `this <https://github.com/satisfactorymodding/SatisfactoryUnrealProject>`_ site and click on ``Clone or download`` on the right-hand side, after that a window should pop-up were you now need to click on ``download zip``.
Download it and unzip it with your desired archive tool, such as 7zip, into a temporary folder.
The move the "StarterProject" folder to your desired location and rename the folder as desired.

Setting up Wwise
----------------
Wwise is an audio and sound system used by Satisfactory, and setting it up is required to get your modding environment working.
Sitting up WWise can be difficult, but we'll walk through the steps here.

Start the Wwise launcher that you installed earlier and update it if needed.
Next, open the Unreal Engine tab in the upper tab-bar. Click on the three lines next to the "RECENT UNREAL ENGINE PROJECTS" label and click ``Browse for project...``.
Now just select the ``.uproject`` file in your mod's project folder.
Your project should now appear in the Wwise launcher. Click on the "Integrate Wwise into Project..." button.

Click on the blue ``Install Wwise`` button to download and install the latest Wwise SDK. If you have already one installed please select the version directly under the "UNREAL ENGINE PROJECT" label and select the SDK folder in the ``Copy of Wwise SDK files``.
Now click on the small arrow down at the end of the ``Wwise Project Path`` field and select ``New``.

If everything worked according to plan, you should now be able to click on the blue ``Integrate`` button.

.. tip:: When downloading or updating a Wwise SDK, select Microsoft under``Deployment Platforms`` because Satisfactory currently supports just Windows. You can also deselect all of the plugins listed.

That's it! If Wwise shows ``Operation completed successfully`` you have integrated Wwise into your project.

Compile/Start Unreal-Project
----------------------------
To initiate compiling the unreal-project source and to open the editor just simply open the ``.uproject`` file, hit ``Ok`` of you get prompted if you should rebuild something and the editor should show up.

Setting up Alpakit
------------------
Alpakit is a modified version of ue4pak made by Brabb3l and used to make building your mod more convenient.
Click on the Alpakit button in the Tool-Bar of the Unreal viewport and click on ``Choose folder`` in the upper right-hand corner and select your root Satisfactory game installation folder (like ``C:\Program Files\EpicGames\SatisfactoryEarlyAccess\``)
Check ``Start game after paking`` if you'd like to do so.
Click ``Add mod`` and fill out the dialogue to tell Alpakit to pak everything in the content folder with the path ``/Content/FactoryGame/<your mod name>``

.. note:: Alpakit automatically copies the ``.sig`` files and the ``.pak`` files to your SF installation, in addition to cooking and paking the files as needed.

That should be it. Your mod project should now be set up and ready to go.