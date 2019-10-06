
params ["_diffclty"];

private _chance_lost_primary = 0;
private _chance_lost_primary_attachments = 0;
private _chance_lost_primary_ammo = 0;
private _chance_lost_radio = 0;
private _chance_lost_map = 0;
private _chance_lost_compass = 0;

switch(_diffclty) do {
	case 0: {
		_chance_lost_primary = 40;
		_chance_lost_primary_ammo = 50;
		_chance_lost_primary_attachments = 40;
		_chance_lost_radio = 60;
		_chance_lost_map = 0;
		_chance_lost_compass = 100;
	};
	case 1: {
		_chance_lost_primary = 60;
		_chance_lost_primary_ammo = 80;
		_chance_lost_primary_attachments = 40;
		_chance_lost_radio = 80;
		_chance_lost_map = 50;
		_chance_lost_compass = 50;
	};
	case 2: {
		_chance_lost_primary = 100;
		_chance_lost_primary_ammo = 100;
		_chance_lost_primary_attachments = 100;
		_chance_lost_radio = 100;
		_chance_lost_map = 100;
		_chance_lost_compass = 0;
	};
};

comment "Exported from Arsenal by brezerk";

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

if ((random 100) <= _chance_lost_compass) then {
	player unassignItem "ItemCompass";
	player removeItem "ItemCompass";
};

if ((random 100) <= _chance_lost_radio) then {
	if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
		{
			if (_x find "ACRE_" >= 0 ) then {
				player unassignItem _x;
				player removeItem _x;
			};
		} forEach (items player);
	} else {
		if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
			if (_x find "tf_" >= 0 ) then {
				player unassignItem _x;
				player removeItem _x;
			};
		} else {
			comment "Fallback to native arma3 radio";
			player unassignItem "ItemRadio";
			player removeItem "ItemRadio";
		};
	};
};

waitUntil {sleep 1; getPosATL player select 2 <= 300};

player action ["openParachute", player];
