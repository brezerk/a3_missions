
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

player setUnitLoadout (configFile >> "CfgVehicles" >> (selectRandom([civilian, D_FRACTION_CIV, "mens"] call Fn_Config_GetFraction_Units)));

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

//Set identity
player setSpeaker "NoVoice";
