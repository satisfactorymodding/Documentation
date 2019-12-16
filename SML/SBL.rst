Satisfactory Blueprint Library
==============================
The SBL is a component of SML used to provide BP-Scripts access to SML features by using the BPI to create custom UClasses.

DebugLogger
-----------
The debug logger is used to provide quick usage of the level based logging for the the console of SML. It does that by providing multiple static functions you can find under ``SML/Logging``.

- LogInfo(String str, bool ignore)
    Logs the given string with the "info-color" when debugMode is enabled or the value of given ignore is true.
- LogWarning(String str, bool ignore)
    Logs the given string with the "warning-color" when debugMode is enabled or the value of given ignore is true.
- LogError(String str, bool ignore)
    Logs the given string with the "error-color" when debugMode is enabled or the value of given ignore is true.
- LogDebug(String str, bool ignore)
    Logs the given string with the "debug-color" when debugMode is enabled or the value of given ignore is true.

ModHandler
----------
The mod handler controls all loaded mods and provides features to interact with them.
You can find the functions under ``SML/Environment``

- bool isDebugMode() Pure
    returns if "Debug-Mode" is enabled.
- broadcastEvent(String event)
    broadcast the given SML event
- bool isDllLoaded(String dll)
    returns if the given dll mod is loaded
- bool doesPakExist(String pak)
    returns if the given pak does exists
