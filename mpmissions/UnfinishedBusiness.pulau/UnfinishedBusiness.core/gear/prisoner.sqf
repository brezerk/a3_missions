
private _hWeap = handgunWeapon player;
private _hWeapMagazine = (handgunMagazine player) # 0;

comment "Remove existing items";
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

comment "Add containers";
//player addGoggles "G_Blindfold_01_white_F";
player addItemToUniform _hWeap;
player addItemToUniform _hWeapMagazine;
player addItemToUniform _hWeapMagazine;

if (D_MOD_ACE) then {
	player addItemToUniform "ACE_EarPlugs";
	player addItemToUniform "ACE_tourniquet";
	player addItemToUniform "ACE_fieldDressing";
	player addItemToUniform "ACE_fieldDressing";
} else {
	player addItemToUniform "Medikit";
};
