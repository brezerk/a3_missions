
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
player forceAddUniform "CUP_U_B_FR_DirAction";
for "_i" from 1 to 2 do {player addItemToVest "ACE_epinephrine";};
for "_i" from 1 to 15 do {player addItemToVest "ACE_fieldDressing";};
for "_i" from 1 to 5 do {player addItemToVest "ACE_morphine";};
player addItemToUniform "CUP_NVG_PVS7";
for "_i" from 1 to 5 do {player addItemToUniform "CUP_30Rnd_556x45_Stanag";};
player addItemToUniform "SmokeShell";
player addVest "CUP_V_B_RRV_DA1";
for "_i" from 1 to 2 do {player addItemToVest "CUP_HandGrenade_M67";};
player addItemToVest "SmokeShellPurple";
for "_i" from 1 to 3 do {player addItemToVest "CUP_7Rnd_45ACP_1911";};
player addHeadgear "CUP_H_FR_ECH";

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
	player addItemToVest "ACRE_SEM52SL";
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
player addItemToVest "ACE_Canteen";
for "_i" from 1 to 5 do {player addItemToBackpack "ACE_MRE_ChickenTikkaMasala";};

comment "Set identity";
player setSpeaker "NoVoice";
