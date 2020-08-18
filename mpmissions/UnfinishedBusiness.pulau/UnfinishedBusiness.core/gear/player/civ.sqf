
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

private _role = roleDescription player;
_role = (_role splitString "@") select 0;

if (_role == "Deserter (AOC)") then {
	player setVariable ["weapon_fiered", false, false];
	player setUnitLoadout (configFile >> "CfgVehicles" >> ([east, D_FRACTION_EAST, "Rifleman"] call Fn_Config_GetFraction_Units));
} else {
	if (_role == "Deserter (NPG)") then {
		player setVariable ["weapon_fiered", false, false];
		player setUnitLoadout (configFile >> "CfgVehicles" >> (selectRandom([independent, D_FRACTION_INDEP, "patrol"] call Fn_Config_GetFraction_Units)));
	} else {
		player setUnitLoadout (configFile >> "CfgVehicles" >> (selectRandom([civilian, D_FRACTION_CIV, "mens"] call Fn_Config_GetFraction_Units)));
	};
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


player addBackpack "B_FieldPack_oucamo";

switch (_role) do {
	case "Rebel Leader": {
		for "_i" from 1 to 3 do {player addItemToBackpack "CUP_7Rnd_50AE_Deagle";};
		player addItemToBackpack "CUP_HandGrenade_M67";
		player addItemToBackpack "CUP_hgun_Deagle";
	};
	case "Dep. Rebel Leader": {
		for "_i" from 1 to 3 do {player addItemToBackpack "CUP_30Rnd_45ACP_MAC10_M";};
		player addItemToBackpack "CUP_HandGrenade_M67";
		player addItemToBackpack "CUP_hgun_Mac10";
	};
	case "Doctor": {
		for "_i" from 1 to 3 do {player addItemToBackpack "CUP_6Rnd_45ACP_M";};
		player addItemToBackpack "CUP_HandGrenade_M67";
		player addItemToBackpack "CUP_hgun_TaurusTracker455";
	};
	case "Mechanic": {
		for "_i" from 1 to 3 do {player addItemToBackpack "CUP_8Rnd_B_Beneli_74Slug";};
		player addItemToBackpack "CUP_HandGrenade_M67";
		player addItemToBackpack "CUP_sgun_M1014";
	};
	case "Demolishion man": {
		for "_i" from 1 to 3 do {player addItemToBackpack "CUP_8Rnd_9x18_Makarov_M man";};
		player addItemToBackpack "CUP_HandGrenade_M67";
		player addItemToBackpack "IEDUrbanSmall_Remote_Mag";
		player addItemToBackpack "CUP_IED_V1_M";
		player addItemToBackpack "ACE_Clacker";
		player addItemToBackpack "CUP_hgun_Makarov";
	};
	case "Hunter": {
		for "_i" from 1 to 6 do {player addItemToBackpack "CUP_5x_22_LR_17_HMR_M";};
		player addItemToBackpack "CUP_HandGrenade_M67";
		player addItemToBackpack "CUP_srifle_CZ550";
	};
	case "Pilot": {
		for "_i" from 1 to 3 do {player addItemToBackpack "CUP_15Rnd_9x19_M9";};
		player addItemToBackpack "CUP_HandGrenade_M67";
		player addItemToBackpack "CUP_hgun_M9";
	};
	case "Policeman": {
		player addItemToBackpack "CUP_arifle_AKS74U";
		for "_i" from 1 to 3 do {player addItemToBackpack "CUP_30Rnd_545x39_AK74_plum_M";};
		player addItemToBackpack "CUP_HandGrenade_M67";
	};
	case "Deserter (NPG)": {
	
	};
	case "Deserter (AOC)": {
	
	};
	default {
		for "_i" from 1 to 3 do {player addItemToBackpack "16Rnd_9x21_Mag";};
		player addItemToBackpack "CUP_HandGrenade_M67";
		player addItemToBackpack "hgun_P07_F";
	};
};

if (D_MOD_ACEX) then {
	player addItemToUniform selectRandom(["ACE_MRE_BeefStew",
										"ACE_MRE_ChickenTikkaMasala",
										"ACE_MRE_ChickenHerbDumplings",
										"ACE_MRE_CreamChickenSoup",
										"ACE_MRE_LambCurry",
										"ACE_MRE_MeatballsPasta",
										"ACE_MRE_CreamTomatoSoup",
										"ACE_MRE_SteakVegetables"]);								
	player addItemToUniform "ACE_WaterBottle";
};

//Set identity
player setSpeaker "NoVoice";
