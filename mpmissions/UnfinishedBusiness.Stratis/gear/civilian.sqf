
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
player forceAddUniform "U_C_Man_casual_1_F";

comment "Add weapons";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemWatch";

//player addItemToUniform "CUP_hgun_Colt1911";
//for "_i" from 1 to 3 do {player addItemToUniform "CUP_7Rnd_45ACP_1911";};

comment "Set identity";
[player,"Ioannou","male03gre"] call BIS_fnc_setIdentity;
player setSpeaker "NoVoice";