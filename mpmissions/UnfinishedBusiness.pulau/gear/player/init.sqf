
// UNIT MUST BE LOCAL
if (!local player) exitWith {};

//Remove existing items (if any)
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

//FIXME: Possible use another uniform for rescue squad if plane was sent already
player setUnitLoadout (configFile >> "CfgVehicles" >> ([west, D_FRACTION_WEST, (roleDescription player)] call Fn_Config_GetFraction_Units));

comment "Give player a radio depending on radio mod loaded";
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
	player unassignItem "ItemRadio";
	player removeItem "ItemRadio";
	player addItemToVest "ACRE_PRC152";
} else {
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		player linkItem "tf_anprc152";
	} else {
		comment "Fallback to native arma3 radio";
		player linkItem "ItemRadio";
	};
};

// If plane was not sent yet -- give player a parashute
if (!mission_plane_send) then {
	removeBackpack player;
	player addBackpack "B_Parachute";
};

// Kick GPS if any
player unassignItem "ItemGPS";
player removeItem "ItemGPS";

//Set identity
player setSpeaker "NoVoice";
