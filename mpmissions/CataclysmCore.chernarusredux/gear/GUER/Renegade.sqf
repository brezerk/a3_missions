
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
player addWeapon "CUP_SKS_rail";
player addPrimaryWeaponItem "CUP_optic_LeupoldMk4";
player addPrimaryWeaponItem "CUP_10Rnd_762x39_SKS_M";

comment "Add containers";
player forceAddUniform "U_FRITH_RUIN_SDR_snip_bld";
player addVest "FRITH_ruin_vestia_lite_ghm";
player addBackpack "CL_AssaultPack_01";

comment "Add binoculars";
player addWeapon "Binocular";

comment "Add items to containers";
player addItemToVest "ACE_EarPlugs";
for "_i" from 1 to 6 do {player addMagazine "CL_Rounds_CUP_B_762x39_Ball";};
player addItemToVest "CUP_HandGrenade_RGD5";
for "_i" from 1 to 2 do {player addItemToVest "rvg_flare";};
player addItemToVest "ACE_M84";
player addItemToVest "ChemicalDetector_01_watch_F";
player addItemToBackpack "ACE_Clacker";
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_bloodIV_500";};
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 10 do {player addItemToBackpack "ACE_fieldDressing";};
player addItemToBackpack "ACE_EntrenchingTool";
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_adenosine";};
player addItemToBackpack "ACE_epinephrine";
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_tourniquet";};
for "_i" from 1 to 3 do {player addMagazine "CUP_10Rnd_762x39_SKS_M";};
player addItemToBackpack "CUP_PipeBomb_M";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemRadio";

comment "Set identity";
player setSpeaker "NoVoice";
