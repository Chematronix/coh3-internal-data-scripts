---------------------------------------------------------------------
-- File    : EngineCommandBPDatabase.lua
--

--~
--~ Some default parameter blocks
--~
fx_parameters =
{
	{
		name = "fx",
		help = "Name of the fx to spawn.",
		value_browsepath = "Generic:Art\\Fx|*.lua",
		value_browsepath_final = "Data:Art\\Fx|*.bfx",
	},
	{
		name = "position",
		help = "Location for the effect.",
		default = "self",
		values =
		{
			"self",
			"other",
			"intersect_self",
			"intersect_other",
			"between",
		},
	},
	{
		name = "orientation",
		help = "Orientation for the effect.",
		default = "self",
		values =
		{
			"self",
			"other",
			"toward_self",
			"toward_other",
			"forward",
			"backward",
			"up",
			"down",
			"left",
			"right",
		},
	},
	{
		name = "length",
		help = "Length of the FX. 'distance' to use distance between self and other.",
		default = "1.0",
		values =
		{
			"distance",
			"1.0",
			"2.0",
		},
	},
	{
		name = "scale",
		help = "Scale of the FX (1 for normal), or 'object' to scale to object size.",
		default = "1.0",
		values =
		{
			"object",
		},
	},
	{
		name = "self_marker",
		help = "Marker that refers to 'self'.",
		default = "random",
		values =
		{
			"random",
		},
		value_type = "Marker",
	},
	{
		name = "other",
		help = "Definition of 'other'.",
		default = "self",
	},
	{
		name = "other_marker",
		help = "Marker that refers to 'other'.",
		default = "random",
		values =
		{
			"random",
		},
		value_type = "Marker",
	},
	{
		name = "spawn_offscreen",
		help = "Whether the effect is spawned if offscreen.",
		default = "false",
		values =
		{
			"true",
			"false",			
		}
	},
	{
		name = "stop_with_marker",
		help = "(fx_attach only) Whether the effect stops when the marker is removed.",
		default = "true",
		values =
		{
			"true",
			"false",			
		}
	},
	{
		name = "always_visible",
		help = "Whether the effect will always be updated and rendered.",
		default = "false",
		values =
		{
			"true",
			"false",			
		}
	},
	{
		name = "hits_bounding_boxes",
		help = "Whether effect transform is blocked by target bounding volumes.",
		default = "false",
		values =
		{
			"true",
			"false",			
		}
	},
	{
		name = "always_update",
		help = "Whether the effect will always be updated regardless of being rendered or not",
		default = "false",
		values = 
		{
			"true",
			"false",
		}
	},
	{
		name = "metadata",
		help = "Additional parameters for fx creation and behavior; key-value pairs separated by comma",
		default = "",
	}
}

audio_event_parameters =
{
	{
		name = "play_event",
		help = "Name of the play event.",
		value_type = "audioevent",
	},
	{
		name = "stop_event",
		help = "Name of the stop event.",
		value_type = "audioevent",
	},
	{
		name = "duration",
		help = "Duration in seconds to play looping audio for. Use -1 for non-looping audio or infinite duration.",
	},
	{
		name = "global",
		help = "Override the normal gameobject this event would play on, and play on the global gameobject instead.",
		default = "false",
		values =
		{
			"true",
			"false",
		},
	},
}

audio_switch_parameters =
{
	{
		name = "switch_group",
		help = "Name of the switch group.",
	},
	{
		name = "switch_state",
		help = "Name of the switch value.",
	},
}

audio_attach_trigger_parameters =
{
	{
		name = "name",
		help = "Name of trigger. All triggers with same name should have the same enter/exit/rtpc set. Radius can be different though.",
	},
	{
		name = "enter_event",
		help = "Name of event that is sent to each audio game object when they enter the trigger space.",
		value_type = "audioevent",
	},
	{
		name = "exit_event",
		help = "Name of event that is sent to each audio game object when they exit the trigger space.",
		value_type = "audioevent",
	},
	{
		name = "rtpc",
		help = "This rtpc represents the distance from the audio game object to center of this trigger.",
		value_type = "rtpc",
	},
	{
		name = "radius",
		default = "1",
		help = "Size of trigger",
	},
	{
		name = "ignore_same_name_rtpc",
		default = "false",
		values =
		{
			"true",
			"false",
		},
		help = "Closest trigger to listener will ignore rtpc being set from other audio triggers of the same name",
	},
}

audio_orphan_trigger_parameters = 
{
	{
		name = "name",
		help = "Name of trigger. All triggers with same name should have the same enter/exit/rtpc set. Radius can be different though.",
	},
	{
		name = "enter_event",
		help = "Name of event that is sent to each audio game object when they enter the trigger space.",
		value_type = "audioevent",
	},
	{
		name = "exit_event",
		help = "Name of event that is sent to each audio game object when they exit the trigger space.",
		value_type = "audioevent",
	},
	{
		name = "rtpc",
		help = "This rtpc represents the distance from the audio game object to center of this trigger.",
		value_type = "rtpc",
	},
	{
		name = "radius",
		default = "1",
		help = "Size of trigger.",
	},
	{
		name = "lifetime",
		default = "1",
		help = "Lifetime of trigger in seconds.",
	},
}

speech_context_parameters =
{
	{
		name = "context_name",
		help = "Name of the speech context to trigger.",
	},
}

splat_parameters =
{
	{
		name = "image",
		value_browsepath = "Generic:Art\\Scenarios\\Textures\\Splats|*.material",
		value_browsepath_final = "data:Art\\Scenarios\\Textures\\Splats|*.rrmaterial",
	},
	{
		name = "duration",
		help = "Lifetime, in seconds. '0' or empty for infinite.",
	},
	{
		name = "size",
		help = "Size for the splat in meters, or 'object' for object sized.",
		default = "1.0",
		values =
		{
			"object",
		},
	},
	{
		name = "size delta",
		help = "Variation of the texel size (in percent).",
	},
	{
		name = "position",
		value_type = "Marker",
	},
	{
		name = "orientation",
		default = "forward",
		values =
		{
			"forward",
		},
		value_type = "Marker",
	},
	{
		name = "rotation",
		help = "Degrees the splat is rotated.",
		default = "0.0",
	},
	{
		name = "rotation delta",
		help = "Degrees that the rotation can vary.",
		default = "0.0",
	},
	{
		name = "random rotation",
		help = "Signals a random rotation of the splat.",
		default = "no",
		values =
		{
			"yes",
			"no",
		},
	},
	{
		name = "random flip",
		default = "no",
		values =
		{
			"yes",
			"no",
		},
	},
	{
		name = "remove grass",
		default = "yes",
		values =
		{
			"yes",
			"no",
		},
	},
	{
		name = "add grass",
		value_browsepath = "Generic:Art\\Scenarios\\Grass\\Types|*.gdf",
		value_browsepath_final = "data:Art\\Scenarios\\Grass\\Types|*.gdf",
	},
	{
		name = "colour hue",
		help = "Hue tint of splat. Range: 0 - 360.",
		default = "0"
	},
	{
		name = "colour hue variance",
		help = "Adds or subtracts the hue tint based on a random number within this variance.",
		default = "0"
	},
	{
		name = "colour saturation",
		help = "Saturation tint of splat. Range: 0 - 100.",
		default = "0"
	},
	{
		name = "colour saturation variance",
		help = "Adds or subtracts the saturation tint based on a random number within this variance.",
		default = "0"
	},
	{
		name = "colour lightness",
		help = "Lightness tint of splat. Range: 0 - 100.",
		default = "100"
	},
	{
		name = "colour lightness variance",
		help = "Adds or subtracts the lightness tint based on a random number within this variance.",
		default = "0"
	},
	{
		name = "colour alpha",
		help = "Opacity of splat. Range: 0 - 100.",
		default = "100"
	},
	{
		name = "colour alpha variance",
		help = "Adds or subtracts the alpha based on a random number within this variance.",
		default = "0"
	},
	{
		name = "splat minimum terrain detail",
		help = "Minimum terrain detail level setting required for this splat to show up: Range: 0 (lowest detail) - 3 (maximum detail)",
		default = "0"
	},
	{
		name = "grass minimum terrain detail",
		help = "Minimum terrain detail level setting required for the grass settings on this splat be applied: Range: 0 (lowest detail) - 3 (maximum detail)",
		default = "1"
	},
}

grass_parameters =
{
	{
		name = "image",
		value_browsepath = "Generic:Art\\Scenarios\\Textures\\Splats|*.material",
		value_browsepath_final = "data:Art\\Scenarios\\Textures\\Splats|*.rrmaterial",
	},
	{
		name = "size",
		help = "Size for the splat in meters, or 'object' for object sized.",
		default = "1.0",
		values =
		{
			"object",
		},
	},
	{
		name = "size delta",
		help = "Variation of the texel size (in percent).",
	},
	{
		name = "position",
		value_type = "Marker",
	},
	{
		name = "orientation",
		default = "forward",
		values =
		{
			"forward",
		},
		value_type = "Marker",
	},
	{
		name = "rotation",
		help = "Degrees the splat is rotated.",
		default = "0.0",
	},
	{
		name = "rotation delta",
		help = "Degrees that the rotation can vary.",
		default = "0.0",
	},
	{
		name = "random rotation",
		help = "Signals a random rotation of the splat.",
		default = "no",
		values =
		{
			"yes",
			"no",
		},
	},
	{
		name = "remove grass",
		default = "yes",
		values =
		{
			"yes",
			"no",
		},
	},
	{
		name = "add grass",
		value_browsepath = "Generic:Art\\Scenarios\\Grass\\Types|*.gdf",
		value_browsepath_final = "data:Art\\Scenarios\\Grass\\Types|*.gdf",
	},
	{
		name = "grass minimum terrain detail",
		help = "Minimum terrain detail level setting required for the grass settings on this splat be applied: Range: 0 (lowest detail) - 3 (maximum detail)",
		default = "1"
	},
}

camshake_parameters =
{
	{
		name = "duration",
		help = "The number of seconds the camera shake lasts.",
		default = "1.0",	
	},
	{
		name = "target",
		help = "the name of the marker to attach to",
		value_type = "Marker",
	},	
	{
		name = "intensity",
		help = "The intensity of the camera shake.",
		default = "1.0",	
	},
	{
		name = "radius",
		help = "Cameras within this distance from the epicenter will shake.",
		default = "1.0",	
	},	
	{
		name = "falloff",
		help = "The falloff rate of the shake.",
		default = "1.0",	
	},		
}

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

	---
	{
		name = "triggerevent",
		help = "Allows events to be fired from actions",
		parameters =
		{
			{
				name = "Event",
				help = "Name of the event.",
				value_type = "Event",
			}
		}
	},
	{
		name = "setstate",
		help = "Allows states to be set from actions",
		parameters =
		{
			{
				name = "StateMachine",
				help = "Name of the state machine.",
				value_type = "StateMachine",
			},
			{
				name = "State",
				help = "Name of the state.",
				value_type = "StateMachineState",
			}
		}
	},
	{
		name = "setvariable",
		help = "Allows variables to be set from actions",
		parameters =
		{
			{
				name = "Variable",
				help = "Name of the variable.",
				value_type = "Variable",
			},
			{
				name = "Value",
				help = "Value to set the variable to.",
				default = "0.0",
			}
		}
	},
	{
		name = "setrandomvariable",
		help = "Sets a variable to a value between 'min' and 'max'",
		parameters =
		{
			{
				name = "Variable",
				help = "Name of the variable.",
				value_type = "Variable",
			},
			{
				name = "Min",
				help = "Minimum value to set the variable to.",
				default = "0.0",
			},
			{
				name = "Max",
				help = "Maximum to set the variable to.",
				default = "0.0",
			}
		}
	},
	{
		name = "addtovariable",
		help = "Adds a value to a variable.  Value can be negative to do subtraction.",
		parameters =
		{
			{
				name = "Variable",
				help = "Name of the variable.",
				value_type = "Variable",
			},
			{
				name = "Value",
				help = "Value to add to the variable.",
				default = "0.0",
			}
		}
	},

	--
	{
		name = "fx_attach",
		help = "Spawns and attaches fx to caller",
		parameters = fx_parameters,
	},
	{
		name = "fx_orphan",
		help = "Spawns and fx and leaves it there",
		parameters = fx_parameters,
	},
	--
	{
		name = "audio_event",
		parameters = audio_event_parameters,
	},
	{
		name = "audio_switch",
		parameters = audio_switch_parameters,
	},
	{
		name = "audio_attach_trigger",
		parameters = audio_attach_trigger_parameters,
	},
	{
		name = "audio_orphan_trigger",
		parameters = audio_orphan_trigger_parameters,
	},
	{
		name = "speech_context",
		parameters = speech_context_parameters,
	},

	--
 	{
 		name = "splat_attach",
 		parameters = splat_parameters,
 	},
	{
		name = "splat_manage",
		parameters = splat_parameters,
	},
	{
		name = "splat_orphan",
		parameters = splat_parameters,
	},
	{
		name = "grass_command",
		parameters = grass_parameters,
	},
	--
	{
		name = "physics_orphan",
		parameters =
		{
			{
				name = "rigName",
				default = "",
				value_type = "PhysicsOrphRig",
				help = "Name of (orphanable) rig to be used in orphaning or 'All' to process all orphanable rigs",
			},
			{
				name = "actionTriggered",
				default = "<none>",
				values =
				{
					"<none>",
				},
				value_type = "Action",
				help = "Name of action to trigger on newly created orphan",
			},
			{
				name = "lifeTime",
				default = "10",
				help = "lifetime of the orphan in seconds. -1 for infinite",
			},
			{
				name = "behaviour",
				help = "Name of the behaviour that will drive the fragments",
				value_browsepath = "Generic:|*.rdo",
				value_browsepath_final = "Data:|*.rdo",
			},
		},
	},
	--
	{
		name = "physics_hide_particle_meshes",
		parameters =
		{
			{
				name = "setName",
				default = "",
				help = "Name of particle set whose meshes needs to be hidden",
			},
		},
	},
	--
	{
		name = "physics_particles",
		parameters =
		{
			{
				name = "setName",
				default = "",
				help = "Name of particle set spawned by this action",
			},
			{
				name = "lifeTime",
				default = "10",
				help = "lifetime of the particle set in seconds. -1 for infinite",
			},
			{
				name = "collisionLayer",
				default = "",
				help = "collision layer that the particles will be using to decide what rigid bodies they collide with",
			},
			{
				name = "enableParticleParticleCollision",
				default = "false",
				help = "true if the particle in this set will collide with each other. (Note that particles never collides with other particles in other sets)",
			},
			{
				name = "enableDynamicRigidBodyCollision",
				default = "false",
				help = "true if the particle in this set will collide other dynamic rigid bodies. Use as an additional optimization instead of using collisionLayers",
			},
		},
	},
	--
	{
		name = "physics_particles_sphere_explosion",
		parameters =
		{
			{
				name = "setName",
				default = "",
				help = "Name of particle set spawned by this action",
			},
			{
				name = "lifeTime",
				default = "10",
				help = "lifetime of the particle set in seconds. -1 for infinite",
			},
			{
				name = "collisionLayer",
				default = "",
				help = "collision layer that the particles will be using to decide what rigid bodies they collide with",
			},
			{
				name = "enableParticleParticleCollision",
				default = "false",
				help = "true if the particle in this set will collide with each other. (Note that particles never collides with other particles in other sets)",
			},
			{
				name = "enableDynamicRigidBodyCollision",
				default = "false",
				help = "true if the particle in this set will collide other dynamic rigid bodies. Use as an additional optimization instead of using collisionLayers",
			},
			{
				name = "center",
				help = "Center of spherical explosion in model relative space / coords",
				default = "0.0, 0.0, 0.0",
			},
			{
				name = "radius",
				help = "Radius of the explosion's sphere of influence",
				default = "10.0",
			},
			{
				name = "innerMagnitude",
				help = "Magnitude of explosion speed at the center of the explosion's sphere",
				default = "500.0",
			},
			{
				name = "outerMagnitude",
				help = "Magnitude of explosion speed at the outer edge of the explosion's sphere",
				default = "100.0",
			},

		},
	},
	--
	{
		name = "physics_orphan_purge",
		help = "Clears orphaned physics objects based on radius to a marker on this object.",
		parameters =
		{
			{
				name = "marker",
				help = "Name of marker to pick for purge location. Empty for the model root.",
				value_type = "Marker",
			},
			{
				name = "radius",
				help = "Radius to clear orphans from the given marker.",
				default = "5.0",
			}
		},
	},

	--
	{
		name = "physics_rig_orphan_no_add",
		parameters =
		{
			{
				name = "rigName",
				default = "",
				value_type = "PhysicsOrphRig",
				help = "Name of (orphanable) rig to be used in orphaning or 'All' to process all orphanable rigs",
			},
			
			{
				name = "actionTriggered",
				default = "<none>",
				values =
				{
					"<none>",
				},
				value_type = "Action",
				help = "Name of action to trigger on newly created orphan",
			},
			{
				name = "lifeTime",
				default = "10",
				help = "lifetime of the orphan in seconds. -1 for infinite",
			},
			{
				name = "behaviour",
				help = "Name of the behaviour that will drive the fragments",
				value_browsepath = "Generic:|*.rdo",
				value_browsepath_final = "Data:|*.rdo",
			},
		},
	},

	--
	{
		name = "physics_rig_add",
		parameters =
		{
			{
				name = "rigName",
				default = "<default rig>",
				values =
				{
					"<default rig>",
				},
				value_type = "PhysicsRig",
				help = "Name of rig who's rigid bodies and constraints are to be created and added to the current state of the model",
			},
			{
				name = "behaviour",
				help = "Name of the behaviour that will drive the fragments",
				value_browsepath = "Generic:|*.rdo",
				value_browsepath_final = "Data:|*.rdo",
			},
			{
				name = "resetFixedBodyPositions",
				help = "Reset the position of the fixed rigid bodies in the rig",
				default = "false",
				values =
				{
					"true",
					"false",		
				},
			},
		},
	},

	--
	{
		name = "physics_rig_subtract",
		parameters =
		{
			{
				name = "rigName",
				default = "<default rig>",
				values =
				{
					"<default rig>",
				},
				value_type = "PhysicsRig",
				help = "Name of rig who's rigid bodies and constraints are to be destroyed and removed from the current state of the model",
			},
		},
	},
	
	--
	{
		name = "physics_sphere_explosion",
		parameters =
		{
			{
				name = "center",
				help = "Center of spherical explosion in model relative space / coords",
				default = "0.0, 0.0, 0.0",
			},
			{
				name = "radius",
				help = "Radius of the explosion's sphere of influence",
				default = "10.0",
			},
			{
				name = "innerMagnitude",
				help = "Magnitude of explosion impulse at the center of the explosion's sphere",
				default = "500.0",
			},
			{
				name = "outerMagnitude",
				help = "Magnitude of explosion impulse at the outer edge of the explosion's sphere",
				default = "100.0",
			},

			{
				name = "showDebugVisuals",
				help = "Show debug visualization for the explosion",
				default = "false",
				values =
				{
					"true",
					"false",			
				},
			},
			{
				name = "scaleForceWithVolume",
				help = "Take into account the volume of rigid bodies when applying forces to them",
				default = "false",
				values =
				{
					"true",
					"false",			
				},
			},
			{
				name = "collisionLayer",
				help = "the collision layer to use to detect objects affected. If empty, will use the 'explosions' layer if it exists, and the 'default' layer otherwise. Only used if restrictToLocalGameObject is off",
				default = "",
			},
			{
				name = "restrictToLocalGameObject",
				help = "If set to true, we will only look for rigid bodies belonging to the current game object and the orphans spawned from it. In this mode, pbject outside the radius will still have the outer magnitude force applied to them",
				default = "false",
				values =
				{
					"true",
					"false",			
				},
			},
		},
	},
	
	--
	{
		name = "physics_sphere_explosion_marker",
		parameters =
		{
			{
				name = "centerMarker",
				help = "Center of spherical explosion in model relative space / coords",
				default = "random",
				values =
				{
					"random",
				},
				value_type = "Marker",
			},
			{
				name = "radius",
				help = "Radius of the explosion's sphere of influence",
				default = "10.0",
			},
			{
				name = "innerMagnitude",
				help = "Magnitude of explosion impulse at the center of the explosion's sphere",
				default = "500.0",
			},
			{
				name = "outerMagnitude",
				help = "Magnitude of explosion impulse at the outer edge of the explosion's sphere",
				default = "100.0",
			},
			{
				name = "showDebugVisuals",
				help = "Show debug visualization for the explosion",
				default = "false",
				values =
				{
					"true",
					"false",			
				},
			},
			{
				name = "scaleForceWithVolume",
				help = "Take into account the volume of rigid bodies when applying forces to them",
				default = "false",
				values =
				{
					"true",
					"false",			
				},
			},
			{
				name = "collisionLayer",
				help = "the collision layer to use to detect objects affected. If empty, will use the 'explosions' layer if it exists, and the 'default' layer otherwise. Only used if restrictToLocalGameObject is off",
				default = "",
			},
			{
				name = "restrictToLocalGameObject",
				help = "If set to true, we will only look for rigid bodies belonging to the current game object and the orphans spawned from it. In this mode, pbject outside the radius will still have the outer magnitude force applied to them",
				default = "false",
				values =
				{
					"true",
					"false",			
				},
			},
		},
	},
	
	--
	{
		name = "physics_rig_transition",
		parameters =
		{
			{
				name = "rigName",
				default = "<default rig>",
				values =
				{
					"<default rig>",
				},
				value_type = "PhysicsRig",
				help = "Name of rig to transition to",
			},
			{
				name = "behaviour",
				help = "Name of the behaviour that will drive the fragments",
				value_browsepath = "Generic:|*.rdo",
				value_browsepath_final = "Data:|*.rdo",
			},
		}
	},
	
	--
	{
		name = "physics_cube_explosion",
		parameters =
		{
			{
				name = "fromX",
				default = "-1.0",
			},
			{
				name = "fromY",
				default = "-1.0",
			},
			{
				name = "fromZ",
				default = "-1.0",
			},
			{
				name = "toX",
				default = "1.0",
			},
			{
				name = "toY",
				default = "1.0",
			},
			{
				name = "toZ",
				default = "1.0",
			},
			{
				name = "impulseFromX",
				default = "0.0",
			},
			{
				name = "impulseFromY",
				default = "10.0",
			},
			{
				name = "impulseFromZ",
				default = "0.0",
			},
			{
				name = "impulseToX",
				default = "0.0",
			},
			{
				name = "impulseToY",
				default = "100.0",
			},
			{
				name = "impulseToZ",
				default = "0.0",
			},
			{
				name = "scaleForceWithVolume",
				help = "Take into account the volume of rigid bodies when applying forces to them",
				default = "false",
				values =
				{
					"true",
					"false",			
				},
			},			
			{
				name = "collisionLayer",
				help = "the collision layer to use to detect objects affected. If empty, will use the 'explosions' layer if it exists, and the 'default' layer otherwise.",
				default = "",
			},
		},
	},
	
	--
	{
		name = "physics_cube_explosion_marker",
		parameters =
		{
			{
				name = "fromMarker",
				default = "random",
				values =
				{
					"random",
				},
				value_type = "Marker",
			},
			{
				name = "toMarker",
				default = "random",
				values =
				{
					"random",
				},
				value_type = "Marker",
			},
			{
				name = "impulseFromX",
				default = "0.0",
			},
			{
				name = "impulseFromY",
				default = "10.0",
			},
			{
				name = "impulseFromZ",
				default = "0.0",
			},
			{
				name = "impulseToX",
				default = "0.0",
			},
			{
				name = "impulseToY",
				default = "100.0",
			},
			{
				name = "impulseToZ",
				default = "0.0",
			},
			{
				name = "scaleForceWithVolume",
				help = "Take into account the volume of rigid bodies when applying forces to them",
				default = "false",
				values =
				{
					"true",
					"false",			
				},
			},
			{
				name = "collisionLayer",
				help = "the collision layer to use to detect objects affected. If empty, will use the 'explosions' layer if it exists, and the 'default' layer otherwise.",
				default = "",
			},
		},
	},

	--
	{
		name = "physics_activate_ragdoll",
		help = "Activate ragdoll physics.",
		parameters =
		{
		},
	},

	--
	{
		name = "vehiclephysics_recoil",
		parameters =
		{
			{
				name = "marker",
				help = "Name of the marker to recoil from.",
				value_type = "Marker",
			},
			{
				name = "strength",
				help = "Strength of recoil, from 0 to 100.",
				default = "10.0",
			},
			{
				name = "directionX",
				help = "X direction of the recoil, relative to the marker transform",
				default = "0.0",
			},
			{
				name = "directionY",
				help = "Y direction of the recoil, relative to the marker transform",
				default = "0.0",
			},
			{
				name = "directionZ",
				help = "Z direction of the recoil, relative to the marker transform",
				default = "-1.0",
			},
		},
	},
	
	--
	{
		name = "vehiclephysics_set_accel_factor",
		parameters =
		{
			{
				name = "acceleration_factor",
				help = "Value of the acceleration factor which determines how sensitive a vehicle is to changes in velocity and forces",
				default = "5.0",
			},
		}
	},
	--
	{
		name = "animator_highlight",
		parameters =
		{
			{
				name = "enable",
				help = "If fullbright is on or off.",
				default = "off",
				values =
				{
					"off",
					"on",
				},	
			},
			{
				name = "diffuse R",
				help = "Red channel of the diffuse",
				default = "255",
			},
			{
				name = "diffuse G",
				help = "Green channel of the diffuse",
				default = "255",
			},
			{
				name = "diffuse B",
				help = "Blue channel of the diffuse",
				default = "255",
			},
			{
				name = "specular R",
				help = "Red channel of the specular",
				default = "255",
			},
			{
				name = "specular G",
				help = "Green channel of the specular",
				default = "255",
			},
			{
				name = "specular B",
				help = "Blue channel of the specular",
				default = "255",
			},
			{
				name = "fadeout",
				help = "Does this fade out?",
				default = "off",
				values =
				{
					"off",
					"on",
				},	
			},
			{
				name = "fadeTime",
				help = "Time it takes for the highlight to fade away",
				default = "1.0",
			},
		}
	},
	
	--
	{
		name = "animator_camouflage",
		parameters =
		{
			{
				name = "enable",
				help = "Set to true to camouflage this unit.",
				default = "true",
				values =
				{
					"true",
					"false",
				},	
			},
		}
	},
	--
	{
		name = "animator_cull_area_override_attach",
		help = "Overrides the object cull area scale factor",
		parameters =
		{
			{
				name = "cullAreaScale",
				help = "when units are REALLY far away this value needs to be very big e.g. >= 10000",
				default = "1.0",
			}
		}
	},
	--
	{
		name = "animator_cull_area_override_detach",
		help = "Resets the cull area of an object to the normal value",
	},
	--
	{
		name = "stamp_spawn",
		parameters =
		{
			{
				name = "StampBlueprint",
				help = "Name of StampBlueprint to spawn.",
				value_browsepath = "Generic:|*.rdo",
				value_browsepath_final = "data:|*.bin",
			},
			{
				name = "TerrainTextureMode",
				help = "Allows terrain textures to remain visible in the Fog of War",
				default = "shared_with_snapshot",
				values =
				{
					"default",
					"shared_with_snapshot",
				},
			},
			{
				name = "VisualSpawnMode",
				help = "Allows AnimatorBlueprints to spawn as MeshComponents only",
				default = "default",
				values =
				{
					"default",
					"meshes_only",
				},
			},
		}
	},
	--
	{
		name = "animator_spawn",
		parameters =
		{
			{
				name = "ABP",
				help = "Name of ABP to spawn.",
				value_browsepath = "Generic:|*.abp;*.fbx;*.rgo;*.rdo",
				value_browsepath_final = "data:|*.abp;*.rgm;*.rgo",
			},
			{
				name = "Marker",
				help = "Name of marker to attach to target. Empty for the model root.",
				value_type = "Marker",
			},
			{
				name = "EventOnSpawn",
				help = "Name of Event to trigger on the spawned animator.",
			},
		}
	},
	--
	{
		name = "animator_orphan",
		help = "Separates this Animator from it's Entity and lets it live for a while.",
		parameters =
		{
			{
				name = "Lifetime",
				help = "Time that this Animator will get to live.",
				default = "30.0",
			}
		}
	},
	--
	{
		name = "animator_orphan_purge",
		help = "Clears orphaned animators based on radius to a marker on this object.",
		parameters =
		{
			{
				name = "marker",
				help = "Name of marker to pick for purge location. Empty for the model root.",
				value_type = "Marker",
			},
			{
				name = "radius",
				help = "Radius to clear orphans from the given marker.",
				default = "5.0",
			}
		}
	},
	--
	{
		name = "animator_scale",
		help = "Scales the rendering transform.",
		parameters = 
		{
			{
				name = "scale",
				help = "The scale to apply to the transform.",
				default = "1.0",
			}
		},
	},	
	--
	{
		name = "vehiclephysics_toggle",
		parameters =
		{
			{
				name = "enable",
				help = "Set this to enable/disable vehicle physics",
				default = "false",
				values =
				{
					"true",
					"false",
				},	
			},
		}
	},
	
	--

	{
		name = "freezepose_toggle",
		parameters =
		{
			{
				name = "enable",
				help = "Set this to enable/disable freeze pose",
				default = "false",
				values =
				{
					"true",
					"false",
				},	
			},
		}
	},
	
	--
	{
		name = "camshake",
		parameters = camshake_parameters,
	},

	--
	{
		name = "set_team_colour",
		help = "Sets the team colour variables",
		parameters =
		{
			{
				name = "playerID",
				help = "Should be set to %playerID for the game to override",
				default = "%playerID",
			},
			{
				name = "unitBadge",
				help = "Unit's badge texture",
				default = "%unitBadge",
				value_browsepath = "Generic:art\\armies|*.dds;*.png;*.tga",
				value_browsepath_final = "data:art\\armies|*.rrtex",
			},
		}
	},
	{
		name = "restore_team_colour",
		help = "Restores team colour variables to default",
	},
	{
		name = "apply_custom_skin",
		help = "Set the entity to apply a custom skin that was chosen by the player",
		parameters =
		{
			{
				name = "skinOverride",
				help = "Should be set to %skinOverride for the game to override",
				default = "%skinOverride",
			},
			{
				name = "forceTextureLoad",
				help = "Should be set to true if you want the skin textures to attempt to force-load",
				default = "%forceTextureLoad",
			},
		},
	},
	--
	{
		name = "texture_selector",
		help = "Overrides a models textures",
		parameters =
		{
			{
				name = "Diffuse",
				help = "Diffuse texture",
				value_browsepath = "Generic:|*.dds;*.png;*.tga",
				value_browsepath_final = "data:|*.rrtex",
			},
			{
				name = "Normal",
				help = "Normal map texture",
				value_browsepath = "Generic:|*.dds;*.png;*.tga",
				value_browsepath_final = "data:|*.rrtex",
			},
			{
				name = "Team",
				help = "Team texture",
				value_browsepath = "Generic:|*.dds;*.png;*.tga",
				value_browsepath_final = "data:|*.rrtex",
			},
			{
				name = "Occlusion",
				help = "Occlusion texture",
				value_browsepath = "Generic:|*.dds;*.png;*.tga",
				value_browsepath_final = "data:|*.rrtex",
			},
			{
				name = "Gloss",
				help = "Gloss texture",
				value_browsepath = "Generic:|*.dds;*.png;*.tga",
				value_browsepath_final = "data:|*.rrtex",
			},
			{
				name = "Specular",
				help = "Specular texture",
				value_browsepath = "Generic:|*.dds;*.png;*.tga",
				value_browsepath_final = "data:|*.rrtex",
			},
			{
				name = "Materials",
				help = "List of material names to modify, separated by semicolons (;)",
				value_type = "Material",
			},
		}
	},
	{
		name = "restore_texture_selector",
		help = "Restores a models textures",
	},
	{
		name = "restore_specific_texture_selector",
		help = "Restores a specific material models textures",
		parameters =
		{
			{
				name = "Materials",
				help = "List of material names to modify, separated by semicolons (;)",
				value_type = "Material",
			},
		}
	},
	--
	{
		name = "set_unit_occlusion",
		help = "Sets unit occlusion variables",
		parameters =
		{
			{
				name = "mode",
				help = "Set occlusion rendering mode for this object, or 'off'.",
				default = "off",
				values =
				{
					"self",
					"ally",
					"enemy",
					"environment",
					"scan_infrared",
					"scan_infrared_ally",
					"off",
				},
			},
		}
	},
	{
		name = "remove_unit_occlusion",
		help = "Restores unit occlusion settings to default",
	},

	{
		name = "action_call",
		help = "Launches another action",
		parameters = 
		{
			{
				name = "ActionName",
				value_browsepath = "generic:art\\actions|*.action",
				value_browsepath_final = "data:art\\actions|*.action",
				value_type = "Action",
				help = "Name of the action.",
			}
		},
	},

	{
		name = "random_action_call",
		help = "Launches another action at random",
		parameters = 
		{
			{
				name = "ActionName0",
				value_browsepath = "generic:art\\actions|*.action",
				value_browsepath_final = "data:art\\actions|*.action",
				value_type = "Action",
				help = "Name of the action.",
			},
			{
				name = "ActionName1",
				value_browsepath = "generic:art\\actions|*.action",
				value_browsepath_final = "data:art\\actions|*.action",
				value_type = "Action",
				help = "Name of the action.",
			},
			{
				name = "ActionName2",
				value_browsepath = "generic:art\\actions|*.action",
				value_browsepath_final = "data:art\\actions|*.action",
				value_type = "Action",
				help = "Name of the action.",
			},
			{
				name = "ActionName3",
				value_browsepath = "generic:art\\actions|*.action",
				value_browsepath_final = "data:art\\actions|*.action",
				value_type = "Action",
				help = "Name of the action.",
			}
		},
	},

	{
		name = "action_delaycall",
		help = "Launches another action after a certain time",
		parameters = 
		{
			{
				name = "ActionName",
				value_browsepath = "generic:art\\actions|*.action",
				value_browsepath_final = "data:art\\actions|*.action",
				value_type = "Action",
				help = "Name of the action.",
			},
			{
				name = "DelaySeconds",
				help = "Time in seconds to delay the action.",
				default = "0.0",
			},
		},
	},

	--
	{
		name = "OS_CreateLocalScar",
		help = "Adds a scar to a single objects surface.",
		parameters = 
		{
			{
				name = "marker",
				help = "Marker (dynamic or not) to spawn the scar at.",
				default = "dynamic",
				values =
				{
					"dynamic",
					"random",
				},
				value_type = "Marker",
			},
			{	
				name = "scaleMin",
				help = "Mimimum diameter of the hit mark, in meters. Must be <= scaleMax.",
				default = "1.0",
				values =
				{
					"0.5",
					"0.6",
					"0.7",
					"0.8",
					"0.9",
					"1.0",
					"1.5",
					"2.0",
				},
			},
			{	
				name = "scar",
				help = "File prefix (name) of the scar textures.",
				default = "default_scar",
				values =
				{
					"default_scar",
				},
			},
			{	
				name = "projCalcRadius",
				help = "Sphere size used for tris that are taken into account for the projection axis.",
				default = "1.0",
				values =
				{
					"1.0",
				},
			},
			{	
				name = "backfaceThreashold",
				help = "Threashold used for backface culling, should be from 0-1.",
				default = "0.0",
				values =
				{
					"0.0",
					"0.25",
					"0.5",
					"0.75",
				},
			},
			{	
				name = "randRotation",
				help = "Randomly rotate the scar about the projection axis.",
				default = "true",
				values =
				{
					"true",
					"false",
				},
			},
			{	
				name = "randUFlip",
				help = "Randomly flip the scar about the U axis.",
				default = "true",
				values =
				{
					"true",
					"false",
				},
			},
			{	
				name = "randVFlip",
				help = "Randomly flip the scar about the V axis.",
				default = "true",
				values =
				{
					"true",
					"false",
				},
			},
			{	
				name = "scaleMax",
				help = "Maximum diameter of the hit mark, in meters. Must be >= scaleMin.",
				default = "1.0",
				values =
				{
					"0.5",
					"0.6",
					"0.7",
					"0.8",
					"0.9",
					"1.0",
					"1.5",
					"2.0",
				},
			},
			{	
				name = "projBackfaceThreashold",
				help = "Threashold used for backface culling in the projection calculation, should be between -1 and +1.",
				default = "0.0",
				values =
				{
					"-0.75",
					"-0.5",
					"-0.25",
					"0.0",
					"0.25",
					"0.5",
					"0.75",
				},
			},
		}
	},
	--
	{
		name = "OS_CreateAreaScar",
		help = "Adds a scar to the surface of all objects within range.",
		parameters = 
		{
			{
				name = "marker",
				help = "Marker (dynamic or not) to spawn the scar at.",
				default = "dynamic",
				values =
				{
					"dynamic",
					"random",
				},
				value_type = "Marker",
			},
			{	
				name = "radiusMin",
				help = "Minimum radius of the scorch mark, in meters. Must be <= radiusMax.",
				default = "1.0",
				values =
				{
					"0.5",
					"0.6",
					"0.7",
					"0.8",
					"0.9",
					"1.0",
					"1.5",
					"2.0",
				},
			},
			{	
				name = "scar",
				help = "File prefix (name) of the scar textures.",
				default = "default_scar",
				values =
				{
					"default_scar",
				},
			},
			{	
				name = "projCalcRadius",
				help = "Sphere size used for tris that are taken into account for the projection axis.",
				default = "1.0",
				values =
				{
					"1.0",
				},
			},
			{	
				name = "backfaceThreashold",
				help = "Threashold used for backface culling, should be from 0-1.",
				default = "0.0",
				values =
				{
					"0.0",
					"0.25",
					"0.5",
					"0.75",
				},
			},
			{	
				name = "randRotation",
				help = "Randomly rotate the scar about the projection axis.",
				default = "true",
				values =
				{
					"true",
					"false",
				},
			},
			{	
				name = "randUFlip",
				help = "Randomly flip the scar about the U axis.",
				default = "true",
				values =
				{
					"true",
					"false",
				},
			},
			{	
				name = "randVFlip",
				help = "Randomly flip the scar about the V axis.",
				default = "true",
				values =
				{
					"true",
					"false",
				},
			},
			{	
				name = "radiusMax",
				help = "Maximum radius of the scorch mark, in meters. Must be >= radiusMin.",
				default = "1.0",
				values =
				{
					"0.5",
					"0.6",
					"0.7",
					"0.8",
					"0.9",
					"1.0",
					"1.5",
					"2.0",
				},
			},
			{	
				name = "projBackfaceThreashold",
				help = "Threashold used for backface culling in the projection calculation, should be between -1 and +1.",
				default = "0.0",
				values =
				{
					"-0.75",
					"-0.5",
					"-0.25",
					"0.0",
					"0.25",
					"0.5",
					"0.75",
				},
			},
		}
	},

	--
	{
		name = "OS_ClearScars",
		help = "Clears all Object Scars on an object.",
		parameters = 
		{
			{	
				name = "time",
				help = "Time to fade the scars out over.",
				default = "0.0",
				values =
				{
					"0.0",
					"0.1",
					"0.2",
					"0.3",
					"0.4",
					"0.5",
					"0.75",
					"1.0",
				},
			},
		}
	},

	--
	{
		name = "snowcap_limit",
		help = "allows tunning how much snow there is on top of objects, it gets multiplied by the ObjectSnowCapLimit",
		parameters =
		{
			{
				name = "snow_depth",
				help = "Snow cap height, 0 = no snow, -1 = resets to default object value, between 0-1 percentage of original snow cap limit",
				default = "1.0",
			},
			{
				name = "fade_in_time",
				help = "time it takes to fade in to the target depth",
				default = "0.0",
			},
		}
	},

	--
	{
		name = "enable_hide_override",
		help = "**NOT IN RTM**hides an entity",
	},
	{
		name = "disable_hide_override",
		help = "**NOT IN RTM**unhides an entity",
	},

	--
	{
		name = "alpha_factor",
		help = "tunes the alpha factor of the object",
		parameters =
		{
			{
				name = "alpha_factor",
				help = "INVERSED from alpha: 0 means visible, 1 means invisible",
				default = "1.0",
			},
			{
				name = "interpolation_time",
				help = "time it takes to change to desired value",
				default = "0.0",
			},
		}
	},
	--
	{
		name = "animator_pose_constrain_joint",
		help = "Force a joint to have position/orientation of another joint.",
		parameters =
		{
			{
				name = "constraint_name",
				help = "Unique name of constraint to use with the remove_constrain_joint"
			},
			{
				name = "joint",
				value_type = "Joint",
				help = "Joint to be constrained to target joint."
			},
			{
				name = "target_joint",
				value_type = "Joint",
				help = "Joint to be constrained to."
			},
			{
				name = "interpolation_time",
				help = "Seconds it takes for target to transition to source.",
				default = "0.0"
			}
		}
	},
	{
		name = "animator_pose_constrain_remove",
		help = "Remove pose constraint (such as set with animator_pose_constrain_joint).",
		parameters =
		{
			{
				name = "constraint_name",
				help = "Unique name of constraint provided in the apply_constrain_joint action."
			},
			{
				name = "interpolation_time",
				help = "Seconds it takes for target to return to it's own position/orientation.",
				default = "0.0"
			}
		}
	},
	{
		name = "animator_reset_offscreen_clock",
		help = "Reset the off-screen update clock on an animator (to prevent over animating when coming on-screen).",
	},
	
		--
	{
		name = "set_shader_var_float",
		help = "sets a float variable on all materials of a model",
		parameters =
		{
			{
				name = "handle",
				help = "four letter code used for clearing this value",
				default = "abcd",
			},
			{
				name = "variable",
				help = "name of variable on shader",
				default = "",
			},
			{
				name = "value",
				help = "value to set to the variable of the shader",
				default = "0.0",
			},
			{
				name = "material",
				help = "name of material to change (applies to all if empty)",
				default = "",
			},
		}
	},
			--
	{
		name = "set_material_flag_and_shader_var_float",
		help = "sets a material render flag and shader float variable on all materials of a model",
		parameters =
		{
			{
				name = "handle",
				help = "four letter code used for clearing this value",
				default = "abcd",
			},
			{
				name = "variable",
				help = "name of flaot variable on shader",
				default = "",
			},
			{
				name = "value",
				help = "float value to set to the variable of the shader",
				default = "0.0",
			},
			{
				name = "material",
				help = "name of material to change (applies to all if empty)",
				default = "",
			},
			{
				name = "material_render_flag",
				help = "render flag (integer) to set. See valid values in 'enum class RenderFlagType' defined in .\\engine\\source\\runtime\\essence\\public\\essence\\gru\\gruCommon.h",
				default = "1",
			},
			{
				name = "material_render_flag_value",
				help = "boolean value to enable/disable the material_render_flag",
				default = "0",
			},
		}
	},

	--
	{
		name = "set_shader_var_colour",
		help = "sets a colour variable on all materials of a model",
		parameters =
		{
			{
				name = "handle",
				help = "four letter code used for clearing this value",
				default = "abcd",
			},
			{
				name = "variable",
				help = "name of variable on shader",
				default = "",
			},
			{
				name = "red",
				help = "red value to set to the variable of the shader",
				default = "1.0",
			},
			{
				name = "green",
				help = "green value to set to the variable of the shader",
				default = "0.0",
			},
			{
				name = "blue",
				help = "blue value to set to the variable of the shader",
				default = "1.0",
			},
			{
				name = "alpha",
				help = "alpha value to set to the variable of the shader",
				default = "1.0",
			},
			{
				name = "material",
				help = "name of material to change (applies to all if empty)",
				default = "",
			},
		}
	},

	--
	{
		name = "clear_shader_var",
		help = "removed a variable override on all materials of a model",
		parameters =
		{
			{
				name = "handle",
				help = "four letter code used for clearing this value",
				default = "abcd",
			},
		}
	},
	
	{
		name = "outlines_set",
		help = "set building outlines alpha and color",
		parameters =
		{
			{
				name = "alpha",
				help = "outlines alpha 0 = off",
				default = "0.0",
			},
			{
				name = "alpha_fill",
				help = "outlines fill alpha",
				default = "0.0",
			},
			{
				name = "color_index",
				help = "outlines color index 0=default",
				default = "0",
			},
			{
				name = "color_scale",
				help = "outlines brightness",
				default = "1.0",
			},
			{
				name = "type",
				help = "How the outlines is rendered based on FOW SOW",
				default = "always",
				values =
				{
					"always",
					"sight_plus",			
					"shroud_but_sight_plus",			
				}
			},
			{
				name = "include_attachments",
				help = "set true if include all attachments otherwise false",
				default = "false",
				values =
				{
					"true",
					"false",
				},
			},
			{
				name = "ontop_original_visual",
				help = "select occluder(units) or occludable(buildings) if you want to render InkAsLight on top of the original normal visual, otherwise set none",
				default = "none",
				values =
				{
					"none",
					"occluder",
					"occludable",
				},
			},
		},
	},

	{
		name = "outlines_fade",
		help = "start building outlines animation",
		parameters =
		{
			{
				name = "fade_duration",
				help = "fade duration in seconds",
				default = "0.0",
			},
			{
				name = "bottom_point",
				help = "building fade bottom point >=0 and <= mid_point",
				default = "0.0",
			},
			{
				name = "mid_point",
				help = "building fade mid point >0 and <1",
				default = "0.5",
			},
			{
				name = "top_point",
				help = "building fade top point >=mid_point and <= 1",
				default = "1.0",
			},
			{
				name = "mid_end_alpha",
				help = "building fade mid end alpha value",
				default = "0.0",
			},
			{
				name = "top_end_alpha",
				help = "building fade top end alpha value",
				default = "0.0",
			},
			{
				name = "bottom_end_alpha",
				help = "building fade bottom end alpha value",
				default = "0.0",
			},
			{
				name = "mid_end_alpha_fill",
				help = "building fade mid end alpha to fill inner",
				default = "0.0",
			},
			{
				name = "top_end_alpha_fill",
				help = "building fade top end alpha to fill inner",
				default = "0.0",
			},
			{
				name = "bottom_end_alpha_fill",
				help = "building fade bottom end alpha to fill inner",
				default = "0.0",
			},
			{
				name = "color_index",
				help = "outlines color index 0=default",
				default = "0",
			},
			{
				name = "color_scale",
				help = "outlines brightness",
				default = "1.0",
			},
			{
				name = "type",
				help = "How the outlines is rendered based on FOW SOW",
				default = "always",
				values =
				{
					"always",
					"sight_plus",			
					"shroud_but_sight_plus",			
				}
			},
			{
				name = "include_attachments",
				help = "set true if include all attachments otherwise false",
				default = "false",
				values =
				{
					"true",
					"false",
				},
			},
			{
				name = "ontop_original_visual",
				help = "select occluder(units) or occludable(buildings) if you want to render InkAsLight on top of the original normal visual, otherwise set none",
				default = "none",
				values =
				{
					"none",
					"occluder",
					"occludable",
				},
			},
		},
	},
	
	{
	
		name = "outlines_stop_anim",
		help = "stop building outlines animation",
		parameters =
		{
			{
				name = "outlines_off",
				help = " > 0 trun off outlines",
				default = "0.0",
			},
			{
				name = "include_attachments",
				help = "set true if include all attachments otherwise false",
				default = "false",
				values =
				{
					"true",
					"false",
				},
			},
		},
		
	},

	{
	
		name = "set_visual_influence",
		help = "add/remove visual influence",
		parameters =
		{
			{
				name = "influence",
				help = "0=remove influence and 1=add influence",
				default = "0",
			},
		},
		
	},
	
	{
	
		name = "set_visual_influence_radius",
		help = "override default visual influence radius",
		parameters =
		{
			{
				name = "radius",
				help = "influence radius in meters",
				default = "10",
			},
		},
		
	},

	{
	
		name = "set_charred_effect",
		help = "set charred effect",
		parameters =
		{
			{
				name = "charredAmount",
				help = "charred amount[0-1]",
				default = "0",
			},
			{
				name = "charredErodeAmount",
				help = "alpha erode amount[0-1]",
				default = "0",
			},
			{
				name = "affectTerrainGrass",
				help = "set true if you want surrounding terrain grass charred effect",
				default = "true",
				values =
				{
					"true",
					"false",
				},
			},
			{
				name = "surroundingExtent",
				help = "surrounding area extent amount for terrain grass",
				default = "1",
			},
		},
		
	},

	{
	
		name = "set_charred_terrain_grass",
		help = "set charred terrain grass only",
		parameters =
		{
			{
				name = "charredAmount",
				help = "charred amount[0-1]",
				default = "0",
			},
			{
				name = "charredErodeAmount",
				help = "alpha erode amount[0-1]",
				default = "0",
			},
			{
				name = "posX",
				help = "paint pos X",
				default = "0",
			},
			{
				name = "posZ",
				help = "paint pos Z",
				default = "0",
			},
			{
				name = "majorRadius",
				help = "paint shape major radius(in X-Axis before rotation)",
				default = "1",
			},
			{
				name = "minorRadius",
				help = "paint shape minor radius(in Z-Axis before rotation)",
				default = "1",
			},
			{
				name = "angle",
				help = "paint shape rotation angle in degrees relative to X-Axis",
				default = "0",
			},
		},
		
	},

	{
	
		name = "set_charred_effect_dynamic",
		help = "set charred effect over time",
		parameters =
		{
			{
				name = "charredAmountInitial",
				help = "initial charred amount[0-1]",
				default = "0",
			},
			{
				name = "charredAmountFinal",
				help = "final charred amount[0-1]",
				default = "1",
			},
			{
				name = "charredAmountDelaySeconds",
				help = "before this the value will always be set to Initial",
				default = "0",
			},
			{
				name = "charredAmountTransitionSeconds",
				help = "time it takes to go from Initial to Final value (after delay expires)",
				default = "0",
			},
			{
				name = "charredErodeAmountInitial",
				help = "initial alpha erode amount[0-1]",
				default = "0",
			},
			{
				name = "charredErodeAmountFinal",
				help = "final alpha erode amount[0-1]",
				default = "1",
			},
			{
				name = "charredErodeAmountDelaySeconds",
				help = "before this the value will always be set to Initial",
				default = "0",
			},
			{
				name = "charredErodeAmountTransitionSeconds",
				help = "time it takes to go from Initial to Final value (after delay expires)",
				default = "0",
			},
			{
				name = "applyEvenAfterFinalValuesReached",
				help = "true if non zero, will ensure mesh swaps after transition time still receive the desired final values",
				default = "0",
			},
			{
				name = "affectTerrainGrass",
				help = "set true if you want surrounding terrain grass charred effect",
				default = "true",
				values =
				{
					"true",
					"false",
				},
			},
			{
				name = "surroundingExtent",
				help = "surrounding area extent amount for terrain grass",
				default = "1",
			},
		},
		
	},

	{
		name = "unit_exposure_comp_multiplier_fade",
		help = "start unit exposure value comp multiplier fade",
		parameters =
		{
			{
				name = "fade_duration",
				help = "fade duration in seconds, set instantly if duration <= 0",
				default = "0.0",
			},
			{
				name = "scale",
				help = "target multiplier for unit exposure value comp, 1 means normal",
				default = "1",
			},
		},
	},
	
	{
		name = "unit_terrain_camo",
		help = "unit shaders can blend the underlying terrain (dirt, grass, etc) onto themselves",
		parameters =
		{
			{
				name = "amount",
				help = "how much of the underlying terrain to apply to this object. range 0 to 1",
				default = "0.0",
			},
		},
	},	
	
	{
		name = "animator_forceanimate",
		help = "force units that are offscreen or otherwise wouldn't animate to animate",
		parameters =
		{
			{
				name = "enable",
				help = "whether or not to enable forced animations for this object",
				default = "false",
				values =
				{
					"true",
					"false",
				},
			},
		},
	},	
	
	{
		name = "set_overlay_colour",
		parameters =
		{
			{
				name = "enable",
				help = "If overlay colour is on or off.",
				default = "off",
				values =
				{
					"off",
					"on",
				},	
			},
			{
				name = "applyToSelectablePartsOnly",
				help = "True to apply overlay colour to self and children with UISelection components.",
				default = "true",
				values =
				{
					"true",
					"false",
				},	
			},
			{
				name = "colour R",
				help = "Red channel of the colour(0-255)",
				default = "255",
			},
			{
				name = "colour G",
				help = "Green channel of the colour(0-255)",
				default = "255",
			},
			{
				name = "colour B",
				help = "Blue channel of the colour(0-255)",
				default = "255",
			},
			{
				name = "opacity",
				help = "Opacity(0-255)",
				default = "255",
			},
		}
	},
	
}
