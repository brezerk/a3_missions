/***************************************************************************
 *   Copyright (C) 2008-2019 by Oleksii S. Malakhov <brezerk@gmail.com>    *
 *                                                                         *
 *   This program is free software: you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation, either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 ***************************************************************************/

/*
Attach holdAction to vehicle and execute corresponding callback
	Arguments: [_attach_to, _call_back, _icon, _text (localized), _condition, _duration]
	Usage: [_obj, { _this systemChat "Hello!"; }] call BrezBlock_fnc_Attach_SearchInterl_Action;
	Return: _action_id of assigned action
*/
if (isServer) then {
	params ["_attach_to", "_call_back", ["_icon", "holdactions\holdAction_search"], ["_text", "ACTION_01"], ["_condition", ""], ["_duration", 6], ["_remove", true]];
	_action_id = [
		_attach_to,																// Object the action is attached to
		localize _text,					        								// Title of the action
		format ["\a3\ui_f\data\IGUI\Cfg\%1_ca.paa", _icon],						// Idle icon shown on screen
		format ["\a3\ui_f\data\IGUI\Cfg\%1_ca.paa", _icon],						// Progress icon shown on screen
		format ["(!alive _target) && ((_this distance _target) < 4) %1", _condition],		// Condition for the action to be shown
		format ["((_caller distance _target) < 4) %1", _condition],	            // Condition for the action to progress
		{},																		// Code executed when action starts
		{																		// Code executed on every progress tick
			private _target = _this select 0;
			private _caller = _this select 1;
			private _progress = _this select 4;
			private _pos = getPos _target;
			private _dir = getDir _caller;
			_pos = [_pos, 0.5, _dir] call BIS_Fnc_relPos;
			_pos = [_pos, 0.6, (_dir + 90)] call BIS_Fnc_relPos;
			if ((_progress % 5) == 0) then {
				private _obj = createVehicle [
					selectRandom ["Land_File1_F",
						"Land_FilePhotos_F",
						"Land_Wallet_01_F",
						"Land_Document_01_F",
						"Land_FilePhotos_F",
						"Land_Notepad_F",
						"Land_File2_F",
						"Land_File_research_F"
					],
					[(_pos select 0), (_pos select 1), 0],
					[],
					0,
					"CAN_COLLIDE"
				];
				_obj setDir (random 360);
				_target setVariable ["intelFiles", ((_target getVariable ["intelFiles", []]) + [_obj])];
			};
		},
		// Code executed on completion
		compile (format ["{ deleteVehicle _x; } forEach ((_this select 0) getVariable ['intelFiles', []]); %1;", _call_back]),	        														
		{																		// Code executed on interrupted
			{
				deleteVehicle _x;
			} forEach ((_this select 0) getVariable ["intelFiles", []]);
		},																		
		[],																		// Arguments passed to the scripts as _this select 3
		_duration,																// Action duration [s]
		100,																	// Priority
		_remove,																// Remove on completion
		false																	// Show in unconscious state 
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _attach_to];						// MP compatible implementation
	_action_id;
};
