---------------------------------------------------------------------
-- File    : physics_globals.lua
-- Desc    : 
-- Created : Friday, July 16, 2004
-- Author  : 
-- 
-- (c) 2004 Relic Entertainment Inc.
-- 

-- global physics parameters

-- contact manager values

minImpactNormVelocity = 0.1 		--  minimum impulse normal to point of contact before we trigger an impact
impactTimeout = 0.33				-- an impact expires after x seconds after which we can trigger another one
maxNumImpacts = 30					-- the maximum number of impacts per timeout period

minScrapeTangentVelocity = 4.25		-- minimum velocity tangent to contact normal before a contact is considered a scrape
maxScrapeInactiveTimer = 0.5		-- x seconds of inactivity before a scrape stops
minScrapeStartTimer = 0.0667		-- x seconds of stable scrape signal before we trigger a scrape
maxScrapeStaleContactInfo = 0.0667	-- x seconds before scrape contact info is considered stale (CAUTION: tricky value to tune)
maxNumScrapes = 4					-- sames as m_maxNumImpacts but for scrapes
explosionRotationFactor = 0.3		--how much of random rotation is applied to RBs when an explosion happens. Range is 0 to 1. A value of 0 means we push them by their center of mass and they won't roatate unless colliding.
-- These settings help to reduce constraint violations i.e. ragdolls being strecthed and bent due to extreme acceleration of rigid bodies.
maxSpeedFromImpulse = 10			-- [m/s] limits the magnitude of an impulse that can be applied to rigid bodies. 									
ragdollInertiaScaleFactor = 0.1		-- Applies a scaled spherical inertia tensor to the rigid bodies. A value of 0 disables this feature.

deleteDeadFragments = true			-- Removes physics fragments that have fallen out of the world instead of waiting for the host entity to be deleted.

defaultStepFrequency = 32			-- the tick rate used by default for physics, this should not change once assets are added to the game.
									-- specific configurations can go faster or slower, and constraints will be scaled internally relative to it to keep behavour consistent
									
-- world values
gravityVector =
{
	0,
	-9.8,
	0,
}
maxWorldSize = 1500
SystemSpecs =
{
	NoPhysicsSpec =
	{
		maxDebrisRBCount = 0,
		maxRagdollRBCount = 0,
		maxParticlesCount = 0,
		maxPhyFXCount = 0,
		maxPhantomCount = 0,
		terrainScalingFactor = 4,
		ragdollLifeTime = 0,
		desiredStepFrequency = 8, -- Hz
        desiredRigLod = 3,
		solverType = 0,
		maxCollisionChangesDelay = 80,
		maxCollisionChangesPerFrame = 60,
		canDiscardCollisionChanges = true,
		isUsingFastVehicleWheelCast = false,
	}, 
	
	MinSpec =
	{
		maxDebrisRBCount = 1100, --1000, overriden until asset lod implemented
		maxRagdollRBCount = 90,
		maxParticlesCount = 1000,
		maxPhyFXCount = 50,
		maxPhantomCount = 50,
		terrainScalingFactor = 2,
		ragdollLifeTime = 30,
		desiredStepFrequency = 27, -- Hz
        desiredRigLod = 2,
		solverType = 5, -- 4 iterations, medium soft
		maxCollisionChangesDelay = 80,
		maxCollisionChangesPerFrame = 60,
		canDiscardCollisionChanges = true,
		isUsingFastVehicleWheelCast = true,
	}, 
	
	MidSpec =
	{
		maxDebrisRBCount = 1700, --2000, overriden until asset lod implemented
		maxRagdollRBCount = 140,
		maxParticlesCount = 1500,
		maxPhyFXCount = 100,
		maxPhantomCount = 100,
		terrainScalingFactor = 1,
		ragdollLifeTime = 90,
		desiredStepFrequency = 32, -- Hz
        desiredRigLod = 1,
		solverType = 5, -- 4 iterations, medium soft
		maxCollisionChangesDelay = 80,
		maxCollisionChangesPerFrame = 100,
		canDiscardCollisionChanges = true,
		isUsingFastVehicleWheelCast = false,
	}, 
	
	HighSpec =
	{
		maxDebrisRBCount = 2500,
		maxRagdollRBCount = 250,
		maxParticlesCount = 2300,
		maxPhyFXCount = 150,
		maxPhantomCount = 100,
		terrainScalingFactor = 1,
		ragdollLifeTime = 180,
		desiredStepFrequency = 32, -- Hz
        desiredRigLod = 0,
		solverType = 5, -- 4 iterations, medium soft
		maxCollisionChangesDelay = 80,
		maxCollisionChangesPerFrame = 150,
		canDiscardCollisionChanges = false,
		isUsingFastVehicleWheelCast = false,
	}, 
}

-- terrain material properties
terrainMaterials = 
{
	{
		name = "<default>",
		restitution = 0.1,
		friction = 0.5,
	},
	
	{
		name = "grass",
		restitution = .1,
		friction = .8,
	},
	
	{
		name = "cement",
		restitution = .9,
		friction = .4,
	},
	
	{
		name = "crater_concrete",
		restitution = 0.7,
		friction = .5,
	},
	
	{
		name = "crater_debris",
		restitution = 1,
		friction = .1,
	},
	
	{
		name = "crater_dirt",
		restitution = 0.4,
		friction = 0.7,
	},
	
	{
		name = "crater_grass",
		restitution = 0.2,
		friction = 0.5,
	},
	
	{
		name = "crater_sand",
		restitution = 0,
		friction = 1,
	},
	
	{
		name = "crater_stone",
		restitution = 1,
		friction = .6,
	},
	
	{
		name = "dirt",
		restitution = 0.4,
		friction = 0.5,
	},
	
	{
		name = "ditch",
		restitution = 0.4,
		friction = 0.7,
	},
	
	{
		name = "field",
		restitution = 0,
		friction = 1,
	},
	
	{
		name = "mud",
		restitution = 0,
		friction = .2,
	},
	
	{
		name = "road_asphalt",
		restitution = 0.8,
		friction = 0.4,
	},
	
	{
		name = "road_dirt",
		restitution = 0.5,
		friction = 0.5,
	},
	
	{
		name = "rubble",
		restitution = 1,
		friction = 0.1,
	},
	
	{
		name = "sand",
		restitution = 0,
		friction = 1,
	},
	
	{
		name = "shingle_sp_m01",
		restitution = 0,
		friction = 1,
	},
	
	{
		name = "stone_natural",
		restitution = .8,
		friction = 0.3,
	},
	
	{
		name = "stone_road",
		restitution = 0.7,
		friction = 0.5,
	},
	
	{
		name = "urban",
		restitution = 0.7,
		friction = 0.4,
	},
	
	{
		name = "urban_narrow",
		restitution = 0.6,
		friction = 0.4,
	},
}
