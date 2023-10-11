----------------------------------------------------------------------------------------------------------------
-- Default Key Combo Bindings
-- (c) 2012 Relic Entertainment

-- These combos should NOT be changed by the user.

-- Bindings use format "Control+Shift+A".

-- Valid key names:
	-- A..Z
	-- 0..9
	-- F1..F12
	-- Alt Apostrophe Backslash Backspace CapsLock Comma Control Delete Down End
	-- Enter Equal Escape Grave Home Insert LBracket Left Minus NumLock PageDown
	-- PageUp Pause Period PrintScreen RBracket Right ScrollLock Semicolon Shift
	-- Slash Space Tab Up
	-- Numpad0..Numpad9
	-- NumpadMinus NumpadMultiply NumpadPeriod NumpadPlus NumpadSeparator NumpadSlash
	-- MouseMiddle, MouseX1, MouseX2

-- Group Types:
	-- 0 - (all) group always shown
	-- 1 - (modern/grid keys) group to only be shown when Classic Keys option is NOT selected
	-- 2 - (classic) group to only be shown when Classic Keys option is selected
	
-- Binding Variables:	
	-- uiSortPriority 	- is used to sort the groups and bindings in ascending order
	-- essential 		- this binding must have a valid keycombo and when unbound, makes the current profile invalid for save
	-- significant 		- adds this binding to a list of "important" commands that the player can view (on the controls page, currently).
	
-- Binding Variables:
	-- userVisible		- binding appears to the user in the hotkey menu (default is true)
	-- userRemappable	- user can remap the two combos - note that the UI prevents combos that contain Shift or Alt from being remapped
	-- uiSortPriority 	- is used to sort the groups and bindings in ascending order
	-- allowIgnoreShift/Alt	- trigger the binding even if Shift or Alt modifier is down - allows attached command to react differently in these cases
		-- note that if a binding contains a combo that includes Shift or Alt, that combo will only be triggered if the modifier is down,
		-- regardless of whether allowIgnoreShift/Alt is set
	-- shiftLocID/alt	- the string that describes the modified action; prepended by name of modifer depending on if user has swapped them
	-- essential 		- this binding must have a valid keycombo and when unbound, makes the current profile invalid for save
	-- significant 		- adds this binding to a list of "important" commands that the player can view (on the controls page, currently).

-- Combo variables
	-- repeatCount	-- use -1 to have default repeat logic, 0 to only trigger on first repeat, 1 only on second, etc
		-- note we disregard repeatCount when we are allowing a shift or alt to flow through
		-- (for example so KEY_1[x2] can select-and-focus but Shift-KEY_1 can have default repeat behavior)
	-- note that combos that include Shift/Alt cannot be user remapped even if binding has userRemappable=true
	-- remap		-- remap from English keyboard layout to active keyboard layout (different from userRemappable above)
		-- remap=true means "change the key so that the key in same location is pressed instead"
		-- use remap=true for keys that are chosen primarily for their location such as gridkeys, WASD, and perhaps if you've bound
		-- very common actions to comma, period ect and want those actions to work no matter what punctuation is on those keys
		-- for example, on a German keyboard the 'z' and 'y' keys are swapped, so for Cardinal's gridkey binding command_card_row03_column01
		-- you want remap=true so that the key becomes 'y' and stays in the location 'z' is in English layout
		-- remap=false (or missing) means "press the named key in its new location"
		-- you may use remap=false for keys that are mnemonic for example if Ctrl-A is "select all" you may want that do be bound to Ctrl-A no
		-- matter where the 'a' key is on the keyboard
		-- there are some keys like Esc and F-Keys that don't tend to move for which it probably doesn't matter, but you probably don't want remap=true
--NOTE: Increment version number when adding/removing/renaming binding groups
version = 1
bindingGroups =
{
	----------------------------------------------------------------------------------------------------------------
	-- Developer commands.
	----------------------------------------------------------------------------------------------------------------
	
	developer =
	{
		locID = 0,
		groupType = 0,
		uiSortPriority = 1000,
		bindings=
		{
			console									={locID=0, keycombos={{ combo="Alt+Grave"}}, userVisible=false},
			persistent_performance_counter = {locID=0, keycombos={{ combo="Control+Shift+P"}}, remap=false, userVisible=false},
			capture_tool							={locID=0, keycombos={{ combo="Shift+Grave"}}, userVisible=false},
			pause									={locID=0, keycombos={{ combo="Pause"}}, userVisible=false},
		},
	},
	
	----------------------------------------------------------------------------------------------------------------
	-- HUD menu commands.
	----------------------------------------------------------------------------------------------------------------
	
	
	
	----------------------------------------------------------------------------------------------------------------
	-- HUD static commands (issued by the event dispatcher).
	----------------------------------------------------------------------------------------------------------------
	
	hud_static =
	{
		locID = 11144974,
		groupType = 3,
		uiSortPriority = 666,
		bindings=
		{
			
			
		},
	},

	army_management =
	{
		locID = 11244019,
		groupType = 0,
		uiSortPriority = 3,
		bindings=
		{	
			select_production_building0				={ userRemappable=true, uiSortPriority = 0, locID=11145055, keycombos={{ combo="F1" }, { combo="" }}},
			select_production_building1				={ userRemappable=true, uiSortPriority = 1, locID=11145056, keycombos={{ combo="F2" }, { combo="" }}},
			select_production_building2				={ userRemappable=true, uiSortPriority = 2, locID=11145057, keycombos={{ combo="F3" }, { combo="" }}},
			select_production_building3				={ userRemappable=true, uiSortPriority = 3, locID=11145058, keycombos={{ combo="F4" }, { combo="" }}},
			select_production_building4				={ userRemappable=true, uiSortPriority = 4, locID=11145059, keycombos={{ combo="F5" }, { combo="" }}},
			
			focus_production_building0				={ userRemappable=true, uiSortPriority = 5, locID=11255502, keycombos={{ combo="F1", repeatCount=1 }, { combo="" }}},
			focus_production_building1				={ userRemappable=true, uiSortPriority = 6, locID=11255503, keycombos={{ combo="F2", repeatCount=1 }, { combo="" }}},
			focus_production_building2				={ userRemappable=true, uiSortPriority = 7, locID=11255504, keycombos={{ combo="F3", repeatCount=1 }, { combo="" }}},
			focus_production_building3				={ userRemappable=true, uiSortPriority = 8, locID=11255505, keycombos={{ combo="F4", repeatCount=1 }, { combo="" }}},
			focus_production_building4				={ userRemappable=true, uiSortPriority = 9, locID=11255506, keycombos={{ combo="F5", repeatCount=1 }, { combo="" }}},

			battlegroup_card_row01_column01			={ userRemappable=true, uiSortPriority = 10, locID=11244243, keycombos={{ combo="Control+F1" }, { combo="" }}},
			battlegroup_card_row01_column02			={ userRemappable=true, uiSortPriority = 11, locID=11244244, keycombos={{ combo="Control+F2" }, { combo="" }}},
			battlegroup_card_row01_column03			={ userRemappable=true, uiSortPriority = 12, locID=11244245, keycombos={{ combo="Control+F3" }, { combo="" }}},
			battlegroup_card_row01_column04			={ userRemappable=true, uiSortPriority = 13, locID=11244246, keycombos={{ combo="Control+F4" }, { combo="" }}},
			battlegroup_card_row01_column05			={ userRemappable=true, uiSortPriority = 14, locID=11244247, keycombos={{ combo="Control+F5" }, { combo="" }}},
			battlegroup_card_row01_column06			={ userRemappable=true, uiSortPriority = 15, locID=11244248, keycombos={{ combo="Control+F6" }, { combo="" }}},
			
			army_ability_card_row01_column01		={ userRemappable=true, uiSortPriority = 20, locID=11145063, keycombos={{ combo="Control+F7" }, { combo="" }}},
			army_ability_card_row01_column02		={ userRemappable=true, uiSortPriority = 21, locID=11244771, keycombos={{ combo="Control+F8" }, { combo="" }}},
			army_ability_card_row01_column03		={ userRemappable=true, uiSortPriority = 22, locID=11244772, keycombos={{ combo="Control+F9" }, { combo="" }}},
			army_ability_card_row01_column04		={ userRemappable=true, uiSortPriority = 23, locID=11244773, keycombos={{ combo="Control+F10" }, { combo="" }}},
			army_ability_card_row01_column05		={ userRemappable=true, uiSortPriority = 24, locID=11244774, keycombos={{ combo="Control+F11" }, { combo="" }}},
			
		},
	},
	
	hud_control_groups =
	{
		locID = 11160395,
		groupType = 0,
		uiSortPriority = 4,
		bindings=
		{			
			-- Control Grouping Commands 
			
			hkgroup_select0							={userRemappable=true, uiSortPriority = 9, locID=11145013, keycombos={{ combo="0", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select1							={userRemappable=true, uiSortPriority = 0, locID=11145014, keycombos={{ combo="1", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select2							={userRemappable=true, uiSortPriority = 1, locID=11145015, keycombos={{ combo="2", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select3							={userRemappable=true, uiSortPriority = 2, locID=11145016, keycombos={{ combo="3", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select4							={userRemappable=true, uiSortPriority = 3, locID=11145017, keycombos={{ combo="4", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select5							={userRemappable=true, uiSortPriority = 4, locID=11145018, keycombos={{ combo="5", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select6							={userRemappable=true, uiSortPriority = 5, locID=11145019, keycombos={{ combo="6", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select7							={userRemappable=true, uiSortPriority = 6, locID=11145020, keycombos={{ combo="7", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select8							={userRemappable=true, uiSortPriority = 7, locID=11145021, keycombos={{ combo="8", repeatCount=0, remap=true }, { combo="" }}},
			hkgroup_select9							={userRemappable=true, uiSortPriority = 8, locID=11145022, keycombos={{ combo="9", repeatCount=0, remap=true }, { combo="" }}},

			hkgroup_focus0							={userRemappable=true, uiSortPriority = 19, locID=11145023, keycombos={{ combo="0", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus1							={userRemappable=true, uiSortPriority = 10, locID=11145024, keycombos={{ combo="1", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus2							={userRemappable=true, uiSortPriority = 11, locID=11145025, keycombos={{ combo="2", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus3							={userRemappable=true, uiSortPriority = 12, locID=11145026, keycombos={{ combo="3", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus4							={userRemappable=true, uiSortPriority = 13, locID=11145027, keycombos={{ combo="4", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus5							={userRemappable=true, uiSortPriority = 14, locID=11145028, keycombos={{ combo="5", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus6							={userRemappable=true, uiSortPriority = 15, locID=11145029, keycombos={{ combo="6", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus7							={userRemappable=true, uiSortPriority = 16, locID=11145030, keycombos={{ combo="7", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus8							={userRemappable=true, uiSortPriority = 17, locID=11145031, keycombos={{ combo="8", repeatCount=1, remap=true }, { combo="" }}},
			hkgroup_focus9							={userRemappable=true, uiSortPriority = 18, locID=11145032, keycombos={{ combo="9", repeatCount=1, remap=true }, { combo="" }}},

			hkgroup_set0							={userRemappable=true, uiSortPriority = 29, locID=11145033, keycombos={{ combo="Control+0", remap=true }, { combo="" }}},
			hkgroup_set1							={userRemappable=true, uiSortPriority = 20, locID=11145034, keycombos={{ combo="Control+1", remap=true }, { combo="" }}},
			hkgroup_set2							={userRemappable=true, uiSortPriority = 21, locID=11145035, keycombos={{ combo="Control+2", remap=true }, { combo="" }}},
			hkgroup_set3							={userRemappable=true, uiSortPriority = 22, locID=11145036, keycombos={{ combo="Control+3", remap=true }, { combo="" }}},
			hkgroup_set4							={userRemappable=true, uiSortPriority = 23, locID=11145037, keycombos={{ combo="Control+4", remap=true }, { combo="" }}},
			hkgroup_set5							={userRemappable=true, uiSortPriority = 24, locID=11145038, keycombos={{ combo="Control+5", remap=true }, { combo="" }}},
			hkgroup_set6							={userRemappable=true, uiSortPriority = 25, locID=11145039, keycombos={{ combo="Control+6", remap=true }, { combo="" }}},
			hkgroup_set7							={userRemappable=true, uiSortPriority = 26, locID=11145040, keycombos={{ combo="Control+7", remap=true }, { combo="" }}},
			hkgroup_set8							={userRemappable=true, uiSortPriority = 27, locID=11145041, keycombos={{ combo="Control+8", remap=true }, { combo="" }}},
			hkgroup_set9							={userRemappable=true, uiSortPriority = 28, locID=11145042, keycombos={{ combo="Control+9", remap=true }, { combo="" }}},
			
			hkgroup_add0							={userRemappable=true, uiSortPriority = 39, locID=11160396, keycombos={{ combo="Shift+0", remap=true }, { combo="" }}},
			hkgroup_add1							={userRemappable=true, uiSortPriority = 30, locID=11160397, keycombos={{ combo="Shift+1", remap=true }, { combo="" }}},
			hkgroup_add2							={userRemappable=true, uiSortPriority = 31, locID=11160398, keycombos={{ combo="Shift+2", remap=true }, { combo="" }}},
			hkgroup_add3							={userRemappable=true, uiSortPriority = 32, locID=11160399, keycombos={{ combo="Shift+3", remap=true }, { combo="" }}},
			hkgroup_add4							={userRemappable=true, uiSortPriority = 33, locID=11160400, keycombos={{ combo="Shift+4", remap=true }, { combo="" }}},
			hkgroup_add5							={userRemappable=true, uiSortPriority = 34, locID=11160401, keycombos={{ combo="Shift+5", remap=true }, { combo="" }}},
			hkgroup_add6							={userRemappable=true, uiSortPriority = 35, locID=11160402, keycombos={{ combo="Shift+6", remap=true }, { combo="" }}},
			hkgroup_add7							={userRemappable=true, uiSortPriority = 36, locID=11160403, keycombos={{ combo="Shift+7", remap=true }, { combo="" }}},
			hkgroup_add8							={userRemappable=true, uiSortPriority = 37, locID=11160404, keycombos={{ combo="Shift+8", remap=true }, { combo="" }}},
			hkgroup_add9							={userRemappable=true, uiSortPriority = 38, locID=11160405, keycombos={{ combo="Shift+9", remap=true }, { combo="" }}},
			
			hkgroup_clear0							={userRemappable=true, uiSortPriority = 49, locID=11145043, keycombos={{ combo="Control+Shift+0", remap=true }, { combo="" }}},
			hkgroup_clear1							={userRemappable=true, uiSortPriority = 40, locID=11145044, keycombos={{ combo="Control+Shift+1", remap=true }, { combo="" }}},
			hkgroup_clear2							={userRemappable=true, uiSortPriority = 41, locID=11145045, keycombos={{ combo="Control+Shift+2", remap=true }, { combo="" }}},
			hkgroup_clear3							={userRemappable=true, uiSortPriority = 42, locID=11145046, keycombos={{ combo="Control+Shift+3", remap=true }, { combo="" }}},
			hkgroup_clear4							={userRemappable=true, uiSortPriority = 43, locID=11145047, keycombos={{ combo="Control+Shift+4", remap=true }, { combo="" }}},
			hkgroup_clear5							={userRemappable=true, uiSortPriority = 44, locID=11145048, keycombos={{ combo="Control+Shift+5", remap=true }, { combo="" }}},
			hkgroup_clear6							={userRemappable=true, uiSortPriority = 45, locID=11145049, keycombos={{ combo="Control+Shift+6", remap=true }, { combo="" }}},
			hkgroup_clear7							={userRemappable=true, uiSortPriority = 46, locID=11145050, keycombos={{ combo="Control+Shift+7", remap=true }, { combo="" }}},
			hkgroup_clear8							={userRemappable=true, uiSortPriority = 47, locID=11145051, keycombos={{ combo="Control+Shift+8", remap=true }, { combo="" }}},
			hkgroup_clear9							={userRemappable=true, uiSortPriority = 48, locID=11145052, keycombos={{ combo="Control+Shift+9", remap=true }, { combo="" }}},
		},
	},
	
	
	----------------------------------------------------------------------------------------------------------------
	-- HUD selection commands (selection commands).
	----------------------------------------------------------------------------------------------------------------
	hud_selection =
	{
		locID = 11243807,
		groupType = 0,
		uiSortPriority = 1,
		bindings=
		{
			-- common selection & orders
			pick									={userRemappable=false, uiSortPriority = 0, significant = true, locID=11193570, keycombos={{ combo="MouseLeft" }, { combo="" }}},
			context_action							={userRemappable=false, uiSortPriority = 1, significant = true, locID=11243810, keycombos={{ combo="MouseRight" }, { combo="" }}},
			focus_selection							={userRemappable=true, uiSortPriority = 2, locID=11144991, keycombos={{ combo="Apostrophe", remap=true }, { combo="" }}},		
			pick_all								={userRemappable=true, uiSortPriority = 4, locID=11145006, keycombos={{ combo="Control+A" }, { combo="" }}},
			pick_all_on_screen						={userRemappable=true, uiSortPriority = 5, locID=11145008, keycombos={{ combo="Control+A", repeatCount=1, remap=true }, { combo="" }}},
			focus_home								={userRemappable=true, uiSortPriority = 6, significant=true, locID=11144992, keycombos={{ combo="Home" }, { combo="" }}},	

			-- subselection
			subselect_next							={userRemappable=false, uiSortPriority = 20, locID=11145009, keycombos={{ combo="Tab" }, { combo="" }}},
			subselect_previous						={userRemappable=true, uiSortPriority = 21, locID=11145010, keycombos={{ combo="Control+Tab" }, { combo="" }}},
			subselect_maximize						={userRemappable=true, uiSortPriority = 22, locID=11145011, keycombos={{ combo="Backslash", remap=true }, { combo="" }}},			
			
			-- focus commands.			
			focus_next_idle_infantry				={userRemappable=true, uiSortPriority = 31, significant = true, locID=11144997, keycombos={{ combo="Comma", remap=true }, { combo="" }}},
			focus_next_idle_vehicle					={userRemappable=true, uiSortPriority = 32, significant = true, locID=11144998, keycombos={{ combo="Period", remap=true }, { combo="" }}},
			focus_next_idle_emplacement				={userRemappable=true, uiSortPriority = 33, significant = true, locID=11244007, keycombos={{ combo="Slash", remap=true }, { combo="" }}},
			focus_next_infantry						={userRemappable=true, uiSortPriority = 34, locID=11144994, keycombos={{ combo="Alt+Comma", remap=true }, { combo="" }}},
			focus_next_vehicle						={userRemappable=true, uiSortPriority = 35, locID=11144995, keycombos={{ combo="Alt+Period", remap=true }, { combo="" }}},		
			focus_next_emplacement					={userRemappable=true, uiSortPriority = 36, locID=11244008, keycombos={{ combo="Alt+Slash", remap=true }, { combo="" }}},	
			
			-- cycle selection 
			pick_next_idle_infantry					={userRemappable=true, uiSortPriority = 40, locID=11243980, keycombos={{ combo="Shift+Comma" }, { combo="" }}},
			pick_next_idle_vehicle					={userRemappable=true, uiSortPriority = 41, locID=11243981, keycombos={{ combo="Shift+Period" }, { combo="" }}},
			pick_next_idle_emplacement				={userRemappable=true, uiSortPriority = 42, locID=11243982, keycombos={{ combo="Shift+Slash" }, { combo="" }}},
			pick_all_infantry						={userRemappable=true, uiSortPriority = 43, locID=11145001, keycombos={{ combo="Control+Comma", remap=true }, { combo="" }}},
			pick_all_vehicles						={userRemappable=true, uiSortPriority = 44, locID=11145002, keycombos={{ combo="Control+Period", remap=true }, { combo="" }}},
			pick_all_emplacements					={userRemappable=true, uiSortPriority = 45, locID=11145000, keycombos={{ combo="Control+Slash", remap=true }, { combo="" }}},
			pick_next_infantry						={userRemappable=true, uiSortPriority = 46, locID=11243842, keycombos={{ combo="Shift+Alt+Comma" }, { combo="" }}},
			pick_next_vehicle						={userRemappable=true, uiSortPriority = 47, locID=11243843, keycombos={{ combo="Shift+Alt+Period" }, { combo="" }}},
			pick_next_emplacement					={userRemappable=true, uiSortPriority = 48, locID=11243844, keycombos={{ combo="Shift+Alt+Slash" }, { combo="" }}},
			pick_all_idle_infantry					={userRemappable=true, uiSortPriority = 49, locID=11145004, keycombos={{ combo="Control+Alt+Comma", remap=true }, { combo="" }}},
			pick_all_idle_vehicles					={userRemappable=true, uiSortPriority = 50, locID=11145005, keycombos={{ combo="Control+Alt+Period", remap=true }, { combo="" }}},			
			pick_all_idle_emplacements				={userRemappable=true, uiSortPriority = 51, locID=11145003, keycombos={{ combo="Control+Alt+Slash", remap=true }, { combo="" }}},				
			
		},
	},

	----------------------------------------------------------------------------------------------------------------
	-- HUD dynamic commands (issuable commands using modern grid layout).
	----------------------------------------------------------------------------------------------------------------
	
	hud_dynamic_modern =
	{
		locID = 11144977,
		groupType = 1,
		uiSortPriority = 0,
		bindings=
		{
			command_card_row01_column01				={row=1, column=2, uiSortPriority = 0,  userRemappable=true, locID=11145067, allowIgnoreShift=true, keycombos={{ combo="Q", remap=true }}},
			command_card_row01_column02				={row=1, column=3, uiSortPriority = 1,  userRemappable=true, locID=11145068, allowIgnoreShift=true, keycombos={{ combo="W", remap=true }}},
			command_card_row01_column03				={row=1, column=4, uiSortPriority = 2,  userRemappable=true, locID=11145069, allowIgnoreShift=true, keycombos={{ combo="E", remap=true }}},
			command_card_row01_column04				={row=1, column=5, uiSortPriority = 3,  userRemappable=true, locID=11145070, allowIgnoreShift=true, keycombos={{ combo="R", remap=true }}},
			
			command_card_row02_column01				={row=2, column=2, uiSortPriority = 4,  userRemappable=true, locID=11145077, allowIgnoreShift=true, keycombos={{ combo="A", remap=true }}},
			command_card_row02_column02				={row=2, column=3, uiSortPriority = 5,  userRemappable=true, locID=11145078, allowIgnoreShift=true, keycombos={{ combo="S", remap=true }}},
			command_card_row02_column03				={row=2, column=4, uiSortPriority = 6,  userRemappable=true, locID=11145079, allowIgnoreShift=true, keycombos={{ combo="D", remap=true }}},
			command_card_row02_column04				={row=2, column=5, uiSortPriority = 7,  userRemappable=true, locID=11145080, allowIgnoreShift=true, keycombos={{ combo="F", remap=true }}},
			
			command_card_row03_column01				={row=3, column=2, uiSortPriority = 8,  userRemappable=true, locID=11145086, allowIgnoreShift=true, keycombos={{ combo="Z", remap=true }}},
			command_card_row03_column02				={row=3, column=3, uiSortPriority = 9,  userRemappable=true, locID=11145087, allowIgnoreShift=true, keycombos={{ combo="X", remap=true }}},
			command_card_row03_column03				={row=3, column=4, uiSortPriority = 10,  userRemappable=true, locID=11145088, allowIgnoreShift=true, keycombos={{ combo="C", remap=true }}},
			command_card_row03_column04				={row=3, column=5, uiSortPriority = 11,  userRemappable=true, locID=11145089, allowIgnoreShift=true, keycombos={{ combo="V", remap=true }}},
			
			upgrade_card_row01_column01				={row=1, column=1, uiSortPriority = 12,  userRemappable=true, locID=11145094, allowIgnoreShift=true, keycombos={{ combo="T", remap=true }}},
			upgrade_card_row02_column01				={row=2, column=1, uiSortPriority = 13,  userRemappable=true, locID=11145095, allowIgnoreShift=true, keycombos={{ combo="G", remap=true }}},
			upgrade_card_row03_column01				={row=3, column=1, uiSortPriority = 14,  userRemappable=true, locID=11145096, allowIgnoreShift=true, keycombos={{ combo="B", remap=true }}},
			upgrade_card_row04_column01				={row=4, column=1, uiSortPriority = 14,  userRemappable=true, locID=11247980, allowIgnoreShift=true, keycombos={{ combo="Y", remap=true }}},
		},
	},
	
	camera =
	{
		locID = 11144971,
		groupType = 0,
		uiSortPriority = 2,
		bindings=
		{
			-- remappable
			default									={ userRemappable=true, uiSortPriority = 0, significant=true, locID=11145151, keycombos={{ combo="Backspace"}, { combo="" }}},
			zoom_in									={ userRemappable=true, uiSortPriority = 1, locID=11145152, keycombos={{ combo="Equal"}, { combo="" }}},
			zoom_out								={ userRemappable=true, uiSortPriority = 2, locID=11145153, keycombos={{ combo="Minus"}, { combo="" }}},			
			
			pan_left								={ userRemappable=true, uiSortPriority = 3, locID=11145154, keycombos={{ combo="Left" },{ combo="Alt+A", remap=true }}},
			pan_right								={ userRemappable=true, uiSortPriority = 4, locID=11145155, keycombos={{ combo="Right" },{ combo="Alt+D", remap=true }}},
			pan_up									={ userRemappable=true, uiSortPriority = 5, locID=11145156, keycombos={{ combo="Up" },{ combo="Alt+W", remap=true }}},
			pan_down								={ userRemappable=true, uiSortPriority = 6, locID=11145157, keycombos={{ combo="Down" },{ combo="Alt+S", remap=true }}},
			
			pan										={ userRemappable=true, uiSortPriority = 7, locID=11244012, keycombos={{ combo="MouseMiddle"}, { combo="" }}},
			orbit									={ userRemappable=true, uiSortPriority = 20, significant=true, locID=11244013, keycombos={{ combo="Alt"}, { combo="" }}},
			
			-- not remappable
			zoom									={ userRemappable=false, uiSortPriority = 21, locID=11244014, keycombos={{ combo="Alt+Control+MouseLeft" },{ combo="Alt+Control+MouseRight" }}},
			screen_pan_left							={ userRemappable=false, uiSortPriority = 22, locID=11244015, keycombos={{ combo="ScreenLeft"}, { combo="" }}, userVisible=false},
			screen_pan_right						={ userRemappable=false, uiSortPriority = 23, locID=11244016, keycombos={{ combo="ScreenRight"}, { combo="" }}, userVisible=false},
			screen_pan_up							={ userRemappable=false, uiSortPriority = 24, locID=11244017, keycombos={{ combo="ScreenTop"}, { combo="" }}, userVisible=false},
			screen_pan_down							={ userRemappable=false, uiSortPriority = 25, locID=11244018, keycombos={{ combo="ScreenBottom"}, { combo="" }}, userVisible=false},			
			
		},
	},
	
	communication =
	{
		locID = 11245257,
		groupType = 0,
		uiSortPriority = 5,
		bindings=
		{
			-- while CoH2 used ` as the key for opening chat, standard convention across a wide swath of the industry is to use Enter as the key for opening chat
			toggle_chat								={ userRemappable=true, uiSortPriority = 0, significant=true, locID=11167108, keycombos={{ combo="Enter", remap=true }, { combo="" }}},
			toggle_chat_channel_all					={ userRemappable=true, uiSortPriority = 1, significant=true, locID=11247063, keycombos={{ combo="Shift+Enter", remap=true }, { combo="" }}},
			switch_chat_channels					={ userRemappable=false, uiSortPriority = 2, locID=11244282, keycombos={{ combo="Tab" }, { combo="" }}}, -- switch channels if the player is still alive
			ping_attack								={ userRemappable=true, uiSortPriority = 3, locID=11145147, keycombos={{ combo="Control+R", remap=true }, { combo="" }}},
			ping_defend								={ userRemappable=true, uiSortPriority = 4, locID=11145148, keycombos={{ combo="Control+T", remap=true }, { combo="" }}},
			ping_question							={ userRemappable=true, uiSortPriority = 5, locID=11145150, keycombos={{ combo="Control+E", remap=true }, { combo="" }}},
			send_chat								={ userRemappable=false, uiSortPriority = 6, locID=2500, keycombos={{ combo="Enter" }, { combo="" }}},
		},
	},
	
	game = 
	{
		locID = 11149466,
		groupType = 0,
		uiSortPriority = 0,
		bindings=
		{		
			escape									={ userRemappable=false, uiSortPriority = 0, locID=11145139, keycombos={{ combo="Escape"}, { combo="" }}, userVisible=false},
			queue_command							={ userRemappable=false, uiSortPriority = 1, significant=true, locID=11216735, keycombos={{ combo="Shift"}, { combo="" }}},
			tactical_pause							={ userRemappable=true, uiSortPriority = 2, significant=true, locID=11207007, keycombos={{ combo="Space", remap=true }, { combo="" }}},
			toggle_tacticalmap						={ userRemappable=true, uiSortPriority = 3, significant=true, locID=11219804, allowIgnoreGamepadRTrigger=true, keycombos={{ combo="M", remap=true }, { combo="" }}},
			focus_event_cue							={ userRemappable=true, uiSortPriority = 4, significant = true, locID=11145012, allowIgnoreGamepadRTrigger=true, keycombos={{ combo="Delete"}, { combo="" }}},
			-- Disabling toggle_playerlist since it isn't working as intended
			-- toggle_playerlist					={ userRemappable=true, uiSortPriority = 5, locID=11144999, keycombos={{ combo="Control+Grave", remap=true }, { combo="" }}},		
			skip_nis								={ userRemappable=false, uiSortPriority = 5, locID=11244776, keycombos={{ combo="Escape", holdTime=2.0 }, { combo="" }}},
			toggle_screenshotmode					={ userRemappable=true, uiSortPriority = 6, significant=true, locID=11248448, keycombos={{ combo="Control+Shift+Slash", remap=true }, { combo="" }}},
			toggle_show_player_names				={ userRemappable=true, uiSortPriority = 7, significant=true, locID=11252040, keycombos={{ combo="Control"}, { combo="" }}},
			skip_scar_event							={ userRemappable=false, uiSortPriority = 8, locID=0, keycombos={{ combo="Enter"}, { combo="" }}, userVisible=false},
			--toggle_techtree						={userRemappable=true, uiSortPriority = 2, locID=11219803, keycombos={{ combo="Control+Shift+T", remap=true }, { combo="" }}},
			--pause									={locID=0, keycombos={{ combo="Pause"}}},
			--pause_menu							={locID=0, allowIgnoreGamepadRTrigger=true, keycombos={{ combo="F10"}, { combo="Gamepad_Menu1"}}},
			--quick_save							={locID=0, keycombos={{ combo="Shift+F5"}}},
			--quick_load							={locID=0, keycombos={{ combo="Shift+F6"}}},			
			--page_up								={locID=0, keycombos={{ combo="PageUp"}}},
			--page_down								={locID=0, keycombos={{ combo="PageDown"}}},
		},
	},
	
	-- observer replay is not for launch. change group type to 0 once replay feature is live
	observer_replay =
	{
		locID = 11232144,
		groupType = 3,
		uiSortPriority = 6,
		bindings=
		{
			toggle_cinematic_mode					={ userRemappable=true, uiSortPriority = 0, locID=11153284, keycombos={{ combo="=" }, { combo="]" }}},
			toggle_free_camera						={ userRemappable=true, uiSortPriority = 0, locID=11153284, keycombos={{ combo="=" }, { combo="]" }}},
			toggle_fow								={ userRemappable=true, uiSortPriority = 0, locID=11153284, keycombos={{ combo="=" }, { combo="]" }}},
			slower									={ userRemappable=true, uiSortPriority = 0, locID=11153284, keycombos={{ combo="=" }, { combo="]" }}},
			faster									={ userRemappable=true, uiSortPriority = 0, locID=11153284, keycombos={{ combo="=" }, { combo="]" }}},
			view_next_player						={ userRemappable=true, uiSortPriority = 0, locID=11153284, keycombos={{ combo="=" }, { combo="]" }}},
			view_previous_player					={ userRemappable=true, uiSortPriority = 0, locID=11153284, keycombos={{ combo="=" }, { combo="]" }}},
			
		},
	},
}
