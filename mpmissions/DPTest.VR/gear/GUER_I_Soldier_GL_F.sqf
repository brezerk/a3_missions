
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
_this forceAddUniform "U_I_CombatUniform";
_this addVest "V_Press_F";
_this addHeadgear "H_Bandanna_surfer_blk";

comment "Add weapons";
_this addWeapon "arifle_Katiba_F";
_this addPrimaryWeaponItem "30Rnd_65x39_caseless_green";

comment "Set identity";
[_this,"GreekHead_A3_06","male02gre"] call BIS_fnc_setIdentity;
