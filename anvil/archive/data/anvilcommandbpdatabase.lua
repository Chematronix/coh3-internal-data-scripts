---------------------------------------------------------------------
-- File    : CardinalCommandBPDatabase.lua
--

--~
--~ 
--~ 
CommandBPDatabase =
{
--~ 	{
--~ 		name = "Name of the Command",
--~ 		help = "Help info on what the command does.",
--~ 		parameters =
--~ 		{
--~ 			{
--~ 				name = "Event",
--~ 				help = "Name of the event.",
--~ 				default = "dummy",
--~ 				values =
--~ 				{
--~ 					"Tom",
--~ 					"Dick",
--~ 					"Harry",
--~ 				},
--~ 				value_type = "marker",	--	{"marker","anim","event"}
--~ 				value_browsepath = "<rootpath>|*.ext;*.ext2",
--~ 			}
--~ 		}
--~ 	},

	{
		name = "set_sails_anim_state",
		help = "set sails animation state",
		parameters =
		{
			{
				name = "state",
				help = "state to reach, set reset if you want to use the base material settings",
				default = "rest",
				values =
				{
					"reset",
					"rest",
					"moving",
					"sinking",
				},
			},
			{
				name = "time",
				help = "time to reach the state",
				default = "1",
			},
		},
	},


	{
		name = "vehiclecustomization_setcharredamount",
		help = "set charring amount on VehicleCustomizationComponents",
		parameters =
		{
			{
				name = "amount",
				help = "How much charring to instantly apply",
				default = "0",
			},
		},
	},
}
