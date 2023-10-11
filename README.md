# Company of Heroes 3 - Internal Data Scripts

These are the .scar and .lua scripts found in CoH3's `engine\archives\Data.sga` and `anvil\archives\Data.sga`, useful for reference when scripting CoH3 mods.  The `engine` directory contains the engine's scripts, and `anvil` the game's propper.

Of particular interest are the files described in the Win Condition template script:
[`engine\archive\data\scar\scarutil.scar`](/blob/master/engine/archive/data/scar/scarutil.scar): essential functions used almost everywhere.
[`anvil\archive\data\scar\game_modifiers.scar`](/blob/master/anvil/archive/data/scar/game_modifiers.scar): if you're planning adding any modifiers to your mod. For example, if you want to change maximum population capacity or accuracy, sight range, health, etc.
[`engine\archive\data\scar\core.scar`](/blob/master/engine/archive/data/scar/core.scar): This is required by all of the scripts found below:
[`anvil\archive\data\scar\ui\outcome_ui.scar`](/blob/master/anvil/archive/data/scar/ui/outcome_ui.scar): For default end of match flow.
[`anvil\archive\data\scar\audio\audio.scar`](/blob/master/anvil/archive/data/scar/audio/audio.scar): Audio support in general.

You can download the repo on the green `<> Code` button or with `https://github.com/Chematronix/coh3-internal-data-scripts`. Add the directory to your VSCode project if you want to be able to look up a function definition by just pressing F12 or such.

Extracted after the Umber Patch, v1.3.0.18567.  To extract a newer version, open the respective Data.sga file in the `EssenceEditor.exe` by doing `File > Open...` or dragging it to the tab bar.  Select and right click the Data directory to Extract.

To remove non-.lua|.scar files and empty directories to greatly reduce the resulting size, run in a Linux/WSL shell on the containing directory:
```
find ./data -type f -not -regex '.*\.\(scar\|lua\)$' -print -delete
find . /data -type d -empty -print -delete
```