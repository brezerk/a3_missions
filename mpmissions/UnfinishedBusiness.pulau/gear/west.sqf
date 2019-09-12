
waitUntil { sleep 1; systemChat "Wait for sync..."; call Fn_Local_WaitPublicVariables; }; 

comment "Exported from Arsenal by brezerk";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local player) exitWith {};

comment "Remove existing items";
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

comment "Add containers";
if (mission_plane_send) then {
	player forceAddUniform "CUP_U_B_USArmy_Base";
	player addHeadgear "CUP_H_USArmy_HelmetMICH";
	player addVest "CUP_V_B_IOTV_Rifleman";
	player addBackpack "CUP_B_AssaultPack_ACU";
} else {
	player forceAddUniform "CUP_U_B_FR_DirAction";
	player addHeadgear "CUP_H_FR_ECH";
	player addVest "CUP_V_B_RRV_DA1";
	player addBackpack "B_Parachute";
};

for "_i" from 1 to 2 do {player addItemToVest "ACE_epinephrine";};
for "_i" from 1 to 15 do {player addItemToVest "ACE_fieldDressing";};
for "_i" from 1 to 5 do {player addItemToVest "ACE_morphine";};
for "_i" from 1 to 5 do {player addItemToVest "CUP_30Rnd_556x45_Stanag";};
player addItemToUniform "CUP_NVG_PVS7";
for "_i" from 1 to 5 do {player addItemToUniform "CUP_30Rnd_556x45_Stanag";};
player addItemToUniform "SmokeShell";

for "_i" from 1 to 2 do {player addItemToVest "CUP_HandGrenade_M67";};
player addItemToVest "SmokeShellPurple";
for "_i" from 1 to 2 do {player addItemToVest "CUP_7Rnd_45ACP_1911";};


comment "Add weapons";
player addWeapon "CUP_arifle_M4A1_camo";
player addPrimaryWeaponItem "CUP_optic_CompM2_Woodland";
player addWeapon "CUP_hgun_Colt1911";
player addWeapon "Binocular";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";

comment "Give player a radio depending on radio mod loaded";
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
	player addItemToVest "ACRE_PRC343";
	player addItemToVest "ACRE_PRC152";
} else {
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		player linkItem "tf_anprc152";
	} else {
		comment "Fallback to native arma3 radio";
		player linkItem "ItemRadio";
	};
};

player linkItem "ItemGPS";

comment "Add ACEX";
if (isClass(configFile >> "CfgPatches" >> "acex_main")) then {
	player addItemToVest "ACE_Canteen";
	for "_i" from 1 to 2 do {player addItemToBackpack "ACE_MRE_ChickenTikkaMasala";};
};

comment "Set identity";
player setSpeaker "NoVoice";
