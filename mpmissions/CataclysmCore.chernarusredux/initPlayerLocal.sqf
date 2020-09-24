
waitUntil { !isNull player }; // Wait for player to initialize

{if (_x find "wp_poi_" >= 0) then {_x setMarkerAlphaLocal 0;}} forEach allMapMarkers;

[] call BIS_fnc_showMissionStatus;
