
comment "Exported from Arsenal by [UkAZ]Brezerk";

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

comment "Add weapons";
_this addWeapon "arifle_Katiba_F";
_this addPrimaryWeaponItem "30Rnd_65x39_caseless_green";

comment "Set identity";
[_this,"GreekHead_A3_07","male06gre"] call BIS_fnc_setIdentity;
