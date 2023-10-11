---------------------------------------------------------------------
-- Four top-level entries are for 2048 MB, 1024 MB, 512 MB and 256 MB VRAM specs.
-- These equate to memory settings of "Ultra", "High", "Medium" and "Low" in the front end options.
-- Lower-level entries represent the actual dropping of mip levels, either as:
-- 	A single entry. eg 1, meaning drop one mip map level for all types of textures.
--	A list specifying different mip-map drops based on texture types.
---------------------------------------------------------------------

MipLevels_NumConfig = 4;

-- tags affect these offsets/mipdrops
-- we use directories or "tags" to determine how many mips to drop, if a tag is set then it applies extra mip
-- drops over the base directory tag based on the load context tag
MipLevels =
{
-- This file will be reworked soon for DOW3
	{ directory = "art\\",								maxDropLevels = { 0, 0, 0, 0 }, maxTexels = { 0, 0, 0, 0 }, },
	{ directory = "art\\civilizations\\",						maxDropLevels = { 0, 1, 2, 3 }, },
	
	{ directory = "art\\material_library\\",					maxDropLevels = { 0, 1, 2, 3 }, },

	{ directory = "art\\armies\\",							maxDropLevels = { 0, 1, 2, 3 }, },
	
	{ directory = "art\\cursor\\",							maxDropLevels = { 0, 0, 0, 0 }, },
	{ directory = "art\\default\\",							maxDropLevels = { 0, 1, 2, 3 }, },
	{ directory = "art\\default\\default_lut\\",					maxDropLevels = { 0, 0, 0, 0 }, },
	{ directory = "art\\environment\\",						maxDropLevels = { 0, 1, 2, 3 }, },

	{ directory = "art\\fx\\",							maxDropLevels = { 0, 1, 2, 3 }, },
	{ directory = "art\\ui\\",							maxDropLevels = { 0, 0, 0, 0 }, },
	{ directory = "art\\ui_visuals\\",						maxDropLevels = { 0, 0, 0, 0 }, },
	{ directory = "art\\ui_decals\\",						maxDropLevels = { 0, 0, 0, 0 }, },
	{ directory = "ui\\assets\\textures\\",						maxDropLevels = { 0, 0, 0, 0 }, },
	{ directory = "scenarios\\",							maxDropLevels = { 0, 1, 2, 3 }, },
	{ directory = "art\\scenarios\\",						maxDropLevels = { 0, 1, 2, 3 }, },
	{ directory = "art\\scenarios\\textures\\",					maxDropLevels = { 0, 1, 2, 3 }, },
	{ directory = "art\\scenarios\\textures\\splats\\",				maxDropLevels = { 0, 0, 1, 1 }, },

	-- code generated
	{ directory = "none",								maxDropLevels = { 0, 0, 0, 0 }, },
	{ directory = "Terrain ColourMap Texture",					maxDropLevels = { 0, 0, 0, 0 }, },
 	{ directory = "LocalAO texture page",						maxDropLevels = { 0, 0, 0, 0 }, },
 	{ directory = "Light scatter on texture",					maxDropLevels = { 0, 0, 0, 0 }, },
 	{ directory = "Light scatter off texture",					maxDropLevels = { 0, 0, 0, 0 }, },
 	{ directory = "Terrain Tile Mask Texture",					maxDropLevels = { 0, 0, 0, 0 }, },
 	{ directory = "Terrain overlay texture",					maxDropLevels = { 0, 0, 0, 0 }, },
 	{ directory = "Terrain compositor multiplier",					maxDropLevels = { 4, 3, 2, 1 }, }, -- This is actually a multiplier for the screen resolution.
	
}
