
params ["_this"];

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

comment "Add containers";
_this forceAddUniform "U_C_Man_casual_1_F";
_this addVest "V_BandollierB_cbr";
for "_i" from 1 to 10 do {_this addItemToVest "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_this addItemToVest "ACE_morphine";};
for "_i" from 1 to 5 do {_this addItemToVest "CUP_30Rnd_545x39_AK_M";};
_this addBackpack "B_FieldPack_oucamo";
_this addHeadgear "H_Bandanna_surfer_blk";
_this addGoggles "G_Bandanna_khk";

comment "Add weapons";
_this addWeapon "CUP_arifle_AK74_Early";

comment "Add items";
_this linkItem "ItemRadio";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";

