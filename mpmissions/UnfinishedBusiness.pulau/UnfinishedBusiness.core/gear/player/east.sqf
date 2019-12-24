
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
//FIXME: Possible check player side
player setUnitLoadout (configFile >> "CfgVehicles" >> ([east, D_FRACTION_EAST, (roleDescription player)] call Fn_Config_GetFraction_Units));

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

if (D_MOD_ACE) then {
	player addItemToUniform "ACE_EarPlugs";
};

if (D_MOD_ACEX) then {
	for "_i" from 1 to 2 do {
		player addItemToVest selectRandom(["ACE_MRE_BeefStew",
										"ACE_MRE_ChickenTikkaMasala",
										"ACE_MRE_ChickenHerbDumplings",
										"ACE_MRE_CreamChickenSoup",
										"ACE_MRE_LambCurry",
										"ACE_MRE_MeatballsPasta",
										"ACE_MRE_CreamTomatoSoup",
										"ACE_MRE_SteakVegetables"]);
	};								
	player addItemToVest "ACE_Canteen";
};

//Set identity
player setSpeaker "NoVoice";

sleep 1;

comment "Give player a radio depending on radio mod loaded";
if (D_MOD_ACRE) then {
	player unassignItem "ItemRadio";
	player removeItem "ItemRadio";
	player addItemToVest "ACRE_SEM52SL";
} else {
	if (D_MOD_TFAR) then {
		player linkItem "TFAR_fadak";
	} else {
		comment "Fallback to native arma3 radio";
		player linkItem "ItemRadio";
	};
};
