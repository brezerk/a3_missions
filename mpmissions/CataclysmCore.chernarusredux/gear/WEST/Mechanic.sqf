
comment "Exported from Arsenal by [UkAZ]Brezerk";

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

comment "Add weapons";
player addWeapon "CUP_SKS";
player addPrimaryWeaponItem "CUP_10Rnd_762x39_SKS_M";

comment "Add containers";
player forceAddUniform "U_FRITH_RUIN_sdr_fabgrn_rs";
player addVest "FRITH_ruin_vestia_lite_nja";
player addBackpack "CL_Carryall_khkua";

comment "Add items to containers";
player addItemToUniform "FirstAidKit";
player addItemToUniform "CUP_HandGrenade_RGD5";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 6 do {player addItemToVest "CUP_10Rnd_762x39_SKS_M";};
for "_i" from 1 to 2 do {player addItemToVest "CUP_HandGrenade_RGD5";};
for "_i" from 1 to 2 do {player addItemToVest "rvg_flare";};
player addItemToVest "CL_Matches";
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 10 do {player addItemToBackpack "ACE_fieldDressing";};
player addItemToBackpack "ToolKit";
player addItemToBackpack "ACE_EntrenchingTool";
player addItemToBackpack "CL_Axe";
player addHeadgear "CUP_H_C_Ushanka_01";
player addGoggles selectRandom["rvg_balaclava_1", "rvg_bandana_4", "rvg_bandana_3", "rvg_bandana_2", "rvg_bandana_1", "rvg_balaclava_5", "CUP_G_Scarf_Face_Red", "G_Bandanna_khk"];

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";

comment "Set identity";
player setSpeaker "NoVoice";
