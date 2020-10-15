
waitUntil { !isNull player }; // Wait for player to initialize

{if (_x find "wp_poi_" >= 0) then {_x setMarkerAlphaLocal 0;}} forEach allMapMarkers;

switch (side player) do {
	case west: {
		"respawn_west_start" setMarkerAlphaLocal 1;
		"respawn_east_start" setMarkerAlphaLocal 0;
		"respawn_guer_start" setMarkerAlphaLocal 0;
	};
	case east: {
		"respawn_west_start" setMarkerAlphaLocal 0;
		"respawn_east_start" setMarkerAlphaLocal 1;
		"respawn_guer_start" setMarkerAlphaLocal 0;
	};
	case independent: {
		"respawn_west_start" setMarkerAlphaLocal 0;
		"respawn_east_start" setMarkerAlphaLocal 0;
		"respawn_guer_start" setMarkerAlphaLocal 1;
	};
	default {
		"respawn_west_start" setMarkerAlphaLocal 0;
		"respawn_east_start" setMarkerAlphaLocal 0;
		"respawn_guer_start" setMarkerAlphaLocal 0;
	};
};

execVM "briefing.sqf";

waitUntil { alive player };

[] call BIS_fnc_showMissionStatus;

execVM format["gear\%1\%2.sqf", (str (side player)), (roleDescription player)];

Fn_Local_Zombies = {
	[emp_me,500,true,true,0] execVM 'AL_emp\emp_starter.sqf';
	//systemChat "They ware coming!";
};

0 = [] spawn {
	private _pos = getMarkerPos "poi_lug";
	while {true} do {
		waitUntil { alive player };
		if ((player distance2D _pos) <= 400) then {
			if ((player distance2D obj_target_x25) > 30) then {
				if ((player distance2D _pos) <= 300) then {
					player setDamage 1;
				} else {
					titleText ["<t color='#ff0000' size='5'>У вас немає X25. Повертайте назад!</t>", "PLAIN", -1, true, true];
				};
			};
		};
		sleep 3;
	};
};

//[[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
//[[-2], [-1,0,1,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes;

player addEventHandler
[
	"Killed",
	{
		private _respawnDelay = 480;
		setPlayerRespawnTime (_respawnDelay - (servertime % _respawnDelay));
	}
];