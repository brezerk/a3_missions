

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
player forceAddUniform "U_FRITH_RUIN_sdr_fab_rs";
player addBackpack selectRandom["CL_AssaultPack_med", "CL_AssaultPack_ua_med"];

comment "Add items to containers";
player addItemToUniform "ACE_EarPlugs";
player addHeadgear "CUP_H_PMC_Beanie_Black";
player addGoggles selectRandom["rvg_balaclava_1", "rvg_bandana_4", "rvg_bandana_3", "rvg_bandana_2", "rvg_bandana_1", "rvg_balaclava_5", "CUP_G_Scarf_Face_Red", "G_Bandanna_khk"];

for "_i" from 1 to 2 do {player addItemToBackpack "ACE_MRE_CreamChickenSoup";};
player addItemToUniform "ACE_Canteen";
player addItemToUniform "ACE_Flashlight_KSF1";
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_fieldDressing";};
player addItemToBackpack "ACE_tourniquet";
player addItemToBackpack "CL_Antidote";
player addItemToBackpack "ACE_personalAidKit";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_CableTie";};
for "_i" from 1 to 2 do {player addItemToBackpack "CUP_8Rnd_9x18_Makarov_M";};
for "_i" from 1 to 3 do {player addItemToBackpack "CL_Rounds_CUP_B_9x18_Ball";};
for "_i" from 1 to 2 do {player addItemToBackpack "rvg_flare";};
player addItemToBackpack "CL_PainKillers";

for "_i" from 1 to 2 do {player addItemToBackpack "ACE_bloodIV_500";};
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 6 do {player addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 2 do {player addItemToBackpack "CL_Antidote";};
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_adenosine";};
player addItemToBackpack "ACE_epinephrine";
for "_i" from 1 to 2 do {player addItemToBackpack "CL_AntiradinBag";};

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";

comment "Set identity";
player setSpeaker "NoVoice";
