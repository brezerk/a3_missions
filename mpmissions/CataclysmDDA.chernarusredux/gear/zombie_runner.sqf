
comment "Exported from Arsenal by Brezerk";

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
player forceAddUniform "U_C_rvg_hood_bandit";

comment "Set identity";
[player,"rvg_zed_face_3","novoice"] call BIS_fnc_setIdentity;

