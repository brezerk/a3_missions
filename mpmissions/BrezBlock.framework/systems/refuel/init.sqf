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

params['_obj', '_capacity', '_max_capacity', ['_drain_action', false], ['_carribale', false]];


_obj setVariable ["fuel_capacity", _capacity];
_obj setVariable ["fuel_max_capacity", _max_capacity];

if (_carribale) then {
	[_obj, true, [0, 2, 0.5], 10] call ace_dragging_fnc_setCarryable;
	[_obj, true, [0, 2, 0.5], 10] call ace_dragging_fnc_setDraggable;
};

if (_drain_action) then {
	_insertChildren = {
		params ["_target", "_player", "_params"];
		private _actions = [];
		{
			private _childStatement = {
				params ["_target", "_player", "_params"];
				[_target, _params] spawn BrezBlock_fnc_Local_Systems_Refuel_Drain;
			};
			_displayName = getText (configFile >>  "CfgVehicles" >> (typeOf _x) >> "displayName");
			_displayIcon = getText (configfile >> "CfgVehicles" >> (typeOf _x) >> "icon");
			_vehicle = _x;
			private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
			_actions pushBack [_action, [], _target]; 
		} forEach (nearestObjects [_player, ["Car", "Tank", "Truck"], 10]);
		_actions
	};

	_action = [
		"bb_interact_drain",
		"Злити пальне",
		"addons\BrezBlock.framework\data\ace_icon_refuel_interact.paa", //"\ace_refuel\ui\icon_refuel_interact.paa",ace_medical.pbo\ui\icons\medical_cross.paa
		{},
		{true},
		_insertChildren,
		[],
		"",
		5,
		[true, false, false, true, false],
		{}
	] call ace_interact_menu_fnc_createAction;

	[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};

_insertChildren = {
    params ["_target", "_player", "_params"];
    private _actions = [];
    {
		_vehicle = _x;
		if (_vehicle != _target) then {
			private _childStatement = {
				params ["_target", "_player", "_params"];
				[_target, _params] spawn BrezBlock_fnc_Local_Systems_Refuel_Refuel;
			};
			_displayName = getText (configFile >>  "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			_displayIcon = getText (configfile >> "CfgVehicles" >> (typeOf _vehicle) >> "icon");

			if (_displayIcon find "iconObject" >= 0) then {
				_displayIcon = "";
			};
			
			private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
			_actions pushBack [_action, [], _target];
		};
    } forEach (nearestObjects [_player, ["Car", "Tank", "Truck", "Land_CanisterPlastic_F", "CargoNet_01_barrels_F"], 6]);
    _actions
};

_action = [
	"bb_interact_refuel",
	"Заправити",
    "addons\BrezBlock.framework\data\ace_icon_refuel_interact.paa", //"\ace_refuel\ui\icon_refuel_interact.paa",ace_medical.pbo\ui\icons\medical_cross.paa
	{},
	{true},
	_insertChildren,
	[],
	"",
	5,
	[true, false, false, true, false],
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = [
	"bb_interact_cargo_check",
	"Перевірити кількість",
    "addons\BrezBlock.framework\data\ace_icon_refuel_interact.paa", //"\ace_refuel\ui\icon_refuel_interact.paa",ace_medical.pbo\ui\icons\medical_cross.paa
	{
		params ["_target", "_player", "_params"];
		[_target, _params] spawn BrezBlock_fnc_Local_Systems_Refuel_Check;
	},
	{true},
	{},
	[],
	"",
	5,
	[false, false, false, false, false],
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
