
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
player addWeapon "CUP_hgun_Makarov";
player addHandgunItem "CUP_8Rnd_9x18_Makarov_M";

comment "Add containers";
player forceAddUniform "U_FRITH_RUIN_coffdpm";
player addBackpack selectRandom["CL_AssaultPack_gray", "CL_AssaultPack_drk", "CL_AssaultPack_ptnh"];

comment "Add items to containers";
player addItemToUniform "ACE_EarPlugs";
player addHeadgear "CUP_H_TKI_Pakol_1_01";
player addGoggles selectRandom["rvg_balaclava_1", "rvg_bandana_4", "rvg_bandana_3", "rvg_bandana_2", "rvg_bandana_1", "rvg_balaclava_5", "CUP_G_Scarf_Face_Red", "G_Bandanna_khk"];

for "_i" from 1 to 2 do {player addItemToBackpack "ACE_MRE_CreamChickenSoup";};
player addItemToUniform "ACE_Canteen";
player addItemToUniform "ACE_Flashlight_KSF1";
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_fieldDressing";};
player addItemToBackpack "ACE_tourniquet";
player addItemToBackpack "CL_Antidote";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_CableTie";};
for "_i" from 1 to 2 do {player addItemToBackpack "CUP_8Rnd_9x18_Makarov_M";};
for "_i" from 1 to 3 do {player addItemToBackpack "CL_Rounds_CUP_B_9x18_Ball";};
for "_i" from 1 to 2 do {player addItemToBackpack "rvg_flare";};
player addItemToBackpack "CL_PainKillers";


comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";

comment "Set identity";
player setSpeaker "NoVoice";
