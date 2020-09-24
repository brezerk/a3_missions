
waitUntil { !isNull player }; // Wait for player to initialize
waitUntil { alive player };

[] call BIS_fnc_showMissionStatus;

execVM format["gear\%1\%2.sqf", (str (side player)), (roleDescription player)];
