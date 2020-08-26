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

while {true} do {
	sleep (D_PERSISTANCE_SAVE_DELAY - (servertime % D_PERSISTANCE_SAVE_DELAY));
	["Saving..."] call NECK_fnc_Logger;
	private _PERSISTANCE_DB = [];
	{
		if (!isNull _x) then {
			if (alive _x) then {
				[format["Generating cache for container %1",_x]] call NECK_fnc_Logger;
				private _content = [];
				_content pushBackUnique ['items',(getItemCargo _x)];
				_content pushBackUnique ['ammo',(getMagazineCargo _x)];
				_content pushBackUnique ['weapon',(getWeaponCargo _x)];
				_content pushBackUnique ['backpack',(getBackpackCargo _x)]; 
				_PERSISTANCE_DB pushBackUnique [(str _x),_content];
			} else {
				["Dead skipping..."] call NECK_fnc_Logger;
			};
		} else {
			["Null skipping..."] call NECK_fnc_Logger;
		};
	} forEach D_PERSISTANCE_OBJECTS;
	profileNamespace setVariable ["bb_persistance", _PERSISTANCE_DB];
	["Generated. Saving to profile..."] call NECK_fnc_Logger;
	saveProfileNamespace;
	["Saved to profile."] call NECK_fnc_Logger;
};
true;
