
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
private _role = (roleDescription player);

if (mission_plane_send) then {
	_class = format ["rescue_%1", _role];
} else {
	_class = _role;
};

player setUnitLoadout (configFile >> "CfgVehicles" >> ([west, D_FRACTION_WEST, _class] call Fn_Config_GetFraction_Units));

//Give medic trait
if (_role in ["Corpsman", "Recon Paramedic", "SpecOps Paramedic"]) then {
	if (D_MOD_ACE) then {
		player setVariable ["ace_medical_medicclass", 1, true];
	} else {
		player setUnitTrait ["Medic", true];
	};
};

//Make SpecOps harder to detect
if ((_role find "SpecOps ") >= 0) then {
	player setUnitTrait ["camouflageCoef ", 0.3];
	player setUnitTrait ["audibleCoef ", 0.3];
};

//Make recons harder to detect
if ((_role find "Recon ") >= 0) then {
	player setUnitTrait ["camouflageCoef ", 0.7];
	player setUnitTrait ["audibleCoef ", 0.7];
};

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

//If node defaul hgun, give one
if (handgunWeapon player == "") then {
	private _base_hgun = ([west, D_FRACTION_WEST, "base_hgun"] call Fn_Config_GetFraction_Units);
	private _base_hgun_ammo = (_base_hgun select 1);
	player addWeapon (_base_hgun select 0);
	player addHandgunItem _base_hgun_ammo;
	for "_i" from 1 to 2 do {player addItemToVest _base_hgun_ammo;};
};

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

sleep 1;

// Give player a radio depending on radio mod loaded
if (D_MOD_ACRE) then {
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
	if (D_MOD_TFAR) then {
		// add specific one
		player linkItem "tf_anprc152";
		// remove default radio
		player unassignItem "ItemRadio";
		player removeItem "ItemRadio";
	} else {
		player linkItem "ItemRadio";
	};
};
