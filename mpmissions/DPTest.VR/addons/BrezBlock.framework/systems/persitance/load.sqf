/***************************************************************************************
 * Copyright (C) 2008-2020 by Oleksii S. Malakhov <brezerk@gmail.com>                  *
 *                                                                                     *
 * This program is is licensed under a                                                 *
 * Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. *
 *                                                                                     *
 * You should have received a copy of the license along with this                      *
 * work. If not, see <http://creativecommons.org/licenses/by-nc-nd/4.0/>.              *
 *                                                                                     *
 **************************************************************************************/

["Loading from profile..."] call NECK_fnc_Logger;
private _PERSISTANCE_DB = profileNamespace getVariable ["bb_persistance", []];
[format["Loaded objects: %1", (count _PERSISTANCE_DB)]] call NECK_fnc_Logger;
{
	private _object = missionNamespace getVariable [(_x # 0), objNull];
	if (!isNull _object) then {
		[format["Populating: %1", _object]] call NECK_fnc_Logger;
		if (alive _object) then {
			clearWeaponCargoGlobal _object;
			clearMagazineCargoGlobal _object;
			clearItemCargoGlobal _object;
			clearBackpackCargoGlobal _object;
			private _content = _x # 1;
			{
				private _cat = _x # 0;
				private _items = _x # 1 # 0;
				private _count = _x # 1 # 1;
				{
					switch (_cat) do {
						case 'items': {_object addItemCargoGlobal [_x, _count # _forEachIndex]};
						case 'ammo': {_object addMagazineCargoGlobal [_x, _count # _forEachIndex]};
						case 'weapon': {_object addWeaponCargoGlobal [_x, _count # _forEachIndex]};
						case 'backpack': {_object addBackpackCargoGlobal [_x, _count # _forEachIndex]};
					};
					[format["Item: %1", _x]] call NECK_fnc_Logger;
				} forEach _items;
			} count _content;
		} else {
			["Dead skipping..."] call NECK_fnc_Logger;
		};
	} else {
		["Null skipping..."] call NECK_fnc_Logger;
	};
} forEach _PERSISTANCE_DB;
["Done."] call NECK_fnc_Logger;
