
// UNIT MUST BE LOCAL
if (!local player) exitWith {};

// Remove existing items (if any)
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

private _class = "";

if (mission_plane_send) then {
	_class = format ["rescue_%1", (roleDescription player)];
} else {
	_class = (roleDescription player);
};

player setUnitLoadout (configFile >> "CfgVehicles" >> ([west, D_FRACTION_WEST, _class] call Fn_Config_GetFraction_Units));

// If plane was not sent yet -- give player a parashute
if (!mission_plane_send) then {
	removeBackpack player;
	player addBackpack "B_Parachute";
};

//Set identity
player setSpeaker "NoVoice";

// Kick GPS if any
player unassignItem "ItemGPS";
player removeItem "ItemGPS";

switch (D_NAVTOOL_MAP) do {
	case 1: { 
		if (!((roleDescription player) in ["Team Leader", "Squad Leader"])) then {
			player unassignItem "ItemMap";
			player removeItem "ItemMap";
		};
	};
	case 2: { 
		player unassignItem "ItemMap";
		player removeItem "ItemMap";
	};
};

switch (D_NAVTOOL_COMPASS) do {
	case 1: { 
		if (!((roleDescription player) in ["Team Leader", "Squad Leader"])) then {
			player unassignItem "ItemCompass";
			player removeItem "ItemCompass";
		};
	};
	case 2: { 
		player unassignItem "ItemCompass";
		player removeItem "ItemCompass";
	};
};

sleep 1;

// Give player a radio depending on radio mod loaded
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
	// remove default radio
	player unassignItem "ItemRadio";
	player removeItem "ItemRadio";
	// remove default radio
	{
		if (_x find "ACRE" >= 0) then {
			player unassignItem _x;
			player removeItem _x;
		};
	} forEach items player;
	// add specific one
	player addItemToVest "ACRE_PRC152";
} else {
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		// add specific one
		player linkItem "tf_anprc152";
		// remove default radio
		player unassignItem "ItemRadio";
		player removeItem "ItemRadio";
	} else {
		player linkItem "ItemRadio";
	};
};
