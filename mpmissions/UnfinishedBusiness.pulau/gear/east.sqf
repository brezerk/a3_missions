
comment "Exported from Arsenal by brezerk";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local player) exitWith {systemChat "not local?";};

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
player forceAddUniform "CUP_U_O_SLA_MixedCamo";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 2 do {player addItemToUniform "CUP_30Rnd_545x39_AK_M";};
player addVest "CUP_V_O_SLA_M23_1_OD";
for "_i" from 1 to 2 do {player addItemToVest "ACE_epinephrine";};
for "_i" from 1 to 15 do {player addItemToVest "ACE_fieldDressing";};
for "_i" from 1 to 5 do {player addItemToVest "ACE_morphine";};
for "_i" from 1 to 2 do {player addItemToVest "CUP_HandGrenade_RGD5";};
player addItemToVest "SmokeShell";
player addItemToVest "SmokeShellBlue";
for "_i" from 1 to 8 do {player addItemToVest "CUP_30Rnd_545x39_AK_M";};
player addBackpack "B_Kitbag_rgr";
player addItemToBackpack "ACE_bloodIV";
player addHeadgear "CUP_H_SLA_Boonie";
player addGoggles "CUP_G_Oakleys_Clr";

comment "Add weapons";
player addWeapon "CUP_arifle_AK74";
player addPrimaryWeaponItem "CUP_optic_Kobra";
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

comment "Add ACEX";
if (isClass(configFile >> "CfgPatches" >> "acex_main")) then {
	player addItemToVest "ACE_Canteen";
	for "_i" from 1 to 2 do {player addItemToBackpack "ACE_MRE_ChickenTikkaMasala";};
};

comment "Set identity";
[player,"WhiteHead_14","male03gre"] call BIS_fnc_setIdentity;
player setSpeaker "NoVoice";
