Project-Setup
#############
One Key thing of fast and good development is a proper Workspace and project setup. When your setup is not quite right you lose valuable time.
That's why we will guide you now through making a good project setup for Satisfactory.

Starter-Project
---------------
For beginners we reccomend to use the starter project. It contains already a a good setup for modding where you can directly dive into modding it self.

Download/Cloning
----------------
First we need to download the starter project. To do that you can use git to clone the repository or download it as a zip file.
The repository url is `https://github.com/satisfactorymodding/SatisfactoryUnrealProject.git <https://github.com/satisfactorymodding/SatisfactoryUnrealProject.git>`_
If you don't know how git works we reccomend downloading it as a zip file, to do that visit this site and click on ``Clone of download`` on the right hand side, after that a window should pop-up were you now need to click on ``download zip``.
Download it and unzip it with your desired tool like 7zip into a temporary folder.
The move the "StarterProject" folder to your desired location and rename the folder like how you want it.

Settingup Wwise
---------------
Sittingup WWise can be difficult but doesn't need to.

Start the Wwise launcher and update it if needed.
After that open the Unreal Engine tab in the upper tab-bar. Click on the three lines next to the "RECENT UNREAL ENGINE PROJECTS" label and click ``Browse for project...``.
Now just select the ``.uproject`` file in your mod project folder.
Your project should finally appear in the wwise launcher where you now need to click on the "Integrate Wwise into Project..." button.

Click on the blue ``Install Wwise`` buttone to download and install the lates Wwise SDK. If you have already one installed please select the the version directly under the "UNREAL ENGINE PROJECT" label and select the SDK folder in the ``Copy of Wwise SDK files``.
Now click on the small arrow down at the end of the ``Wwise Project Path`` field and select ``New``.

If everything worked according to plan, you should now be able to click on the blue ``Integrate`` button.

.. tip:: When downloading or updating a Wwise SDK, just have Microsoft under ``Deployment Platforms`` selected, because Satisfactory currently supports just windows. And you can deselect all plugins.

That's it! If the wwise shows ``Operation completed successfully`` you finally integrated wwise into your project.

Compile/Start Unreal-Project
----------------------------
To intiate compiling the unreal-project source and to open the editor just simply open the ``.uproject`` file, hit ``Ok`` of you get prompted if you should rebuild something and the editor should show up.

Settingup Alpakit
-----------------
Click on the Alpakit button in the Tool-Bar of the viewport and click on ``Choose folder`` in the upper right hand corner and select your root satisfactory game installation folder (like ``C:\Program Files\EpicGames\SatisfactoryEarlyAccess\``)
Check ``Start game after paking`` if you want so.
And click ``Add mod`` and fill out the dialog to tell Alpakit to pak everything in the content folder with the path ``/Content/FactoryGame/<your mod name>``

.. note:: The Alpakit autmaticly copies the ``.sig`` files and the ``.pak`` files to your SF installation, but also cooks and paks the files as needed.

That should be it. Your mod project should now be setup how it needs to.