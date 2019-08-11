
waitUntil { !isNull player }; // Wait for player to initialize

comment "Exported from Arsenal by brezerk";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _this) exitWith {};

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add weapons";
_this addWeapon "CUP_arifle_M4A1_BUIS_GL";
_this addPrimaryWeaponItem "CUP_acc_ANPEQ_2";
_this addPrimaryWeaponItem "CUP_optic_CompM2_Black";
_this addPrimaryWeaponItem "CUP_30Rnd_556x45_Stanag";
_this addPrimaryWeaponItem "CUP_1Rnd_HE_M203";
_this addWeapon "CUP_hgun_M9";
_this addHandgunItem "CUP_muzzle_snds_M9";
_this addHandgunItem "CUP_15Rnd_9x19_M9";

comment "Add containers";
_this forceAddUniform "CUP_U_B_USMC_MARPAT_WDL_Sleeves";
_this addVest "CUP_V_B_MTV_noCB";
_this addBackpack "B_Parachute";

comment "Add binoculars";
_this addWeapon "Binocular";

comment "Add items to containers";
for "_i" from 1 to 10 do {_this addItemToUniform "ACE_fieldDressing";};
_this addItemToUniform "ACE_Canteen";
_this addItemToUniform "ACE_EarPlugs";
_this addItemToUniform "ACE_epinephrine";
for "_i" from 1 to 5 do {_this addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {_this addItemToVest "CUP_HandGrenade_M67";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellRed";};
for "_i" from 1 to 2 do {_this addItemToUniform "ACE_Chemlight_UltraHiOrange";};
for "_i" from 1 to 2 do {_this addItemToVest "CUP_15Rnd_9x19_M9";};
for "_i" from 1 to 6 do {_this addItemToVest "CUP_1Rnd_HE_M203";};
for "_i" from 1 to 4 do {_this addItemToVest "CUP_30Rnd_556x45_Stanag";};
_this addHeadgear "CUP_H_USMC_Headset_GoggleW_HelmetWDL";
_this addItemToUniform "ACE_DefusalKit";
for "_i" from 1 to (random 15) do {_this addItemToUniform "ACE_Banana";};

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";

comment "Give player a radio depending on radio mod loaded";
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
	_this unassignItem "ItemRadio";
	_this removeItem "ItemRadio";
	_this addWeapon "ACRE_PRC152";
} else {
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		_this linkItem "tf_anprc152";
	} else {
		comment "Fallback to native arma3 radio";
		_this linkItem "ItemRadio";
	};
};

comment "Add nvg";
_this linkItem "CUP_NVG_PVS7";

comment "Set identity";
_this setSpeaker "NoVoice";
