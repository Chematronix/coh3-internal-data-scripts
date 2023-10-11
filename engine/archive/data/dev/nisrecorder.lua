
function NIS_AddSelectedToRecorder()

	local egroup;
	bExists = EGroup_Exists( "nisrecorder_e" );
	if ( bExists == false ) then
		egroup = EGroup_Create( "nisrecorder_e" );
	else
		egroup = EGroup_FromName( "nisrecorder_e" );
	end
	Misc_GetSelectedEntities( egroup );
	ecount = EGroup_Count( "nisrecorder_e" );

	if ecount > 0 then
		nis_addentitiestorecording( egroup );
	end
	
	local sgroup;
	bExists = SGroup_Exists( "nisrecorder_s" );
	if ( bExists == false ) then	
		sgroup = SGroup_Create( "nisrecorder_s" );
	else
		sgroup = SGroup_FromName( "nisrecorder_s" );
	end
	Misc_GetSelectedSquads( sgroup );
	scount = SGroup_Count( "nisrecorder_s" );

	if scount > 0 then
		nis_addsquadstorecording( sgroup );	
	end

	if ( ecount + scount ) == 0 then
	
		local entity = Misc_GetMouseOverEntity();
		if ( entity ~= 0 ) then
			nis_addentitytorecording( entity );
		end
	
	end
	
end


function NIS_BindKeys()

	bind( "CONTROL+SHIFT+A",    		"NIS_AddSelectedToRecorder()" );
	bind( "CONTROL+SHIFT+HOME", 		"nis_startrecording()" );
	bind( "CONTROL+SHIFT+END",  		"nis_stoprecording()" );
	bind( "CONTROL+SHIFT+P", 			"nis_play()" );
	bind( "CONTROL+SHIFT+S", 			"nis_stop()" );	

end