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

params["_target", "_player"];

if (!alive _target) exitWith {systemChat format ["%1 мертвий.", name _target];};
if ((_target distance _player) > 6) exitWith {systemChat format ["%1 занадто далеко.", name _target];};

//
if (!("ACE_morphine" in (items _target))) then {
	_target removeItem "ACE_morphine";
} else {
	if (!("ACE_morphine" in (items _player))) exitWith {systemChat "Потрібен морфін.";};
	_player removeItem "ACE_morphine";
};

//Execute revive animation
[_player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
//Wait for revive animation to be set
waitUntil {sleep 0.05; ((animationState _player) == "AinvPknlMstpSnonWrflDr_medic3")};
//call progress
[
	3,
	[_target, _player],
	{
		_this params ["_parameter"];
		_parameter params ["_target", "_player"];
		[_player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[_player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		_level = _target getVariable["bb_srv_st_lvl", 0];
		if (_level < 4) then {
			switch (_level) do {
				case 0: {
					if ((damage _target) > 0) then {
						_target setDamage 0;
					};
				};
				case 1: {
					if ((damage _target) > 0.1) then {
						_target setDamage 0.1;
					};
				};
				case 2: {
					if ((damage _target) > 0.2) then {
						_target setDamage 0.2;
					};
				};
				case 3: {
					if ((damage _target) > 0.4) then {
						_target setDamage 0.4;
					};
				};
			};
			_target setVariable["bb_srv_st_lvl", (_level + 1)];
		};
	},
	{
		_this params ["_parameter"];
		_parameter params ["_target", "_player"];
		[_player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[_player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	}, "Вводжу стимулятор"
] call ace_common_fnc_progressBar;
