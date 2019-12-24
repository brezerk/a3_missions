
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

_this setUnitLoadout (configFile >> "CfgVehicles" >> (selectRandom([civilian, D_FRACTION_CIV, "mens"] call Fn_Config_GetFraction_Units)));

private _class = selectRandom([civilian, D_FRACTION_CIV, "rebel_weapons"] call Fn_Config_GetFraction_Units);

comment "Add weapons";
_this addWeapon _class;

private _pWeapMagazines = primaryWeaponMagazine _this;

_this addVest (selectRandom([civilian, D_FRACTION_CIV, "rebel_armor"] call Fn_Config_GetFraction_Units));

{
	for "_i" from 1 to 5 do {_this addItemToVest "CUP_30Rnd_545x39_AK_M";};
} forEach _pWeapMagazines;
for "_i" from 1 to 10 do {_this addItemToVest "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_this addItemToVest "ACE_morphine";};
for "_i" from 1 to 5 do {_this addItemToVest "CUP_30Rnd_545x39_AK_M";};

_this addBackpack (selectRandom([civilian, D_FRACTION_CIV, "rebel_backpack"] call Fn_Config_GetFraction_Units));

comment "Add items";
_this linkItem "ItemRadio";
_this linkItem "ItemCompass";


