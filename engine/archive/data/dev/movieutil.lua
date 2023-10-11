function recordmoviestart( )

	-- lock to a steady 30 fps
	app_fixedframerate( 30 )
	capturemoviestart( 0 )
	
end

function recordmoviestartsmall( )

	-- lock to a steady 30 fps
	app_fixedframerate( 30 )
	capturemoviestart( 1 )
	
end

function recordmoviestop( )

	capturemoviestop()
	
	-- unlock framerate
	app_fixedframerate( 0 )

end

