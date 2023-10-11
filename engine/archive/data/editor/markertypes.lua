MarkerTypes = {
	{
		type = "Player Spawn",
		
		colour = {0,0,1},
	},
	
	{
		type = "Enemy Spawn",
		
		colour = {1,0,0},
	},
	
	{
		type = "Ally Spawn",
		
		colour = {1,1,0},
	},
	
	{
		type = "Player Destination",
		
		colour = {0,0,0.5},
	},
	
	{
		type = "Player Rectangle Destination",
		
		colour = {0,0,0.5},
		proximity_type = PT_Rectangle,
	},
	
	{
		type = "Enemy Destination",
		
		colour = {0.5,0,0},
	},
	
	{
		type = "Enemy Rectangle Destination",
		
		colour = {0.5,0,0},
		proximity_type = PT_Rectangle,
	},
	
	{
		type = "Ally Destination",
		
		colour = {0.5,0.5,0},
	},
	
	{
		type = "Ally Rectangle Destination",
		
		colour = {0.5,0.5,0},
		proximity_type = PT_Rectangle,
	},
	
	{
		type = "Ability",
		
		colour = {1,0.5,0},
	},
	
	{
		type = "Square Trigger",
		
		colour = {0,1,0},
		proximity_type = PT_Rectangle,
	},
	
	{
		type = "Circle Trigger",
		
		colour = {0,1,0},
	},
	
	{
		type = "Camera",
		
		colour = {0,255,255},
	},
	
	{
		type = "UI Location",
		
		colour = {1,0.2,1},
		direction_indicator_colour = { 1,1,1}
	},

	{
		type = "action_marker",
		
		colour = {245,35,183},
	},

	{
		type = "Prefab",
		
		colour = {0,1,0},
	},

	{
		type = "Forge Camera",
		
		colour = {0,255,0},
	},
	{
		type = "Forge Spawn",
		
		colour = {0,128,0},
	},
	{
		type = "NIS Marker",
		
		colour = {1,0,1},
	},
}

-- Additional markers
import("editor/markers/ai_markers.lua")