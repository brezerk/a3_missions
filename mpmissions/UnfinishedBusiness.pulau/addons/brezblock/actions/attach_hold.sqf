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
	Usage: [_obj, { _this systemChat "Hello!"; }] call BrezBlock_fnc_Attach_Hold_Action;
	Return: _action_id of assigned action
*/
if (isServer) then {
	params ["_attach_to", "_call_back", ["_icon", "holdactions\holdAction_search"], ["_text", "ACTION_01"], ["_condition", ""], ["_duration", 6], ["_remove", true]];
	_action_id = [
		_attach_to,																// Object the action is attached to
		localize _text,					        								// Title of the action
		format ["\a3\ui_f\data\IGUI\Cfg\%1_ca.paa", _icon],						// Idle icon shown on screen
		format ["\a3\ui_f\data\IGUI\Cfg\%1_ca.paa", _icon],						// Progress icon shown on screen
		format ["_this distance _target < 4 %1", _condition],		// Condition for the action to be shown
		format ["_caller distance _target < 4 %1", _condition],	// Condition for the action to progress
		{},																		// Code executed when action starts
		{},																		// Code executed on every progress tick
		_call_back,	        													// Code executed on completion	
		{},																		// Code executed on interrupted
		[],																		// Arguments passed to the scripts as _this select 3
		_duration,																// Action duration [s]
		100,																	// Priority
		_remove,																	// Remove on completion
		false																	// Show in unconscious state 
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _attach_to];						// MP compatible implementation
	_action_id;
};
