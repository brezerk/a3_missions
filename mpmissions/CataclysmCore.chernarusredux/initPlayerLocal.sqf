

waitUntil { !isNull player }; // Wait for player to initialize

{if (_x find "wp_poi_" >= 0) then {_x setMarkerAlphaLocal 0;}} forEach allMapMarkers;

waitUntil { alive player };

[] call BIS_fnc_showMissionStatus;

execVM format["gear\%1\%2.sqf", (str (side player)), (roleDescription player)];