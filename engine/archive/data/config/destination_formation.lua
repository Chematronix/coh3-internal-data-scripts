-- offsets are from the target point with forward being in the direction from the initial point to the target point
-- offsets are relative to the average squad size, it'll be dynamically adjusted to resolve overlaps so don't worry about that here

-- these formation behave differently than those defined in PBGs for which squads are assigned by rank
-- for this default config, first formation that can handle all selected squads will be chosen (so order matters!).

formations = 
{
	{ -- formation for 3 squads or less
		x = 0,
		y = 0,
		Children =
		{
			{ x = -1, y = 0 },
			{ x = 1, y = 0 }
		}
	},
	{ -- formation for 4 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
		}
	},
	{ -- formation for 5 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = -0.5, y = -1, }, -- 4
			{ x = 0.5, y = -1, },
		}
	},
	{ -- formation for 6 & 7 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
		}
	},
	{ -- formation for 8 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = -0.5, y = -2, }, -- 7
			{ x = 0.5, y = -2, },
		}
	},
	{ -- formation for 9 & 10 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = 0, y = -3, }, -- 10
		}
	},
	{ -- formation for 11 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = -0.5, y = -3, }, -- 10
			{ x = 0.5, y = -3, },
		}
	},
	{ -- formation for 12 & 13 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = 0, y = -3, }, -- 10
			{ x = -1, y = -3, },
			{ x = 1, y = -3, },
			{ x = 0, y = -4, }, -- 13
		}
	},
	{ -- formation for 14 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = 0, y = -3, }, -- 10
			{ x = -1, y = -3, },
			{ x = 1, y = -3, },
			{ x = -0.5, y = -4, }, -- 13
			{ x = 0.5, y = -4, },
		}
	},
	{ -- formation for 15 & 16 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = 0, y = -3, }, -- 10
			{ x = -1, y = -3, },
			{ x = 1, y = -3, },
			{ x = 0, y = -4, }, -- 13
			{ x = -1, y = -4, },
			{ x = 1, y = -4, },
			{ x = 0, y = -5, }, -- 16
		}
	},
	{ -- formation for 17 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = 0, y = -3, }, -- 10
			{ x = -1, y = -3, },
			{ x = 1, y = -3, },
			{ x = 0, y = -4, }, -- 13
			{ x = -1, y = -4, },
			{ x = 1, y = -4, },
			{ x = -0.5, y = -5, }, -- 16
			{ x = 0.5, y = -5, },
		}
	},
	{ -- formation for 18 & 19 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = 0, y = -3, }, -- 10
			{ x = -1, y = -3, },
			{ x = 1, y = -3, },
			{ x = 0, y = -4, }, -- 13
			{ x = -1, y = -4, },
			{ x = 1, y = -4, },
			{ x = 0, y = -5, }, -- 16
			{ x = -1, y = -5, },
			{ x = 1, y = -5, },
			{ x = 0, y = -6, }, -- 19
		}
	},
	{ -- formation for 20 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = 0, y = -3, }, -- 10
			{ x = -1, y = -3, },
			{ x = 1, y = -3, },
			{ x = 0, y = -4, }, -- 13
			{ x = -1, y = -4, },
			{ x = 1, y = -4, },
			{ x = 0, y = -5, }, -- 16
			{ x = -1, y = -5, },
			{ x = 1, y = -5, },
			{ x = -0.5, y = -6, }, -- 19
			{ x = 0.5, y = -6, },
		}
	},
	{ -- default formation for up to 21 squads
		x = 0,
		y = 0,
		Children = 
		{
			{ x = -1, y = 0, },
			{ x = 1, y = 0, },
			{ x = 0, y = -1, }, -- 4
			{ x = -1, y = -1, },
			{ x = 1, y = -1, },
			{ x = 0, y = -2, }, -- 7
			{ x = -1, y = -2, },
			{ x = 1, y = -2, },
			{ x = 0, y = -3, }, -- 10
			{ x = -1, y = -3, },
			{ x = 1, y = -3, },
			{ x = 0, y = -4, }, -- 13
			{ x = -1, y = -4, },
			{ x = 1, y = -4, },
			{ x = 0, y = -5, }, -- 16
			{ x = -1, y = -5, },
			{ x = 1, y = -5, },
			{ x = 0, y = -6, }, -- 19
			{ x = -1, y = -6, },
			{ x = 1, y = -6, },
		}
	},
}
