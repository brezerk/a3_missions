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

if (!("ACE_salineIV" in (items _target))) then {
	_target removeItem "ACE_salineIV";
} else {
	if (!("ACE_salineIV" in (items _player))) exitWith {systemChat "Потрібен фізрозчин для інфузії.";};
	_player removeItem "ACE_salineIV";
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
		_target setVariable["bb_srv_dechem", time, true];
		//remoteExec ["BrezBlock_fnc_call_dechem", _target];
	},
	{
		_this params ["_parameter"];
		_parameter params ["_target", "_player"];
		[_player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[_player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	}, "Вводжу Детоксин"
] call ace_common_fnc_progressBar;
