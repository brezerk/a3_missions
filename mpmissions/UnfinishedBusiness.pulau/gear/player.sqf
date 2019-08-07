
params ["_diffclty"];

private _chance_lost_primary = 0;
private _chance_lost_primary_attachments = 0;
private _chance_lost_primary_ammo = 0;
private _chance_lost_radio = 0;
private _chance_lost_map = 0;

switch(_diffclty) do {
	case 0: {
		_chance_lost_primary = 30;
		_chance_lost_primary_ammo = 50;
		_chance_lost_primary_attachments = 40;
		_chance_lost_radio = 60;
		_chance_lost_map = 0;
	};
	case 1: {
		_chance_lost_primary = 60;
		_chance_lost_primary_ammo = 80;
		_chance_lost_primary_attachments = 40;
		_chance_lost_radio = 80;
		_chance_lost_map = 0;
	};
	case 2: {
		_chance_lost_primary = 100;
		_chance_lost_primary_ammo = 100;
		_chance_lost_primary_attachments = 100;
		_chance_lost_radio = 100;
		_chance_lost_map = 100;
	};
};

comment "Exported from Arsenal by brezerk";

//comment "[!] UNIT MUST BE LOCAL [!]";
//if (!local player) exitWith {};

private _pWeap = primaryWeapon player;
private _pWeapMagazine = primaryWeaponMagazine player;
private _pWeapItems = primaryWeaponItems player;

private _hWeap = handgunWeapon player;
private _hWeapMagazine = handgunMagazine player;
private _hWeapItems = handgunItems player; 

player removeWeapon _pWeap;

{
	if (_x in _pWeapMagazine) then {
		if ((random 100) <= _chance_lost_primary_ammo) then {	
			player removeMagazine _x;
		};
	};
} forEach magazines player;

if ((random 100) > _chance_lost_primary) then {
	player addWeapon _pWeap;
} else {
	{
		if ((random 100) > _chance_lost_primary_attachments) then {
			player addPrimaryWeaponItem _x;
		};
	} forEach _pWeapItems;
};

if ((random 100) <= _chance_lost_map) then {
	player unassignItem "ItemMap";
	player removeItem "ItemMap";
};

player unassignItem "ItemCompass";
player removeItem "ItemCompass";

if ((random 100) <= _chance_lost_radio) then {
	if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
		player unassignItem "ACRE_PRC152";
		player removeItem "ACRE_PRC152";
	} else {
		if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
			player unassignItem "tf_anprc152";
			player removeItem "tf_anprc152";
		} else {
			comment "Fallback to native arma3 radio";
			player unassignItem "ItemRadio";
			player removeItem "ItemRadio";
		};
	};
};

sleep 1;

player action ["openParachute", player];
