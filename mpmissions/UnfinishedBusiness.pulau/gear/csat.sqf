
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
player forceAddUniform "U_O_CombatUniform_ocamo";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 3 do {player addItemToUniform "ACE_CableTie";};
for "_i" from 1 to 5 do {player addItemToUniform "ACE_morphine";};
for "_i" from 1 to 15 do {player addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {player addItemToUniform "30Rnd_65x39_caseless_green";};
player addVest "V_HarnessO_brn";
for "_i" from 1 to 7 do {player addItemToVest "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
player addItemToVest "SmokeShell";
player addItemToVest "SmokeShellRed";
for "_i" from 1 to 2 do {player addItemToVest "Chemlight_red";};
player addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
player addWeapon "arifle_Katiba_F";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_ACO_grn";
player addWeapon "hgun_Rook40_F";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";

comment "Add ACEX";
player addItemToVest "ACE_Canteen";

comment "Set identity";
[player,"PersianHead_A3_02","male01per"] call BIS_fnc_setIdentity;
player setSpeaker "NoVoice";
