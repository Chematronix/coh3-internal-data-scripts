---------------------------------------------------------------------
-- Two top-level entries are for 1024 MB and 512 MB on consoles.
---------------------------------------------------------------------

MipLevels_NumConfig = 2;

-- tags affect these offsets/mipdrops
-- we use directories or "tags" to determine how many mips to drop, if a tag is set then it applies extra mip
-- drops over the base directory tag based on the load context tag
MipLevels =
{
-- This file will be reworked soon for DOW3
	{ directory = "art\\",									maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
																				 
	{ directory = "art\\material_library\\",				maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
																				 
	{ directory = "art\\armies\\",							maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
																				 
	{ directory = "art\\cursor\\",							maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\default\\",							maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\default\\default_lut\\",			maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\environment\\",						maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\environment\\buildings",			maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\environment\\objects",				maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\environment\\vtar_buildings",		maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
																				 
	{ directory = "art\\fx\\",								maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\ui\\",								maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\ui_visuals\\",						maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\ui_decals\\",						maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
	{ directory = "ui\\assets\\textures\\",					maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
	{ directory = "scenarios\\",							maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\scenarios\\",						maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\scenarios\\textures\\",				maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
	{ directory = "art\\scenarios\\textures\\splats\\",		maxDropLevels = { 1, 2 }, maxTexels = { 2048, 2048 }, },
																				 
	-- code generated                                                            
	{ directory = "none",									maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
	{ directory = "Terrain ColourMap Texture",				maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
 	{ directory = "LocalAO texture page",					maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
 	{ directory = "Light scatter on texture",				maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
 	{ directory = "Light scatter off texture",				maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
 	{ directory = "Terrain Tile Mask Texture",				maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
 	{ directory = "Terrain overlay texture",				maxDropLevels = { 0, 0 }, maxTexels = { 2048, 2048 }, },
 	{ directory = "Terrain compositor multiplier",			maxDropLevels = { 3, 2 }, maxTexels = { 2048, 2048 }, }, -- This is actually a multiplier for the screen resolution.
	
}
