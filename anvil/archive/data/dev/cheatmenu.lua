import("dev/cheatscript.lua")

local hotkeys = {}
local hotkeys_alt = {}





if not World_IsCampaignMetamapGame() then
	hotkeys = {
		name = "Hotkeys",
		type = SubMenu,
		SubMenuItems = 
		{
			newelement( "1. Spawn US Riflemen Squad", 		"CONTROL+SHIFT+1", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'riflemen_us.lua' ))", NO_MP ),
			newelement( "2. Spawn US Engineer Squad",		"CONTROL+SHIFT+2", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'engineer_us.lua'))", NO_MP ), 
			newelement( "3. Spawn US HMG Squad", 			"CONTROL+SHIFT+3", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'hmg_30cal_us.lua'))", NO_MP ),
			newelement( "4. Spawn German Grenadiers", 		"CONTROL+SHIFT+4", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'grenadier_ger.lua'))", NO_MP ),
			newelement( "5. Spawn German Engineers", 		"CONTROL+SHIFT+5", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'pioneer_ger.lua'))", NO_MP ),
			newelement( "6. Spawn German Sniper", 			"CONTROL+SHIFT+6", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'sniper_ger.lua'))", NO_MP),
			newelement( "7. Spawn German HMG Squad", 		"CONTROL+SHIFT+7", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'hmg_mg42_ger.lua'))", NO_MP ),
			newelement( "8. Spawn US Unarmed Engineers", 	"CONTROL+SHIFT+8", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'unarmed_engineer.lua'))", NO_MP ),
			newelement( "9. Spawn US HQ", 					"CONTROL+SHIFT+9", "SpawnEntityAtMouse( BP_GetEntityBlueprint( 'hq_us.lua'))", NO_MP ),
		},
	}
	
	hotkeys_alt = 
	{
		name = "Hotkeys ALT",
		type = SubMenu,
		SubMenuItems = 
		{
			newelement( "1. Spawn US Sherman Squad", 			"CONTROL+SHIFT+ALT+1", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'sherman_us.lua' ))", NO_MP ),
			newelement( "2. Spawn US Greyhound Squad",			"CONTROL+SHIFT+ALT+2", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'greyhound_us.lua'))", NO_MP ), 
			newelement( "3. Spawn US Halftrack 75mm Squad", 	"CONTROL+SHIFT+ALT+3", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'halftrack_75mm_us.lua'))", NO_MP ),
			newelement( "4. Spawn US 4x4 Truck Squad", 				"CONTROL+SHIFT+ALT+4", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'truck_4x4_us.lua'))", NO_MP ),
			newelement( "5. Spawn German Armored Car Squad", 	"CONTROL+SHIFT+ALT+5", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'armored_car_ger.lua'))", NO_MP ),
			newelement( "6. Spawn German Panzer 4 Squad", 		"CONTROL+SHIFT+ALT+6", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'panzer_iv_ger.lua'))", NO_MP ),
			newelement( "7. Spawn German Stug 3 Squad", 		"CONTROL+SHIFT+ALT+7", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'stug_iii_ger.lua'))", NO_MP),
			newelement( "8. Spawn German Hetzer Squad", 		"CONTROL+SHIFT+ALT+8", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'hetzer_ger.lua'))", NO_MP ),
			newelement( "9. Spawn German Wirebelwind Squad", 	"CONTROL+SHIFT+ALT+9", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'wirbelwind_ger.lua'))", NO_MP ),
			newelement( "10. Convert hovered territory to allies", "CONTROL+SHIFT+ALT+A", "ConvertMouseoverTerritory(\"\")", NO_MP),
			newelement( "11. Convert hovered territory to neutral", "CONTROL+SHIFT+ALT+N", "ConvertMouseoverTerritory(\"enemy\")", NO_MP),
			newelement( "12. Convert hovered territory to enemies", "CONTROL+SHIFT+ALT+E", "ConvertMouseoverTerritory(\"neutral\")", NO_MP),
		}
	}
else
	hotkeys = {
		name = "Hotkeys",
		type = SubMenu,
		SubMenuItems = 
		{
			newelement( "1. Spawn US Armoured Company", 		"CONTROL+SHIFT+1", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'company_armoured_us.lua' ))", NO_MP ),
			newelement( "2. Spawn US Airborne Company",		"CONTROL+SHIFT+2", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'company_paratrooper_us.lua'))", NO_MP ), 
			newelement( "3. Spawn US Spec Ops Company", 	"CONTROL+SHIFT+3", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'company_spec_ops_us.lua'))", NO_MP ),
			newelement( "4. Spawn German Armored Company", "CONTROL+SHIFT+4", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'company_armored_ger.lua'))", NO_MP ),
			newelement( "5. Spawn German Mechanized Company", "CONTROL+SHIFT+5", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'company_mechanized_ger.lua'))", NO_MP ),
			newelement( "6. Spawn US Infantry Company", "CONTROL+SHIFT+6", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'company_infantry_us.lua'))", NO_MP ),
			newelement( "7. Spawn German Infantry Company", "CONTROL+SHIFT+7", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'company_infantry_ger.lua'))", NO_MP ),
			newelement( "8. Spawn German Luftwaffe Company", "CONTROL+SHIFT+8", "SpawnSquadAtMouse( BP_GetSquadBlueprint( 'company_luftwaffe_ger.lua'))", NO_MP ),
			newelement( "10. Convert hovered territory to allies", "CONTROL+SHIFT+ALT+A", "ConvertMouseoverTerritory(\"\")", NO_MP),
			newelement( "11. Convert hovered territory to neutral", "CONTROL+SHIFT+ALT+N", "ConvertMouseoverTerritory(\"enemy\")", NO_MP),
			newelement( "12. Convert hovered territory to enemies", "CONTROL+SHIFT+ALT+E", "ConvertMouseoverTerritory(\"neutral\")", NO_MP),
			newelement( "13. Reset Movement Points of selected Squad", "CONTROL+SHIFT+M", "ResetMovementPoints()", NO_MP),
			newelement( "14. Reset Action Points of selected Squad", "CONTROL+SHIFT+A", "ResetActionPoints()", NO_MP),
		},
	}
	
	hotkeys_alt = 
	{
	}
end

function GetAnvilSquadSubMenu()
return
	{
			{
				name = "gameplay",
				type = SubMenu,
				SubMenuItems = GetSpawnSquadMenuTable("sbps\\gameplay\\", false)
			},
			{
				name = "dev",
				type = SubMenu,
				SubMenuItems = GetSpawnSquadMenuTable("sbps\\dev\\", false)
			},
		
			{
				name = "common",
				type = SubMenu,
				SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\common\\", false)
			},
			hotkeys,
			hotkeys_alt,
			{
				name = "American",
				type = SubMenu,
				SubMenuItems =
				{
					{
						name = "Infantry",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\american\\infantry\\", true)
					},
					{
						name = "Campaign Company",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\american\\campaign\\company\\", true)
					},
					{
						name = "Emplacements",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\american\\emplacements\\", true)
					},
					{
						name = "Team Weapons",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\american\\team_weapons\\", true)
					},
					{
						name = "Vehicles",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\american\\vehicles\\", true)
					},
					{
						name = "Campaign",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\american\\campaign\\", true)
					},
					{
						name = "Gameplay",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\american\\gameplay\\", true)
					},
					{
						name = "Aircraft",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\american\\aircraft\\", true)
					},
				},
			},
			{
				name = "German",
				type = SubMenu,
				SubMenuItems =
				{
					{
						name = "Infantry",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\german\\infantry\\", true)
					},
					{
						name = "Campaign Company",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\german\\campaign\\company\\", true)
					},
				
					{
						name = "Emplacements",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\german\\emplacements\\", true)
					},
					{
						name = "Team Weapons",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\german\\team_weapons\\", true)
					},
					{
						name = "Vehicles",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\german\\vehicles\\", true)
					},
					{
						name = "Campaign",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\german\\campaign\\", true)
					},
				},
			},
			{
				name = "British Italy",
				type = SubMenu,
				SubMenuItems =
				{
					{
						name = "Infantry",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british\\infantry\\", true)
					},
					{
						name = "Campaign Company",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british\\campaign\\company\\", true)
					},
					{
						name = "Emplacements",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british\\emplacements\\", true)
					},
					{
						name = "Team Weapons",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british\\team_weapons\\", true)
					},
					{
						name = "Vehicles",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british\\vehicles\\", true)
					},
					{
						name = "Campaign",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british\\campaign\\", true)
					},
				},
			},
		{
				name = "British Africa",
				type = SubMenu,
				SubMenuItems =
				{
					{
						name = "Infantry",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british_africa\\infantry\\", true)
					},
					{
						name = "Emplacements",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british_africa\\emplacements\\", true)
					},
					{
						name = "Team Weapons",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british_africa\\team_weapons\\", true)
					},
					{
						name = "Vehicles",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british_africa\\vehicles\\", true)
					},
					{
						name = "Campaign",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british_africa\\campaign\\", true)
					},
					{
						name = "Gameplay",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british_africa\\gameplay\\", true)
					},
					{
						name = "Aircraft",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\british_africa\\aircraft\\", true)
					},
				},
			},
		{
				name = "Afrika Korps",
				type = SubMenu,
				SubMenuItems =
				{
					{
						name = "Infantry",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\afrika_korps\\infantry\\", true)
					},
					{
						name = "Emplacements",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\afrika_korps\\emplacements\\", true)
					},
					{
						name = "Team Weapons",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\afrika_korps\\team_weapons\\", true)
					},
					{
						name = "Vehicles",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\afrika_korps\\vehicles\\", true)
					},
					{
						name = "Campaign",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\afrika_korps\\campaign\\", true)
					},
				},
			},
			{
				name = "NPCs",
				type = SubMenu,
				SubMenuItems =
				{
					{
						name = "Italians",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\npc\\italian\\", true)
					},
					{
						name = "Civilians",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\npc\\civilian\\", true)
					},
				},
			},
		}
end

function GetAnvilEntitySubMenu()
return GetSpawnEntityMenuTableFiltered("ebps\\")
end

function GetAnvilEntityCosmeticsSubMenu()
return
	{
		newelement("Reload Attachment PBGs", "",    "Misc_ReloadAttachmentPBGs()" ),
		{
			name = "Army Skins",
			type = SubMenu,
			SubMenuItems = 
			{	
				{
					name = "American",
					type = SubMenu,
					SubMenuItems = 
					{
						{
							name = "Cosmetic Select",
							type = SubMenu,
							SubMenuItems = GetCosmeticBundleTable("americans", "army_skin\\american\\")
						},
						{
							name = "Bundle Select",
							type = SubMenu,
							SubMenuItems = AddCosmeticBundleSelectButton("americans", "army_skin\\american\\")
						},
					}
				},
				{
					name = "German",
					type = SubMenu,
					SubMenuItems = 
					{
						{
							name = "Cosmetic Select",
							type = SubMenu,
							SubMenuItems = GetCosmeticBundleTable("germans", "army_skin\\german\\")
						},
						{
							name = "Bundle Select",
							type = SubMenu,
							SubMenuItems = AddCosmeticBundleSelectButton("germans", "army_skin\\german\\")
						},
					}
				},
				{
					name = "British Africa",
					type = SubMenu,
					SubMenuItems = 
					{
						{
							name = "Cosmetic Select",
							type = SubMenu,
							SubMenuItems = GetCosmeticBundleTable("british_africa", "army_skin\\british_africa\\")
						},
						{
							name = "Bundle Select",
							type = SubMenu,
							SubMenuItems = AddCosmeticBundleSelectButton("british_africa", "army_skin\\british_africa\\")
						},
					}
				},
				{
					name = "Afrika Korps",
					type = SubMenu,
					SubMenuItems = 
					{
						{
							name = "Cosmetic Select",
							type = SubMenu,
							SubMenuItems = GetCosmeticBundleTable("afrika_korps", "army_skin\\afrika_korps\\")
						},
						{
							name = "Bundle Select",
							type = SubMenu,
							SubMenuItems = AddCosmeticBundleSelectButton("afrika_korps", "army_skin\\afrika_korps\\")
						},
					}
				}
			}
		},
		{
			name = "Attachment List",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Gameplay",
					type = SubMenu,
					SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\gameplay\\")
				},
				{
					name = "American",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Aircraft",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\aircraft\\")
						},
						{
							name = "Buildings",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\buildings\\")
						},
						{
							name = "Campaign",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\campaign\\")
						},
						{
							name = "Gameplay",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\gameplay\\")
						},
						{
							name = "Infantry",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\infantry\\")
						},
						{
							name = "Projectile",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\projectile\\")
						},
						{
							name = "Props",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\props\\")
						},
						{
							name = "Team Weapons",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\team_weapons\\")
						},
						{
							name = "Vehicles",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\vehicles\\")
						},
						{
							name = "Weapons",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\weapons\\")
						},
						{
							name = "Wrecks",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\american\\wrecks\\")
						},
					},
				},
				{
					name = "German",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Aircraft",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\aircraft\\")
						},
						{
							name = "Buildings",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\buildings\\")
						},
						{
							name = "Campaign",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\campaign\\")
						},
						{
							name = "Gameplay",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\gameplay\\")
						},
						{
							name = "Infantry",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\infantry\\")
						},
						{
							name = "Projectile",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\projectile\\")
						},
						{
							name = "Props",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\props\\")
						},
						{
							name = "Team Weapons",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\team_weapons\\")
						},
						{
							name = "Vehicles",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\vehicles\\")
						},
						{
							name = "Weapons",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\weapons\\")
						},
						{
							name = "Wrecks",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\german\\wrecks\\")
						},
					},
				},
				{
					name = "British Africa",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Aircraft",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\aircraft\\")
						},
						{
							name = "Buildings",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\buildings\\")
						},
						{
							name = "Campaign",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\campaign\\")
						},
						{
							name = "Gameplay",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\gameplay\\")
						},
						{
							name = "Infantry",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\infantry\\")
						},
						{
							name = "Projectile",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\projectile\\")
						},
						{
							name = "Props",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\props\\")
						},
						{
							name = "Team Weapons",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\team_weapons\\")
						},
						{
							name = "Vehicles",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\vehicles\\")
						},
						{
							name = "Weapons",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\weapons\\")
						},
						{
							name = "Wrecks",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\british_africa\\wrecks\\")
						},
					},
				},
				{
					name = "Afrika Korps",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Aircraft",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\aircraft\\")
						},
						{
							name = "Buildings",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\buildings\\")
						},
						{
							name = "Campaign",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\campaign\\")
						},
						{
							name = "Gameplay",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\gameplay\\")
						},
						{
							name = "Infantry",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\infantry\\")
						},
						{
							name = "Projectile",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\projectile\\")
						},
						{
							name = "Props",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\props\\")
						},
						{
							name = "Team Weapons",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\team_weapons\\")
						},
						{
							name = "Vehicles",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\vehicles\\")
						},
						{
							name = "Weapons",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\weapons\\")
						},
						{
							name = "Wrecks",
							type = SubMenu,
							SubMenuItems = GetEntityCosmeticMenuTableFiltered("ebps\\races\\afrika_korps\\wrecks\\")
						},
					},
				}
			}
			
		}
	}
end

function GetAnvilUpgradesSubMenu()
	return
	{
		{
			name = "dev",
			type = SubMenu,
			SubMenuItems = 
			{
				newelement("Unlock All American Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_tech_us')" ),
				
				--American Battlegroups
				newelement("Unlock Airborne Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_airborne_us')" ),
				newelement("Unlock Armored Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_armored_us')" ),
				newelement("Unlock Infantry Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_infantry_us')" ),
				newelement("Unlock Special Operations Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_special_operations_us')" ),
				
				--British Battlegroups				
				newelement("Unlock Indian Artillery Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_indian_artillery_uk')" ),
				newelement("Unlock British Armored Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_british_armored_uk')" ),
				newelement("Unlock British Air And Sea Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_air_and_sea_uk')" ),
				newelement("Unlock British Canadian Vanguard Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_british_canadian_vanguard_uk')" ),
				
				--German Battlegroups				
				newelement("Unlock Mechanized Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_mechanized_ger')" ),
				newelement("Unlock Luftwaffe Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_luftwaffe_ger')" ),
				newelement("Unlock Breakthrough Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_breakthrough_ger')" ),
				newelement("Unlock Defense Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_defense_ger')" ),
				newelement("Unlock Mountain Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_mountain_ger')" ),
				newelement("Unlock Coastal Battlegroup Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_coastal_ger')" ),
				
				--DAK Battlegroups				
				newelement("Unlock Italian Infantry Abilities", "",    "GivePlayerUpgrade('dev_unlock_battlegroup_italian_infantry_ak')" ),
				newelement("Unlock DAK Single Player Abilities", "",    "GivePlayerUpgrade('sp_generic_tech_unlock')" ),
				
				-- German Field Commanders
				newelement("Unlock German Special Ops Commander", "",    "GivePlayerUpgrade('dev_unlock_commander_special_ops_ger')" ),
				newelement("Unlock German Mechanized Commander", "",    "GivePlayerUpgrade('dev_unlock_commander_mechanized_ger')" ),
				newelement("Unlock German Defensive Commander", "",    "GivePlayerUpgrade('dev_unlock_commander_defensive_ger')" ),
				
				-- Misc
				newelement("Reveal Map (provides vision, doesn't just remove fog of war like ctrl + shift + d)", "",    "GivePlayerUpgrade('dev_reveal_all')" ),
				newelement("UnReveal Map (removes previous upgrade, cancelling vision)", "",    "GivePlayerUpgrade('dev_reveal_all_disabled')" ),
				newelement("Destroy all enemy infantry and vehicles", "",    "GivePlayerUpgrade('dev_destroy_all_enemy_infantry_and_vehicles')" ),
				newelement("Casualty Cheats Enabled (allows you to increment/decrement casualties on aide_stations)", "",    "GivePlayerUpgrade('dev_casualty_cheat_enabled')" ),
				newelement("Unlock Generic Mission Specific Abilities", "",    "GivePlayerUpgrade('m_generic_player_ability_unlock')" ),
				newelement("Instant Infantry Capture / Revert Rate", "",    "GivePlayerUpgrade('dev_increase_capture_speed')" ),
				
			},
		},
			------------------------------------------------------------------------------CAMPAIGN COMPANIES-------------------------------------------------------------------------------------------
		{
			name = "Campaign",
			type = SubMenu,
			SubMenuItems =
			{				
				--- Battle Factors ---
				{
					name = "Battle Factors",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Health",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Disorganized", "",    "GivePlayerUpgrade('disorganized_battlefactor')" ),
								newelement("Unlock Replacement NCOs", "",    "GivePlayerUpgrade('replacement_ncos_battlefactor')" ),
								newelement("Unlock Tank School Grads", "",    "GivePlayerUpgrade('tank_school_grads_battlefactor')" ),
							},
						},
						{
							name = "Supply",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Distant Barracks", "",    "GivePlayerUpgrade('distant_barracks_battlefactor')" ),
								newelement("Unlock Infantry Equipment Failure", "",    "GivePlayerUpgrade('infantry_equipment_failure_battlefactor')" ),
								newelement("Unlock Low Fuel Supply", "",    "GivePlayerUpgrade('low_fuel_supply_battlefactor')" ),
							},
						},
					},
				},
				--- Enemy Companies ---
				{
					name = "Enemy Companies",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "German Mechanized",
							type = SubMenu,
							SubMenuItems = 
							{
								{
									name = "Active Abilities",
									type = SubMenu,
									SubMenuItems =
									{
										newelement("Unlock Deploy Panther", "",    "GivePlayerUpgrade('c_mechanized_deploy_panther_ger')" ),
										newelement("Unlock Light Artillery Barrage", "",    "GivePlayerUpgrade('c_mechanized_light_artillery_barrage_ger')" ),
										newelement("Unlock Light Artillery Barrage Extended", "",    "GivePlayerUpgrade('c_mechanized_light_artillery_barrage_extended_ger')" ),
										newelement("Unlock Self Repair", "",    "GivePlayerUpgrade('c_mechanized_self_repair_ger')" ),
										newelement("Unlock Smoke Canisters", "",    "GivePlayerUpgrade('c_mechanized_smoke_canisters_ger')" ),
										newelement("Unlock Stug Assault Group", "",    "GivePlayerUpgrade('c_mechanized_stug_assault_group_ger')" ),
									},
								},
								{
									name = "Passive Abilities",
									type = SubMenu,
									SubMenuItems = 
									{
										newelement("Unlock Increased Fuel Rate", "",    "GivePlayerUpgrade('c_common_increased_fuel_rate_ger')" ),
										newelement("Unlock Increased Muni Rate", "",    "GivePlayerUpgrade('c_common_increased_muni_rate_ger')" ),
										newelement("Unlock Infantry Reserves", "",    "GivePlayerUpgrade('c_common_infantry_reserves_ger')" ),
										newelement("Unlock Infantry Upkeep Reduction", "",    "GivePlayerUpgrade('c_common_infantry_upkeep_reduction_ger')" ),
										newelement("Unlock Raid", "",    "GivePlayerUpgrade('c_mechanized_raid_ger')" ),
										newelement("NOT FUNCTIONAL Unlock Tank Riders", "",    "GivePlayerUpgrade('')" ),
										newelement("NOT FUNCTIONAL Unlock Towed Assets", "",    "GivePlayerUpgrade('')" ),
										newelement("Unlock Vehicle Upkeep Reduction", "",    "GivePlayerUpgrade('c_common_vehicle_upkeep_reduction_ger')" ),
									},
								},
								{
									name = "Unit Unlocks",
									type = SubMenu,
									SubMenuItems =
									{
										
									},
								},
								newelement("Unlock All Active Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_active_abilities_mechanized_ger')" ),
								newelement("Unlock All Passive Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_passive_abilities_mechanized_ger')" ),
								newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_mechanized_company_upgrades_ger')" ),
							},
						},
						{
							name = "German Panzer",
							type = SubMenu,
							SubMenuItems = 
							{
								{
									name = "Active Abilities",
									type = SubMenu,
									SubMenuItems =
									{
										newelement("Unlock Blitzkrieg", "",    "GivePlayerUpgrade('c_panzer_blitzkrieg_ger')" ),
										newelement("Unlock Breathrough Tactics", "",    "GivePlayerUpgrade('c_panzer_breakthrough_ger')" ),
										newelement("Unlock Incendiary Bombing Run", "",    "GivePlayerUpgrade('c_panzer_incendiary_bombing_run_ger')" ),
										newelement("Unlock Incendiary Bombing Run Extended", "",    "GivePlayerUpgrade('c_panzer_incendiary_bombing_run_extended_ger')" ),
										newelement("Unlock Logistics Truck", "",    "GivePlayerUpgrade('c_panzer_logistics_truck_ger')" ),
										newelement("Unlock Rocket Strafe", "",    "GivePlayerUpgrade('c_panzer_rocket_strafe_ger')" ),
										newelement("Unlock Smoke Bombing Run", "",    "GivePlayerUpgrade('c_panzer_smoke_bombing_run_ger')" ),
									},
								},
								{
									name = "Passive Abilities",
									type = SubMenu,
									SubMenuItems = 
									{
										newelement("Unlock Assault Grenadiers", "",    "GivePlayerUpgrade('c_panzer_assault_grenadiers_ger')" ),
										newelement("Unlock Increased Fuel Rate", "",    "GivePlayerUpgrade('c_common_increased_fuel_rate_ger')" ),
										newelement("Unlock Increased Muni Rate", "",    "GivePlayerUpgrade('c_common_increased_muni_rate_ger')" ),
										newelement("NOT FUNCTIONAL Unlock Operate Under Pressure", "",    "GivePlayerUpgrade('c_panzer_operate_under_pressure_ger')" ),
										newelement("Unlock Vehicle Cost Reduction", "",    "GivePlayerUpgrade('c_panzer_vehicle_cost_reduction_ger')" ),
										newelement("Unlock Veteran Vehicles", "",    "GivePlayerUpgrade('c_panzer_veteran_vehicles_ger')" ),
									},
								},
								{
									name = "Unit Unlocks",
									type = SubMenu,
									SubMenuItems =
									{
										
									},
								},
								newelement("Unlock All Active Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_active_abilities_panzer_ger')" ),
								newelement("Unlock All Passive Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_passive_abilities_panzer_ger')" ),
								newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_panzer_company_upgrades_ger')" ),
							},
						},
					},
				},
				--- British Air And Sea Company ---
				{
					name = "British Air and Sea",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Centaur", "",    "GivePlayerUpgrade('c_air_and_sea_centaur_core_uk')" ),
								newelement("Unlock Commandos", "",    "GivePlayerUpgrade('c_air_and_sea_commandos_core_uk')" ),
								newelement("Unlock CWT towing truck", "",    "GivePlayerUpgrade('c_air_and_sea_cwt_towing_truck_core_uk')" ),
								newelement("Unlock Strafing Run", "",    "GivePlayerUpgrade('c_air_and_sea_strafing_run_core_uk')" ),
								newelement("Unlock Naval Bombardment", "",    "GivePlayerUpgrade('c_air_and_sea_naval_bombardment_core_uk')" ),
								newelement("Unlock Incendiary Bombing Run", "",    "GivePlayerUpgrade('c_air_and_sea_incendiary_bombing_run_core_uk')" ),
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("Unlock Veteran Crews", "",    "GivePlayerUpgrade('c_air_and_sea_veteran_crews_uk')" ),
								newelement("Unlock Naval Shipment", "",    "GivePlayerUpgrade('c_air_and_sea_naval_shipment_uk')" ),
								newelement("Unlock Rapid Deployment", "",    "GivePlayerUpgrade('c_air_and_sea_rapid_deployment_uk')" ),
								newelement("Unlock Naval Defense", "",    "GivePlayerUpgrade('c_air_and_sea_naval_defense_uk')" ),
								newelement("Unlock Open Coastal Lines", "",    "GivePlayerUpgrade('c_air_and_sea_open_coastal_lines_uk')" ),
								newelement("Unlock Special Ops Commandos", "",    "GivePlayerUpgrade('c_air_and_sea_special_ops_commandos_uk')" ),
								newelement("Unlock Veteran Commandos", "",    "GivePlayerUpgrade('c_air_and_sea_veteran_commandos_uk')" ),
								newelement("Unlock Paradropped reinforcements", "",    "GivePlayerUpgrade('c_air_and_sea_paradropped_reinforcements_uk')" ),
								newelement("Unlock Weapon Supplies", "",    "GivePlayerUpgrade('c_air_and_sea_weapon_supplies_uk')" ),
								newelement("Unlock Faster refuel", "",    "GivePlayerUpgrade('c_air_and_sea_faster_refuel_uk')" ),
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Commandos munition drop", "",    "GivePlayerUpgrade('c_air_and_sea_commandos_munition_drop_uk')" ),
								newelement("Unlock Commandos pack howietzer drop", "",    "GivePlayerUpgrade('c_air_and_sea_commandos_pack_howietzer_drop_uk')" ),
								newelement("Unlock Centaur with Tommy", "",    "GivePlayerUpgrade('c_air_and_sea_centaur_tommy_uk')" ),
								newelement("Unlock Centaur with Sapper", "",    "GivePlayerUpgrade('c_air_and_sea_centaur_sapper_uk')" ),
								newelement("Unlock CWT truck 17 pounder", "",    "GivePlayerUpgrade('c_air_and_sea_cwt_towing_truck_17pdr_uk')" ),
								newelement("Unlock CWT truck guard escort", "",    "GivePlayerUpgrade('c_air_and_sea_cwt_towing_truck_guard_uk')" ),
								newelement("Unlock AI Loiter", "",    "GivePlayerUpgrade('c_air_and_sea_strafing_run_ai_loiter_uk')" ),
								newelement("Unlock AT Loiter", "",    "GivePlayerUpgrade('c_air_and_sea_strafing_run_at_loiter_uk')" ),
								newelement("Unlock Naval Bombardment Concentrated Barrage", "",    "GivePlayerUpgrade('c_air_and_sea_naval_bombardment_concentrated_barrage_uk')" ),
								newelement("Unlock Naval Bombardment Lasting Barrage", "",    "GivePlayerUpgrade('c_air_and_sea_naval_bombardment_more_shells_uk')" ),
								newelement("Unlock Bombing run", "",    "GivePlayerUpgrade('c_air_and_sea_bombing_run_bomb_uk')" ),
								newelement("Unlock Mine bombing run", "",    "GivePlayerUpgrade('c_air_and_sea_bombing_run_mines_uk')" ),
							},
						},
					
						newelement("Unlock All Core Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_core_air_and_sea_abilities_uk')" ),
						newelement("Unlock All Passive Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_passive_air_and_sea_abilities_uk')" ),
						newelement("Unlock All Specialization Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_specialization_air_and_sea_abilities_uk')" ),
						newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_air_and_sea_company_upgrades_uk')" ),
					},
				},
				--- British Armored Company ---
				{
					name = "British Armored",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Fuel Drop", "",    "GivePlayerUpgrade('c_armored_fuel_drop_core_uk')" ),
								newelement("Unlock Churchill", "",    "GivePlayerUpgrade('c_armored_churchill_core_uk')" ),
								newelement("Unlock Churchill Black Prince", "",    "GivePlayerUpgrade('c_armored_black_prince_core_uk')" ),
								newelement("Unlock Crusader AA", "",    "GivePlayerUpgrade('c_armored_crusader_aa_core_uk')" ),
								newelement("Unlock Designate Targets", "",    "GivePlayerUpgrade('c_armored_designate_targets_core_uk')" ),
								newelement("Unlock Recon Artillery", "",    "GivePlayerUpgrade('c_armored_recon_artillery_core_uk')" ),
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("Unlock Bolster Sappers", "",    "GivePlayerUpgrade('c_armored_bolster_sappers_passive_uk')" ),
								newelement("Unlock Cheaper Sappers", "",    "GivePlayerUpgrade('c_armored_cheaper_sappers_passive_uk')" ),
								newelement("Unlock Critical Repair", "",    "GivePlayerUpgrade('c_armored_critical_self_repair_passive_uk')" ),
								newelement("Unlock Field Recovery", "",    "GivePlayerUpgrade('c_armored_field_recovery_passive_uk')" ),
								newelement("Unlock Forward Repair", "",    "GivePlayerUpgrade('c_armored_forward_repair_passive_uk')" ),
								newelement("Unlock Combat Support", "",    "GivePlayerUpgrade('c_armored_combat_support_passive_uk')" ),
								newelement("Unlock Prioritize Fuel", "",    "GivePlayerUpgrade('c_armored_priority_fuel_passive_uk')" ),
								newelement("Unlock Air Support", "",    	"GivePlayerUpgrade('c_armored_air_support_passive_uk')" ),
								newelement("Unlock Vehicle Logistics", "",    "GivePlayerUpgrade('c_armored_vehicle_logistics_passive_uk')" ),
								newelement("Unlock Vehicle Training", "",    "GivePlayerUpgrade('c_armored_vehicle_training_passive_uk')" ),
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Churchill Black Prince Cost Reduction", "",    "GivePlayerUpgrade('c_armored_black_prince_cost_reduction_uk')" ),
								newelement("Unlock Churchill Black Prince Support Squad", "",    "GivePlayerUpgrade('c_armored_black_prince_support_squad_uk')" ),
								newelement("Unlock Churchill Command Tank", "",    "GivePlayerUpgrade('c_armored_churchill_command_tank_uk')" ),
								newelement("Unlock Churchill 75mm", "",    "GivePlayerUpgrade('c_armored_churchill_75mm_uk')" ),
								newelement("Unlock Crusader AA Cost Reduction", "",    "GivePlayerUpgrade('c_armored_crusader_aa_cost_reduction_uk')" ),
								newelement("Unlock Crusader AA Suppression", "",    "GivePlayerUpgrade('c_armored_crusader_aa_suppression_uk')" ),
								newelement("Unlock Designate Targets Extended Duration", "",    "GivePlayerUpgrade('c_armored_designate_targets_extended_duration_uk')" ),
								newelement("Unlock Designate Targets Extended Sight", "",    "GivePlayerUpgrade('c_armored_designate_targets_extended_sight_uk')" ),
								newelement("Unlock Fuel Drop Extra Munitions", "",    "GivePlayerUpgrade('c_armored_fuel_drop_add_munitions_uk')" ),
								newelement("Unlock Fuel Drop Extra Crate", "",    "GivePlayerUpgrade('c_armored_fuel_drop_extra_crate_uk')" ),
								newelement("Unlock Recon Artillery Cost Reduction", "",    "GivePlayerUpgrade('c_armored_recon_artillery_cost_reduction_uk')" ),
								newelement("Unlock Recon Artillery Incendiary Shells", "",    "GivePlayerUpgrade('c_armored_recon_artillery_incendiary_uk')" ),
							},
						},
						newelement("Unlock All Core Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_core_armored_abilities_uk')" ),
						newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_armored_company_upgrades_uk')" ),
					},
				},
				--- British Indian Artillery Company ---
				{
					name = "British Indian Artillery",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Gurkhas", "",    "GivePlayerUpgrade('c_artillery_gurkhas_core_uk')" ),
								newelement("Unlock Heavy Mortar", "",    "GivePlayerUpgrade('c_artillery_heavy_mortar_core_uk')" ),
								newelement("Unlock War Cry", "",    "GivePlayerUpgrade('c_artillery_war_cry_core_uk')" ),
								newelement("Unlock BL 5.5", "",    "GivePlayerUpgrade('c_artillery_bl_heavy_artillery_core_uk')" ),
								newelement("Unlock Command Valentine", "",    "GivePlayerUpgrade('c_artillery_valentine_core_uk')" ),
								newelement("Unlock Airburst Barrage", "",    "GivePlayerUpgrade('c_artillery_airburst_core_uk')" ),
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("Unlock Bravery", "",    "GivePlayerUpgrade('c_artillery_bravery_passive_uk')" ),
								newelement("Unlock Forward Observers", "",    "GivePlayerUpgrade('c_artillery_forward_observers_passive_uk')" ),
								newelement("Unlock Pillage", "",    "GivePlayerUpgrade('c_artillery_pillage_passive_uk')" ),
								newelement("Unlock Creeping Smoke", "",    "GivePlayerUpgrade('c_artillery_creeping_smoke_passive_uk')" ),
								newelement("Unlock First Class Fighting", "",    "GivePlayerUpgrade('c_artillery_first_class_passive_uk')" ),
								newelement("Unlock Artillery Saturation", "",    "GivePlayerUpgrade('c_artillery_saturation_passive_uk')" ),
								newelement("Unlock Bolster Gurkhas", "",    "GivePlayerUpgrade('c_artillery_gurkhas_bolster_passive_uk')" ),
								newelement("Unlock Zero In", "",    "GivePlayerUpgrade('c_artillery_zero_in_passive_uk')" ),
								newelement("Unlock Fearless Assault", "",    "GivePlayerUpgrade('c_artillery_fearless_assault_passive_uk')" ),
								newelement("Unlock Artillery Cost Reduction", "",    "GivePlayerUpgrade('c_artillery_artillery_cost_passive_uk')" ),
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Gurkhas Forward Observer", "",    "GivePlayerUpgrade('c_artillery_gurkhas_forward_observers_uk')" ),
								newelement("Unlock Gurkhas Battle-Hardened", "",    "GivePlayerUpgrade('c_artillery_gurkhas_battle_hardened_uk')" ),
								newelement("Unlock Airburst Smoke", "",    "GivePlayerUpgrade('c_artillery_airburst_smoke_uk')" ),
								newelement("Unlock Airburst Mixed Rounds", "",    "GivePlayerUpgrade('c_artillery_airburst_mixed_uk')" ),
								newelement("Unlock War Cry Smoke", "",    "GivePlayerUpgrade('c_artillery_war_cry_smoke_uk')" ),
								newelement("Unlock War Cry Artillery Flares", "",    "GivePlayerUpgrade('c_artillery_war_cry_artillery_flares_uk')" ),
								newelement("Unlock BL 5.5 Auto-Fire", "",    "GivePlayerUpgrade('c_artillery_bl_heavy_artillery_auto_fire_uk')" ),
								newelement("Unlock BL 5.5 Quick Fire", "",    "GivePlayerUpgrade('c_artillery_bl_heavy_artillery_quick_fire_uk')" ),
								newelement("Unlock Heavy Mortar Incendiary", "",    "GivePlayerUpgrade('c_artillery_heavy_mortar_incendiary_uk')" ),
								newelement("Unlock Heavy Mortar Bolster", "",    "GivePlayerUpgrade('c_artillery_heavy_mortar_bolster_uk')" ),
								newelement("Unlock Valentine Vet Commander", "",    "GivePlayerUpgrade('c_artillery_valentine_veteran_commander_uk')" ),
								newelement("Unlock Valentine Armoured Commander", "",    "GivePlayerUpgrade('c_artillery_valentine_armoured_commander_uk')" ),
							},
						},
					
						newelement("Unlock All Core Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_core_artillery_abilities_uk')" ),
						newelement("Unlock All Passive Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_passive_artillery_abilities_uk')" ),
						newelement("Unlock All Specialization Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_specialization_artillery_abilities_uk')" ),
						newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_artillery_company_upgrades_uk')" ),
					},
				},
				
				
				------------------------- AMERICAN COMPANIES -------------------------
				--- Airborne Company ---
				{
					name = "American Airborne",
					type = SubMenu,
					SubMenuItems =
					{
						newelement("Unlock Airborne Company Upgrade", "",    "GivePlayerUpgrade('airborne_company_us')" ),
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock HMG Paradrop", "",    "GivePlayerUpgrade('c_airborne_weapon_paradrop_core_us')" ),
								newelement("Unlock Smoke Run", "",    "GivePlayerUpgrade('c_airborne_smoke_run_core_us')" ),
								newelement("Unlock Paratroopers", "",    "GivePlayerUpgrade('c_airborne_paratroopers_core_us')" ),
								newelement("Unlock Rocket Strike", "",    "GivePlayerUpgrade('c_airborne_p47_rocket_core_us')" ),
								newelement("Unlock Air Dropped Reinforcements", "",    "GivePlayerUpgrade('c_airborne_air_dropped_reinforcements_core_us')" ),
								newelement("Unlock Carpet Bomb", "",    "GivePlayerUpgrade('c_airborne_carpet_bomb_core_us')" ),
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Paratroopers - Loiter Support", "",    "GivePlayerUpgrade('c_airborne_paratroopers_loiter_support_us')" ),
								newelement("Unlock Paratroopers - Vet 1", "",    "GivePlayerUpgrade('c_airborne_paratroopers_vet1_us')" ),
								newelement("Unlock Smoke Run - Cost Reduction", "",    "GivePlayerUpgrade('c_airborne_smoke_run_cost_reduction_us')" ),
								newelement("Unlock Smoke Run - White Phosphorus", "",    "GivePlayerUpgrade('c_airborne_smoke_run_damage_us')" ),
								newelement("Unlock Weapon Paradrop - AT Gun", "",    "GivePlayerUpgrade('c_airborne_weapon_paradrop_at_us')" ),
								newelement("Unlock Weapon Paradrop - Supplies", "",    "GivePlayerUpgrade('c_airborne_weapon_paradrop_supplies_us')" ),
								newelement("Unlock P47 Rocket Strike - More Missiles", "",    "GivePlayerUpgrade('c_airborne_p47_rocket_strike_more_missiles_us')" ),
								newelement("Unlock P47 Rocket Strike - Loiter", "",    "GivePlayerUpgrade('c_airborne_p47_rocket_strike_loiter_us')" ),
								newelement("Unlock Air Dropped Reinforcements - Cheaper", "",    "GivePlayerUpgrade('c_airborne_air_dropped_reinforcements_cost_reduction_us')" ),
								newelement("Unlock Air Dropped Reinforcements - Loiter", "",    "GivePlayerUpgrade('c_airborne_air_dropped_reinforcements_loiter_us')" ),
								newelement("Unlock Carpet Bomb - More Planes", "",    "GivePlayerUpgrade('c_airborne_carpet_bomb_more_planes_us')" ),
								newelement("Unlock Carpet Bomb - Cost Reduction", "",    "GivePlayerUpgrade('c_airborne_carpet_bomb_cost_reduction_us')" ),
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("Unlock Top - Take And Hold", "",    "GivePlayerUpgrade('c_airborne_take_and_hold_passive_us')" ),
								newelement("Unlock Top - Resource Recovery", "",    "GivePlayerUpgrade('c_airborne_paratroopers_pathfinders_pillage_passive_us')" ),
								newelement("Unlock Top - Tools Of The Trade", "",    "GivePlayerUpgrade('c_airborne_tools_of_the_trade_passive_us')" ),
								newelement("Unlock Top - Airborne Rally", "",    "GivePlayerUpgrade('c_airborne_rally_passive_us')" ),
								newelement("Unlock Top - Behind Enemy Lines", "",    "GivePlayerUpgrade('c_airborne_behind_enemy_lines_passive_us')" ),
								newelement("Unlock Mid - ASC Upgrade I", "",    "GivePlayerUpgrade('c_airborne_asc_1_passive_us')" ),
								newelement("Unlock Mid - Starting Cache", "",    "GivePlayerUpgrade('c_airborne_starting_cache_passive_us')" ),
								newelement("Unlock Mid - Expert Foundations", "",    "GivePlayerUpgrade('c_airborne_expert_foundation_passive_us')" ),
								newelement("Unlock Mid - ASC Upgrade II", "",    "GivePlayerUpgrade('c_airborne_asc_2_passive_us')" ),
								newelement("Unlock Mid - Munitions Flow", "",    "GivePlayerUpgrade('c_airborne_munitions_flow_passive_us')" ),
							},
						},
						{
							name = "Unit Unlocks",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("HQ - Unlock Captain", "",    "GivePlayerUpgrade('c_airborne_captain_unlock_us')" ),
								newelement("Barracks - Unlock 4x4 Truck", "",    "GivePlayerUpgrade('c_airborne_truck_4x4_unlock_us')" ),
								newelement("Motor Pool - Unlock AT-Gun", "",    "GivePlayerUpgrade('c_airborne_atgun_unlock_us')" ),
								newelement("Motor Pool - Unlock Chaffee", "",    "GivePlayerUpgrade('c_airborne_chaffee_unlock_us')" ),
								newelement("Tank Depot - Unlock Sherman", "",    "GivePlayerUpgrade('c_airborne_sherman_unlock_us')" ),
								newelement("Tank Depot - Unlock Hellcat", "",    "GivePlayerUpgrade('c_airborne_hellcat_unlock_us')" ),
								newelement("Tank Depot - Unlock Sherman 105mm", "",    "GivePlayerUpgrade('c_airborne_sherman_bulldozer_unlock_us')" ),
							},
						},
					
						newelement("Unlock All Core Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_core_abilities_airborne_us')" ),
						newelement("Unlock All Passive Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_passives_abilities_airborne_us')" ),
						newelement("Unlock All Specialization Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_specialization_abilities_airborne_us')" ),
						newelement("Unlock All Unit Unlock Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_unit_unlock_upgrades_airborne_us')" ),
						newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_airborne_company_upgrades_us')" ),
					},
				},
				-- Armoured Company ---
				{
					name = "American Armoured",
					type = SubMenu,
					SubMenuItems =
					{
						newelement("Unlock Armoured Company Upgrade", "",    "GivePlayerUpgrade('c_armoured_company_us')" ),
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Stuart", "",    "GivePlayerUpgrade('c_armoured_stuart_core_us')" ),
								newelement("Unlock M8 Scott", "",    "GivePlayerUpgrade('c_armoured_scott_core_us')" ),
								newelement("Unlock Recovery Vehicle", "",    "GivePlayerUpgrade('c_armoured_recovery_vehicle_core_us')" ),
								newelement("Unlock Seek and Destroy", "",    "GivePlayerUpgrade('c_armoured_seek_and_destroy_core_us')" ),
								newelement("Unlock Easy 8 Task Force", "",    "GivePlayerUpgrade('c_armoured_easy_8_core_us')" ),
								newelement("Unlock 240mm Artillery", "",    "GivePlayerUpgrade('c_armoured_240mm_artillery_core_us')" ),
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Stuart - Vet 1", "",    "GivePlayerUpgrade('c_armoured_stuart_vet_1_us')" ),
								newelement("Unlock Stuart - Cost Reduction", "",    "GivePlayerUpgrade('c_armoured_stuart_cost_reduction_us')" ),
								newelement("Unlock M8 Scott - Recon Group", "",    "GivePlayerUpgrade('c_armoured_scott_recon_group_us')" ),
								newelement("Unlock M8 Scott - Heat Rounds", "",    "GivePlayerUpgrade('c_armoured_scott_heat_rounds_us')" ),
								newelement("Unlock Recovery Vehicle - Cost Reduction", "",    "GivePlayerUpgrade('c_armoured_recovery_vehicle_cost_reduction_us')" ),
								newelement("Unlock Recovery Vehicle - Self-repair", "",    "GivePlayerUpgrade('c_armoured_recovery_vehicle_self_repair_us')" ),
								newelement("Unlock Seek and Destroy - Protection", "",    "GivePlayerUpgrade('c_armoured_seek_and_destroy_protection_us')" ),
								newelement("Unlock Seek and Destroy - Recon", "",    "GivePlayerUpgrade('c_armoured_seek_and_destroy_recon_us')" ),
								newelement("Unlock Easy 8 Task Force - Ace", "",    "GivePlayerUpgrade('c_armoured_easy_8_ace_us')" ),
								newelement("Unlock Easy 8 Task Force - Doubles", "",    "GivePlayerUpgrade('c_armoured_easy_8_doubles_us')" ),
								newelement("Unlock 240mm Artillery - Quick Deploy", "",    "GivePlayerUpgrade('c_armoured_240mm_artillery_precision_us')" ),
								newelement("Unlock 240mm Artillery - Creeping", "",    "GivePlayerUpgrade('c_armoured_240mm_artillery_extra_us')" ),
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("Top - Unlock Flamethrowers Requisition", "",    "GivePlayerUpgrade('c_armoured_flamethrower_requisition_passive_us')" ),
								newelement("Top - Unlock Bonus Supplies", "",    "GivePlayerUpgrade('c_armoured_bonus_supplies_passive_us')" ),
								newelement("Top - Unlock Increased Fuel Rate", "",    "GivePlayerUpgrade('c_armoured_increased_fuel_rate_passive_us')" ),
								newelement("Top - Unlock Improved Assault Package", "",    "GivePlayerUpgrade('c_armoured_improved_assault_package_passive_us')" ),
								newelement("Top - Unlock American War Machine", "",    "GivePlayerUpgrade('c_armoured_american_war_machine_passive_us')" ),
								newelement("Middle - Unlock Rudimentary Repairs", "",    "GivePlayerUpgrade('c_armoured_rudimentary_repairs_passive_us')" ),
								newelement("Middle - Unlock Improved Radio Net", "",    "GivePlayerUpgrade('c_armoured_improved_radio_net_passive_us')" ),
								newelement("Middle - Unlock Light Vehicle Resiliency", "",    "GivePlayerUpgrade('c_armoured_light_vehicle_resiliency_passive_us')" ),
								newelement("Middle - Unlock Skilled Gunners", "",    "GivePlayerUpgrade('c_armoured_skilled_gunners_passive_us')" ),
								newelement("Middle - Unlock APHV Rounds", "",    "GivePlayerUpgrade('c_armoured_penetration_rounds_passive_us')" ),
							},
						},
						{
							name = "Unit Unlocks",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("HQ - Unlock Scouts", "",    "GivePlayerUpgrade('c_armoured_scout_unlock_us')" ),
								newelement("HQ - Unlock Captain", "",    "GivePlayerUpgrade('c_armoured_captain_unlock_us')" ),
								newelement("Barracks - Unlock Mortar", "",    "GivePlayerUpgrade('c_armoured_mortar_unlock_us')" ),
								newelement("WSC - Unlock Sniper", "",    "GivePlayerUpgrade('c_armoured_sniper_unlock_us')" ),
								newelement("Motor Pool - Unlock AT Gun", "",    "GivePlayerUpgrade('c_armoured_atgun_unlock_us')" ),
								newelement("Tank Depot - Unlock Sherman 105mm", "",    "GivePlayerUpgrade('c_armoured_sherman_bulldozer_unlock_us')" ),
							},
						},
					
						newelement("Unlock All Core Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_core_abilities_armoured_us')" ),
						newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_armoured_company_upgrades_us')" ),
					},
				},
				--- Infantry Company ---
				{
					name = "American Infantry",
					type = SubMenu,
					SubMenuItems =
					{
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Rangers", "",    "GivePlayerUpgrade('c_infantry_rangers_core_us')" ),
								newelement("Unlock 155mm Off Map Artillery", "",    "GivePlayerUpgrade('c_infantry_155mm_artillery_core_us')" ),
								newelement("Unlock Requisition Manpower", "",    "GivePlayerUpgrade('c_infantry_requisition_manpower_core_us')" ),
								newelement("Unlock Deploy Combat Group", "",    "GivePlayerUpgrade('c_infantry_deploy_combat_group_core_us')" ),
								newelement("Unlock 105mm Howitzer", "",    "GivePlayerUpgrade('c_infantry_105mm_howitzer_core_us')" ),
								newelement("Unlock 240mm Off Map Artillery", "",    "GivePlayerUpgrade('c_infantry_240mm_artillery_core_us')" ),
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Rangers - Recon Training", "",    "GivePlayerUpgrade('c_infantry_rangers_recon_training_us')" ),
								newelement("Unlock Rangers - Cost Reduction", "",    "GivePlayerUpgrade('c_infantry_rangers_cost_reduction_us')" ),
								newelement("Unlock 155mm Off Map Artillery - Quick Response", "",    "GivePlayerUpgrade('c_infantry_155mm_artillery_quick_response_us')" ),
								newelement("Unlock 155mm Off Map Artillery - Increased Radius", "",    "GivePlayerUpgrade('c_infantry_155mm_artillery_increased_radius_us')" ),
								newelement("Unlock Requisition Manpower - Additional Support", "",    "GivePlayerUpgrade('c_infantry_requisition_manpower_additional_support_us')" ),
								newelement("Unlock Requisition Manpower - Medical Aid", "",    "GivePlayerUpgrade('c_infantry_requisition_manpower_medical_aid_us')" ),
								newelement("Unlock Deploy Combat Group - Heavy", "",    "GivePlayerUpgrade('c_infantry_deploy_combat_group_heavy_us')" ),
								newelement("Unlock Deploy Combat Group - Charge", "",    "GivePlayerUpgrade('c_infantry_deploy_combat_group_charge_us')" ),
								newelement("Unlock 105mm Howitzer - Zero In", "",    "GivePlayerUpgrade('c_infantry_105mm_howitzer_zero_in_us')" ),
								newelement("Unlock 105mm Howitzer - Cost Reduction", "",    "GivePlayerUpgrade('c_infantry_105mm_howitzer_cost_reduction_us')" ),
								newelement("Unlock 240mm Off Map Artillery - Barrage Stun", "",    "GivePlayerUpgrade('c_infantry_240mm_artillery_barrage_stun_us')" ),
								newelement("Unlock 240mm Off Map Artillery - Tighter Concentration", "",    "GivePlayerUpgrade('c_infantry_240mm_artillery_tighter_concentration_us')" ),
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("Unlock Increased Scout Squad Size", "",    "GivePlayerUpgrade('c_infantry_scout_squad_size_passive_us')" ),
								newelement("Unlock Mortar Pit", "",    "GivePlayerUpgrade('c_infantry_mortar_pit_passive_us')" ),
								newelement("Unlock Rapid Vet", "",    "GivePlayerUpgrade('c_infantry_rapid_vet_passive_us')" ),
								newelement("Unlock Pin Point Artillery", "",    "GivePlayerUpgrade('c_infantry_pin_point_artillery_passive_us')" ),
								newelement("Unlock Infantry Cost Reduction", "",    "GivePlayerUpgrade('c_infantry_infantry_cost_reduction_us')" ),
								newelement("Unlock Off Map Cost Reduction", "",    "GivePlayerUpgrade('c_infantry_off_map_cost_reduction_passive_us')" ),
								newelement("Unlock Starting Bars", "",    "GivePlayerUpgrade('c_infantry_starting_bars_passive_us')" ),
								newelement("Unlock Extra Rounds", "",    "GivePlayerUpgrade('c_infantry_extra_rounds_passive_us')" ),
								newelement("Unlock Captain On Deck", "",    "GivePlayerUpgrade('c_infantry_captain_on_deck_passive_us')" ),
								newelement("Unlock Increased Penetration", "",    "GivePlayerUpgrade('c_infantry_increased_penetration_passive_us')" ),
								newelement("Bottom - Unlock Reduced Reinforce Cost", "",    "GivePlayerUpgrade('c_american_generic_reinforce_cost_passive_us')" ),
								newelement("Bottom - Unlock BARs", "",    "GivePlayerUpgrade('c_american_generic_bars_unlocked_passive_us')" ),
								newelement("Bottom - Unlock Increased Munitions", "",    "GivePlayerUpgrade('c_american_generic_increase_munitions_rate_passive_us')" ),
							},
						},
						{
							name = "Unit Unlocks",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("Unlock ??", "",    "GivePlayerUpgrade('')" ),
								newelement("Unlock ??", "",    "GivePlayerUpgrade('')" ),
								newelement("Unlock ??", "",    "GivePlayerUpgrade('')" ),
								newelement("Unlock ??", "",    "GivePlayerUpgrade('')" ),
							},
						},
					
						newelement("Unlock All Infantry Core Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_core_abilities_infantry_us')" ),
						newelement("Unlock All Infantry Passive Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_passives_abilities_infantry_us')" ),
						newelement("Unlock All Infantry Specialization Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_specialization_abilities_infantry_us')" ),
						newelement("Unlock All Infantry Unit Unlock Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_unit_unlock_upgrades_infantry_us')" ),
						newelement("Remove All Infantry Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_infantry_company_upgrades_us')" ),
					},
				},
				--- Special Operations Company ---
				{
					name = "American Special Operations",
					type = SubMenu,
					SubMenuItems =
					{
						newelement("Unlock Special Operations Company Upgrade", "",    "GivePlayerUpgrade('c_special_operations_company_us')" ),
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock SSF Commandos", "",    "GivePlayerUpgrade('c_special_operations_devils_brigade_core_us')" ),
								newelement("Unlock Weasel", "",    "GivePlayerUpgrade('c_special_operations_weasel_core_us')" ),
								newelement("Unlock Quad Halftrack", "",    "GivePlayerUpgrade('c_special_operations_quad_halftrack_core_us')" ),
								newelement("Unlock Raiding Flares", "",    "GivePlayerUpgrade('c_special_operations_raiding_flares_core_us')" ),
								newelement("Unlock White Phosphorus Barrage", "",    "GivePlayerUpgrade('c_special_operations_white_phosphorus_barrage_core_us')" ),
								newelement("Unlock Whizbang", "",    "GivePlayerUpgrade('c_special_operations_whizbang_core_us')" ),
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Weasel - AT Gun", "",    "GivePlayerUpgrade('c_special_operations_weasel_at_gun_us')" ),
								newelement("Unlock Weasel - Urban Assault", "",    "GivePlayerUpgrade('c_special_operations_weasel_pcg_flamer_us')" ),
								newelement("Unlock Quad Halftrack - Doubled", "",    "GivePlayerUpgrade('c_special_operations_quad_halftrack_x2_us')" ),
								newelement("Unlock Quad Halftrack - Sherman Support", "",    "GivePlayerUpgrade('c_special_operations_quad_halftrack_105mm_sherman_us')" ),
								newelement("Unlock Whizbang - Flare Wall", "",    "GivePlayerUpgrade('c_special_operations_whizbang_flares_us')" ),
								newelement("Unlock Whizbang - Smoke Wall", "",    "GivePlayerUpgrade('c_special_operations_whizbang_smoke_canisters_us')" ),
								newelement("Unlock SSF Commandos - Hidden Devils", "",    "GivePlayerUpgrade('c_special_operations_devils_brigade_hidden_devils_us')" ),
								newelement("Unlock SSF Commandos - Cost Reduction", "",    "GivePlayerUpgrade('c_special_operations_devils_brigade_cost_reduction_us')" ),
								newelement("Unlock Raiding Flares - Extended Barrage", "",    "GivePlayerUpgrade('c_special_operations_raiding_flares_extended_barrage_us')" ),
								newelement("Unlock Raiding Flares - Rocket Barrage", "",    "GivePlayerUpgrade('c_special_operations_raiding_flares_rocket_barrage_us')" ),
								newelement("Unlock White Phosphorus Barrage - Cost Reduction", "",    "GivePlayerUpgrade('c_special_operations_white_phosphorus_barrage_cost_reduction_us')" ),
								newelement("Unlock White Phosphorus Barrage - Wall Salvo", "",    "GivePlayerUpgrade('c_special_operations_white_phosphorus_barrage_wall_us')" ),
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
								newelement("Unlock Top - Munitions Boost", "",    "GivePlayerUpgrade('c_special_operations_munitions_boost_passive_us')" ),
								newelement("Unlock Top - Buff SSF", "",    "GivePlayerUpgrade('c_special_operations_ssf_buff_passive_us')" ),
								newelement("Unlock Top - Self Heal", "",    "GivePlayerUpgrade('c_special_operations_self_heal_passive_us')" ),
								newelement("Unlock Top - Supply Raid", "",    "GivePlayerUpgrade('c_special_operations_supply_raid_passive_us')" ),
								newelement("Unlock Top - Marksmen", "",    "GivePlayerUpgrade('c_special_operations_marksmen_passive_us')" ),
								newelement("Unlock Mid - Rigorous Training", "",    "GivePlayerUpgrade('c_special_operations_rigorous_training_passive_us')" ),
								newelement("Unlock Mid - Special Arms", "",    "GivePlayerUpgrade('c_special_operations_special_arms_passive_us')" ),
								newelement("Unlock Mid - Surprise Strike", "",    "GivePlayerUpgrade('c_special_operations_surprise_strike_passive_us')" ),
								newelement("Unlock Mid - The Best Offense", "",    "GivePlayerUpgrade('c_special_operations_the_best_offense_passive_us')" ),
								newelement("Unlock Mid - Well Researched", "",    "GivePlayerUpgrade('c_special_operations_well_researched_passive_us')" ),
							},
						},
						{
						name = "Unit Unlocks",
						type = SubMenu,
						SubMenuItems =
							{
								newelement("Barracks - Unlock 4x4 Truck", "",    "GivePlayerUpgrade('c_special_operations_truck_4x4_unlock_us')" ),
								newelement("Barracks - Unlock Mortar", "",    "GivePlayerUpgrade('c_special_operations_mortar_unlock_us')" ),
								newelement("WSC - Unlock Bazooka Team", "",    "GivePlayerUpgrade('c_special_operations_bazooka_unlock_us')" ),
								newelement("WSC - Unlock Sniper", "",    "GivePlayerUpgrade('c_special_operations_sniper_unlock_us')" ),
								newelement("Motor Pool - Unlock Greyhound", "",    "GivePlayerUpgrade('c_special_operations_greyhound_unlock_us')" ),
								newelement("Tank Depot - Unlock Sherman", "",    "GivePlayerUpgrade('c_special_operations_sherman_unlock_us')" ),
								newelement("Tank Depot - Unlock Hellcat", "",    "GivePlayerUpgrade('c_special_operations_hellcat_unlock_us')" ),
							},
						},
						newelement("Unlock All Core Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_core_abilities_special_operations_us')" ),
						newelement("Unlock All Passive Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_passives_abilities_special_operations_us')" ),
						newelement("Unlock All Specialization Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_specialization_abilities_special_operations_us')" ),
						newelement("Unlock All Unit Unlocks", "",    "GivePlayerUpgrade('dev_unlock_all_unit_unlock_upgrades_special_operations_us')" ),
						newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_special_operations_company_upgrades_us')" ),
					},
				},
				--- Afrika Korps ---
				--- DAK Italian Infantry ---
				{
					name = "DAK Italian Infantry",
					type = SubMenu,
					SubMenuItems =
					{
						newelement("Unlock All Core Abilities", "",    "GivePlayerUpgrade('dev_unlock_all_core_abilities_italian_infantry_ak')" ),
						newelement("Remove All Core Abilities", "",    "GivePlayerUpgrade('dev_remove_all_core_abilities_italian_infantry_ak')" ),
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Field Support", "",    "GivePlayerUpgrade('c_italian_infantry_field_support_ak')" ),
								newelement("Unlock Guastatori", "",    "GivePlayerUpgrade('c_italian_infantry_guastatori_ak')" ),
								newelement("Unlock Assault Package", "",    "GivePlayerUpgrade('c_italian_infantry_assault_package_ak')" ),
								newelement("Unlock L640 Light Tank", "",    "GivePlayerUpgrade('c_italian_infantry_l640_ak')" ),
								newelement("Unlock Cannone da 105", "",    "GivePlayerUpgrade('c_italian_infantry_cannone_da_105_ak')" ),
								newelement("Unlock Offmap Nebelwerfer Barrage", "",    "GivePlayerUpgrade('c_italian_infantry_off_map_nebelwerfer_ak')" ),
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
								
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
								
							},
						},
					},
				},

				--- Mechanized Infantry ---
				{
					name = "DAK Mechanized Infantry",
					type = SubMenu,
					SubMenuItems =
					{
						newelement("Unlock Mechanized Infantry Company Upgrade", "",    "GivePlayerUpgrade('c_mechanized_infantry_company_ak')" ),
						{
							name = "Core Abilities",
							type = SubMenu,
							SubMenuItems = 
							{
								newelement("Unlock Assault Team", "",    "GivePlayerUpgrade('c_mechanized_infantry_unlock_assault_team_core_ak')" ),
								newelement("Unlock 222", "",    "GivePlayerUpgrade('c_mechanized_infantry_unlock_222_force_recon_core_ak')" ),
								newelement("Unlock Bison", "",    "GivePlayerUpgrade('c_mechanized_infantry_unlock_bison_artillery_core_ak')" ),
								newelement("Unlock Cannon Strafe", "",    "GivePlayerUpgrade('c_mechanized_infantry_unlock_cannon_strafe_ak')" ),
								newelement("Unlock Recon Loiter", "",    "GivePlayerUpgrade('c_mechanized_infantry_unlock_recon_loiter_core_ak')" ),
								newelement("Unlock Stuka Assault", "",    "GivePlayerUpgrade('c_mechanized_infantry_unlock_stuka_assault_core_ak')" ),
							},
						},
						{
							name = "Specializations",
							type = SubMenu,
							SubMenuItems = 
							{
							},
						},
						{
							name = "Passive Abilities",
							type = SubMenu,
							SubMenuItems =
							{
							},
						},
						{
							name = "Unit Unlocks",
							type = SubMenu,
							SubMenuItems =
							{
							},
						},
						newelement("Unlock All Core Upgrades", "",    "GivePlayerUpgrade('dev_unlock_all_core_abilities_mechanized_infantry_us')" ),
						newelement("Remove All Upgrades", "",    "GivePlayerUpgrade('dev_remove_all_mechanized_infantry_company_upgrades_us')" ),
					},
				},
				{
					name = "Emplacement Affectors",
					type = SubMenu,
					SubMenuItems = GetGrantUpgradeTable("upgrade\\campaign\\missions\\emplacements\\"),
				},
				newelement("Add 5 skill points to mouseover squad", "",    "Cheat_GiveSquadSkillPoints(5)" ),
			},
		},
	}
end

function GetGrantUpgradeTable(filter)
	local grant_upgrade_menu = {}

	-- find the number of ability blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_Upgrade )
	local id = 0
	local offset = (#grant_upgrade_menu)
	local index = offset+1

	-- fill out the table with the ability blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_Upgrade, id )

		name = string.lower(name)

		local a,b = string.find( name, filter )
		
		-- only allow certain types of abilities on the list
		if ( b ~= nil ) then
			local newname = string.sub( name, b + 1 )
			grant_upgrade_menu[index] = newelement( newname, "", "GivePlayerUpgrade([["..name.."]])", NO_MP )
			index = index + 1
		end
	end

	-- sort the table alphabetically
	table.sort(grant_upgrade_menu, function(a,b) return a.name<b.name end)

	return grant_upgrade_menu
end

function GetGrantAbilityTable(filter)
	local grant_ability_menu = {}

	-- find the number of ability blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_Ability )
	local id = 0
	local offset = (#grant_ability_menu)
	local index = offset+1

	-- fill out the table with the ability blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_Ability, id )

		name = string.lower(name)

		local a,b = string.find( name, filter )
		
		-- only allow certain types of abilities on the list
		if ( b ~= nil ) then
			local newname = string.sub( name, b + 1 )
			grant_ability_menu[index] = newelement( newname, "", "GivePlayerAbility([["..name.."]])", NO_MP )
			index = index + 1
		end
	end

	-- sort the table alphabetically
	table.sort(grant_ability_menu, function(a,b) return a.name<b.name end)

	return grant_ability_menu
end

function GetAnvilAbilitiesSubMenu()
	return
	{
		name = "Anvil",
		type = SubMenu,
		SubMenuItems =
		{
			{
				name = "Campaign",
				type = SubMenu,
				SubMenuItems =
				{
					{
						name = "Common",
						type = SubMenu,
						SubMenuItems = GetGrantAbilityTable("abilities\\campaign\\affectors\\")
					},
					{
						name = "American",
						type = SubMenu,
						SubMenuItems =
						{
							{
								name = "Reinforcement",
								type = SubMenu,
								SubMenuItems = GetGrantAbilityTable("abilities\\races\\american\\campaign\\affectors\\")
							},
						},
					},
					{
						name = "British",
						type = SubMenu,
						SubMenuItems =
						{
							{
								name = "Reinforcement",
								type = SubMenu,
								SubMenuItems = GetGrantAbilityTable("abilities\\races\\british\\campaign\\affectors\\")
							},
						},
					},
					{
						name = "German",
						type = SubMenu,
						SubMenuItems =
						{
							{
								name = "Reinforcement",
								type = SubMenu,
								SubMenuItems = GetGrantAbilityTable("abilities\\races\\german\\campaign\\affectors\\")
							},
						},
					},
					{
						name = "Afrika Korps",
						type = SubMenu,
						SubMenuItems =
						{
							{
								name = "Reinforcement",
								type = SubMenu,
								SubMenuItems = GetGrantAbilityTable("abilities\\races\\afrika_korps\\campaign\\affectors\\")
							},
						},
					},
				},
			},
		}
	}
end



-- BEGIN CRITICAL DEBUG
local g_debug_critical_index = 0;

local g_debug_critical_table =
{
	[1] = {title = "Out Of Control", blueprint = "out_of_control"},
	[2] = {title = "Turret Pop Off", blueprint = "turret_pop_off"},
	[3] = {title = "Brew Up", blueprint = "brew_up"},
	[4] = {title = "None", blueprint = "normal_death"},
}

function Anvil_IsDebugCriticalSelected(value)
	return g_debug_critical_index == value;
end

function Anvil_SetDebugCritical(boolean, true_value, false_value)
	local index = false_value
	if (boolean) then index = true_value end
	
	g_debug_critical_index = index
	
	if (index == 0) then
		World_ClearStateModelPBG("forced_critical")
	else
		World_SetStateModelPBG("forced_critical", BP_GetUpgradeBlueprint(g_debug_critical_table[index].blueprint))
	end
end

function GetAnvilForceGlobalCriticalSubMenu()
	local table = {}

	for index, info in pairs(g_debug_critical_table) do
		table[index] = newboolean(info.title,  "Anvil_IsDebugCriticalSelected(" .. index .. ")", "Anvil_SetDebugCritical(%s, " .. index .. ", 0)")
	end

	return table
end

function GetAnvilDamageSubMenu()
	return
	{
		name = "Anvil",
		type = SubMenu,
		SubMenuItems =
		{
			{
				name = "Apply Critical",
				type = SubMenu,
				SubMenuItems = GetWeaponHitMenuTable("penetrated", "weapon\\dev\\critical_test\\")
			},
			{
				name = "Force Global Death Critical",
				type = SubMenu,
				SubMenuItems = GetAnvilForceGlobalCriticalSubMenu();
			},
		}
	}
end

table.insert(SubMenuItems.Damage.SubMenuItems, newseperator());
table.insert(SubMenuItems.Damage.SubMenuItems, GetAnvilDamageSubMenu());
-- END CRITICAL DEBUG

table.insert(SubMenuItems.Abilities.SubMenuItems, GetAnvilAbilitiesSubMenu());

SubMenuItems.Spawn.SubMenuItems.Squads.SubMenuItems = GetAnvilSquadSubMenu();
SubMenuItems.Spawn.SubMenuItems.Entities.SubMenuItems = GetAnvilEntitySubMenu();
SubMenuItems.Cosmetics.SubMenuItems = GetAnvilEntityCosmeticsSubMenu();
SubMenuItems.Upgrades.SubMenuItems = GetAnvilUpgradesSubMenu();

table.insert(SubMenuItems.AI.SubMenuItems, {
			name = "AI Company Personality Debug",
			type = Variable,
			get = "BP_GetDrawAICompanyPersonalityDebug()",
			set = "BP_SetDrawAICompanyPersonalityDebug(%s)",
			var_type = Boolean,
		})

function LuaAI_GetDrawCampaignUpdatingSquads()
	-- BUG TrentJ: This doesn't work because Scar_DoString doesn't return anything.
	return Scar_DoString("AI_GetDrawCampaignUpdatingSquads()")
end

function LuaAI_ToggleDrawCampaignUpdatingSquads()	
	Scar_DoString("AI_ToggleDrawCampaignUpdatingSquads()")
end

table.insert(SubMenuItems.AI.SubMenuItems, 
	newelement("Campaign AI Companies Awaiting Turn Update",
		"ALT+SHIFT+W",
		"LuaAI_ToggleDrawCampaignUpdatingSquads()",
		false))

function LuaAI_ToggleDrawCampaignAIPersonality()
	local playerID = AI_GetDebugAIPlayerID()
	if not Player_IsValid(playerID) then
		AI_ToggleDebugAIPlayer()
		playerID = AI_GetDebugAIPlayerID()
	end

	AI_DoString(playerID, "AI_ToggleDrawCampaignAIPlayerPersonality()")
end

table.insert(SubMenuItems.AI.SubMenuItems, 
	newelement("Campaign AI Player Personality",
		"ALT+SHIFT+L",
		"LuaAI_ToggleDrawCampaignAIPersonality()",
		false))
				
table.insert(SubMenuItems.AI.SubMenuItems, {
			name = "Set AI Player Personality",
			type = SubMenu,
			SubMenuItems = GetCampaignAIPersonalitySubMenu()
		})

table.insert(SubMenuItems.AI.SubMenuItems, {
			name = "AI Behind Defence Positional Utility Debug",
			type = Variable,
			get = "AI_GetDrawBehindDefenceDebug()",
			set = "AI_SetDrawBehindDefenceDebug(%s)",
			var_type = Boolean, 
	})

ObjectiveDebugCheatMenuList = {
		name = "Objective Debug",
		type = SubMenu,
		SubMenuItems = {}
	}
NarrativeDebugCheatMenuList = {
		name = "Narrative Debug",
		type = SubMenu,
		SubMenuItems = {}
}

table.insert(SubMenuItems.MissionCheats.SubMenuItems, 1, ObjectiveDebugCheatMenuList)
table.insert(SubMenuItems.MissionCheats.SubMenuItems, 2, NarrativeDebugCheatMenuList)
table.insert(SubMenuItems.MissionCheats.SubMenuItems, 3, newboolean("Show Objective Conditions", "Game_RetrieveTableData(\"MissionDebug\", false).show_conditions", "Scar_DoString(\"MissionDebug_SetShowConditions(%s)\")"))
table.insert(SubMenuItems.MissionCheats.SubMenuItems, 4, newboolean("Show Active Playbills", "Game_RetrieveTableData(\"MissionDebug\", false).show_playbills", "Scar_DoString(\"MissionDebug_SetShowPlaybills(%s)\")"))
table.insert(SubMenuItems.MissionCheats.SubMenuItems, 5, newboolean("Show Players Info", "Game_RetrieveTableData(\"MissionDebug\", false).show_players_info", "Scar_DoString(\"MissionDebug_SetShowPlayersInfo(%s)\")"))
table.insert(SubMenuItems.MissionCheats.SubMenuItems, 6, newelement("Win Mission by Skipping", "ALT+SHIFT+S", "Scar_DoString(\"if MissionDebug_MissionWin ~= nil then MissionDebug_MissionWin() else World_SetPlayerAndAlliesWin(Game_GetLocalPlayer(), -1) end\")", 1))

ObjectiveDebugCostArray = {}
function MissionDebug_RegisterObjective(title, value, cost)
	local index = nil
	for i = 1, #ObjectiveDebugCostArray do
		if cost < ObjectiveDebugCostArray[i] then
			index = i
			break
		end
	end
	local start = newelement("Start "..title, "", 
				"MissionCheat_ActivateMenuItem([[objective_start]], [[" ..
				value .. "]])"
				)
	local complete = newelement("Complete "..title, "", 
				"MissionCheat_ActivateMenuItem([[objective_complete]], [[" ..
				value .. "]])"
				)
	if index ~= nil then
		table.insert(ObjectiveDebugCheatMenuList.SubMenuItems, index, complete)
		table.insert(ObjectiveDebugCostArray, index, cost)
		table.insert(ObjectiveDebugCheatMenuList.SubMenuItems, index, start)
		table.insert(ObjectiveDebugCostArray, index, cost)
	else
		table.insert(ObjectiveDebugCheatMenuList.SubMenuItems, start)
		table.insert(ObjectiveDebugCostArray, cost)
		table.insert(ObjectiveDebugCheatMenuList.SubMenuItems, complete)
		table.insert(ObjectiveDebugCostArray, cost)
	end
	CheatMenu_ReloadFromContext()
end
function MissionDebug_RegisterFolderNarrativeEvent(title, value, ...)
	local path = {...}
	local items = NarrativeDebugCheatMenuList.SubMenuItems
	for i = 1, #path do
		local folder_name = path[i]
		items[folder_name] = items[folder_name] or {
			name = folder_name,
			type = SubMenu,
			SubMenuItems = {}
		}
		items = items[folder_name].SubMenuItems
	end
	table.insert(items,
		newelement(title, "", 
			"MissionCheat_ActivateMenuItem([[objective_start]], [[" .. value .. "]])"
			)
		)
	CheatMenu_ReloadFromContext()
end

-- @shortdesc issue a stop command to current turn agent and end turn
function EndTurnForced()
	local turnAgent = World_GetCurrentTurnAgent()
	if turnAgent ~= nil then
		local sgroup = SGroup_Create("sg_turnAgent")
		SGroup_Add(sgroup, turnAgent)
		LocalCommand_Squad(
				Squad_GetPlayerOwner(turnAgent),
				sgroup,
				SCMD_Stop,
				false
			)
		SGroup_Destroy(sgroup)
	end
	
	World_EndTurn()
end

TurnModuleCheatMenuList = {
	name = "Turn Module",
	type = SubMenu,
	SubMenuItems = {
		newelement("Force End Turn", "", "EndTurnForced()"),
		newelement("Toggle cinematic AI turn", "", 
			"Scar_DoString('g_cinematic_nonplayer_turn = not g_cinematic_nonplayer_turn')")}
}
table.insert(SubMenuItems.Sim.SubMenuItems, TurnModuleCheatMenuList)


function GetAnvilUISubMenu()
	return
	{
		name = "Anvil",
		type = SubMenu,
		SubMenuItems =
		{
			newboolean( "Show Supply Lines", "UI_IsSupplyLineVisualsEnabled()", "UI_SetSupplyLineVisualsEnabled(%s)"),
			newboolean( "Show Zone of Control", "UI_IsZoneOfControlVisualsEnabled()", "UI_SetZoneOfControlVisualsEnabled(%s)"),
			newboolean( "Show Aura Visuals (Passive Ability Range)", "UI_IsAuraVisualsEnabled()", "UI_SetAuraVisualsEnabled(%s)"),
		}
	}
end
table.insert(SubMenuItems.UI.SubMenuItems, GetAnvilUISubMenu());

-- drops a single artillery shell at the cursor location
function DropArtilleryAtMouse()
	
	-- get mouse over position
	local target = Misc_GetMouseOnTerrain()
	local origin = target
	origin.y = origin.y + 15
	
	local weapon = BP_GetWeaponBlueprint("75mm_howitzer_scott_us")
	
	Entity_SpawnLiveMunition(weapon, 0, origin, target)
	 
end

table.insert(
	SubMenuItems.Basic.SubMenuItems, 6,
	newelement( "Shoot 75mm Scott howitzer at cursor position", "ALT+SHIFT+A", "DropArtilleryAtMouse()")
)

-- toggle posture
function SetPostureOnEntity(entity, posture)
	if entity ~= nil then
		Entity_SetStateModelInt(entity, "posture", posture)
	end
end

function SetPostureOnSquad(squad, posture)
	if squad ~= nil then
		local count = Squad_Count(squad)
		for i = 0, count-1 do
			SetPostureOnEntity(Squad_EntityAt(squad, i), posture)
		end
	end
end

function ToggleCoverOnMouseOverSquad(enable)
	local squad = Misc_GetMouseOverSquad()
	if squad ~= nil then
		local count = Squad_Count(squad)
		for i = 0, count-1 do
			Entity_SetExtEnabled(Squad_EntityAt(squad, i), "cover_ext", enable)
		end
	end
end


DestroyMouseOverSquad = function()
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		-- first check to see if entity is part of a squad
		if (Entity_IsPartOfSquad( entity )) then
				local squad = Entity_GetSquad(entity)
				Squad_Destroy(squad)
		end
	end
end

--Swaps ownership between active player and enemy
function ChangeOwnershipMouseOverSquad() 
	local squad = Misc_GetMouseOverSquad()
	local upgrade = BP_GetUpgradeBlueprint("dev_change_ownership_enemy")
	if (squad ~= nil) then 
		Squad_CompleteUpgrade(squad, upgrade)
	end
end

function ChangeOwnershipMouseOverSquadAlly()
	local squad = Misc_GetMouseOverSquad()
	local upgrade = BP_GetUpgradeBlueprint("dev_change_ownership_ally")
	if (squad ~= nil) then 
		Squad_CompleteUpgrade(squad, upgrade)
	end
end

function ChangeOwnershipMouseOverSquadNeutral()
	local squad = Misc_GetMouseOverSquad()
	local upgrade = BP_GetUpgradeBlueprint("dev_change_ownership_neutral")
	if (squad ~= nil) then 
		Squad_CompleteUpgrade(squad, upgrade)
	end
end

function ChangeOwnershipMouseOverSquadPlayerOne()
	local squad = Misc_GetMouseOverSquad()
	local player = World_GetPlayerAt(1)
	if (squad ~= nil) then 
		Squad_SetPlayerOwner(squad, player)
	end
		
end

function ChangeOwnershipMouseOverSquadPlayerTwo()
	local squad = Misc_GetMouseOverSquad()
	local player = World_GetPlayerAt(2)
	if (squad ~= nil) then 
		Squad_SetPlayerOwner(squad, player)
	end
end

function GetAnvilGameplaySubMenu()
	return
	{
		name = "Gameplay",
		type = SubMenu,
		SubMenuItems =
		{
			newelement( "Reload Scenario", "ALT+SHIFT+J", "Scar_DebugConsoleExecute(\"restart\")"),	
			newelement( "Destroy Mouseover Squad", "ALT+SHIFT+Y", "DestroyMouseOverSquad()"),
			newelement( "Change Ownership","ALT+SHIFT+C", "ChangeOwnershipMouseOverSquad()"),
			newelement( "Change Ownership to Neutral","ALT+SHIFT+N", "ChangeOwnershipMouseOverSquadNeutral()"),
			newelement( "Change Ownership to Ally","ALT+SHIFT+X", "ChangeOwnershipMouseOverSquadAlly()"),
			newelement( "Change Ownership to World Player1","ALT+SHIFT+1", "ChangeOwnershipMouseOverSquadPlayerOne()"),
			newelement( "Change Ownership to World Player2","ALT+SHIFT+2", "ChangeOwnershipMouseOverSquadPlayerTwo()")
		}
	}
end
table.insert(SubMenuItems, 1, GetAnvilGameplaySubMenu());

function GetAnvilPostureSubMenu()
	return
	{
		name = "Anvil",
		type = SubMenu,
		SubMenuItems =
		{
			newseperator("Entity"),
			newelement( "Mouse Over Entity Stand", "CONTROL+ALT+SHIFT+W", "SetPostureOnEntity(Misc_GetMouseOverEntity(), 2)", NO_MP),
			newelement( "Mouse Over Entity Crouch", "CONTROL+ALT+SHIFT+S", "SetPostureOnEntity(Misc_GetMouseOverEntity(), 1)", NO_MP),
			newelement( "Mouse Over Entity Prone", "CONTROL+ALT+SHIFT+X", "SetPostureOnEntity(Misc_GetMouseOverEntity(), 0)", NO_MP),
			newseperator("Squad"),
			newelement( "Mouse Over Squad Stand", "CONTROL+ALT+SHIFT+R", "SetPostureOnSquad(Misc_GetMouseOverSquad(), 2)", NO_MP),
			newelement( "Mouse Over Squad Crouch", "CONTROL+ALT+SHIFT+F", "SetPostureOnSquad(Misc_GetMouseOverSquad(), 1)", NO_MP),
			newelement( "Mouse Over Squad Prone", "CONTROL+ALT+SHIFT+V", "SetPostureOnSquad(Misc_GetMouseOverSquad(), 0)", NO_MP),
			newseperator("Cover"),
			newelement( "Mouse Over Squad Cover Disable", "CONTROL+ALT+SHIFT+D", "ToggleCoverOnMouseOverSquad(false)", NO_MP),
			newelement( "Mouse Over Squad Cover Enable", "CONTROL+ALT+SHIFT+Z", "ToggleCoverOnMouseOverSquad(true)", NO_MP),
			newseperator("Suppression"),
			newelement( "Increase Mouse Over Squad Suppression", "CONTROL+SHIFT+0", "GiveSuppressionToSquad()", NO_MP),
		}
	}
end

table.insert(SubMenuItems.Posture.SubMenuItems, GetAnvilPostureSubMenu());

