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


_action = [
	"bb_survival_personalAidKit_stimpack",
	"Вколоти стимулятор",
	"addons\BrezBlock.framework\data\ace_medical_cross.paa",
	{
		params ["_target", "_player", "_params"];
		[_player, _target] spawn BrezBlock_fnc_Local_Systems_Survival_Medical_Stimpack;
	},
	{("ACE_morphine" in (items player))},
	{},
	[],
	"",
	5,
	[false, false, false, false, false]] call ace_interact_menu_fnc_createAction;
	
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;

_insertChildren = {
	params ["_target", "_player", "_params"];
	private _actions = [];
	{
		if (_x in playableUnits) then {
			if (alive _x) then {
				private _childStatement = {
					params ["_target", "_player", "_params"];
					[_target, _player] spawn BrezBlock_fnc_Local_Systems_Survival_Medical_Diag;
				};
				_displayName = name _x;
				_displayIcon = "addons\BrezBlock.framework\data\ace_team_white_ca.paa";
				_vehicle = _x;
				private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
				_actions pushBack [_action, [], _target];
			};
		};
	} forEach (nearestObjects [_player, ["Man"], 6]);
	_actions
};

_action = [
	"bb_survival_personalAidKit_diag",
	"Діагностувати",
	"addons\BrezBlock.framework\data\ace_medical_cross.paa",
	{},
	{("ACE_personalAidKit" in (items player))},
	_insertChildren,
	[],
	"",
	5,
	[false, false, false, false, false]] call ace_interact_menu_fnc_createAction;
	
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;

_insertChildren = {
	params ["_target", "_player", "_params"];
	private _actions = [];
	{
		if (_x in playableUnits) then {
			if (alive _x) then {
				private _childStatement = {
					params ["_target", "_player", "_params"];
					[_target, _params] spawn BrezBlock_fnc_Local_Systems_Survival_Medical_Toxine;
				};
				_displayName = name _x;
				_displayIcon = "addons\BrezBlock.framework\data\ace_team_white_ca.paa";
				_vehicle = _x;
				private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
				_actions pushBack [_action, [], _target]; 
			};
		};
	} forEach (nearestObjects [_player, ["Man"], 6]);
	_actions
};

_action = [
	"bb_survival_personalAidKit_threat_detox",
	"Детоксикація",
	"addons\BrezBlock.framework\data\ace_medical_cross.paa",
	{},
	{("ACE_personalAidKit" in (items player))},
	_insertChildren,
	[],
	"",
	5,
	[false, false, false, false, false]] call ace_interact_menu_fnc_createAction;
	
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;

_insertChildren = {
	params ["_target", "_player", "_params"];
	private _actions = [];
	{
		if (_x in playableUnits) then {
			if (alive _x) then {
				private _childStatement = {
					params ["_target", "_player", "_params"];
					[_target, _params] spawn BrezBlock_fnc_Local_Systems_Survival_Medical_Rad;
				};
				_displayName = name _x;
				_displayIcon = "addons\BrezBlock.framework\data\ace_team_white_ca.paa";
				_vehicle = _x;
				private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
				_actions pushBack [_action, [], _target]; 
			};
		};
	} forEach (nearestObjects [_player, ["Man"], 6]);
	_actions
};

_action = [
	"bb_survival_personalAidKit_threat_antirad",
	"Антирадін",
	"addons\BrezBlock.framework\data\ace_medical_cross.paa",
	{},
	{("ACE_personalAidKit" in (items player))},
	_insertChildren,
	[],
	"",
	5,
	[false, false, false, false, false]] call ace_interact_menu_fnc_createAction;
	
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;

_insertChildren = {
	params ["_target", "_player", "_params"];
	private _actions = [];
	{
		if (_x in playableUnits) then {
			if (alive _x) then {
				private _childStatement = {
					params ["_target", "_player", "_params"];
					[_target, _params] spawn BrezBlock_fnc_Local_Systems_Survival_Medical_Flue;
				};
				_displayName = name _x;
				_displayIcon = "addons\BrezBlock.framework\data\ace_team_white_ca.paa";
				_vehicle = _x;
				private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
				_actions pushBack [_action, [], _target];
			};
		};
	} forEach (nearestObjects [_player, ["Man"], 6]);
	_actions
};

_action = [
	"bb_survival_personalAidKit_threat_flue",
	"Протизапальне",
	"addons\BrezBlock.framework\data\ace_medical_cross.paa",
	{},
	{("ACE_personalAidKit" in (items player))},
	_insertChildren,
	[],
	"",
	5,
	[false, false, false, false, false]] call ace_interact_menu_fnc_createAction;
	
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;
