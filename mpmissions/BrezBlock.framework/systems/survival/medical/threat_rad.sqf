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

params["_src", "_dst"];

if (!alive _dst) exitWith {systemChat format ["%1 мертвий.", name _dst];};
if ((_dst distance _src) > 6) exitWith {systemChat format ["%1 занадто далеко.", name _dst];};
if (!("ACE_salineIV" in (items player))) exitWith {systemChat format ["Потрібен антирадін для інфузії.", name _dst];};
//Execute revive animation
[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
//Wait for revive animation to be set
waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
//call progress
player removeItem "ACE_plasmaIV";
[
	3,
	[_src, _dst],
	{
		_this params ["_parameter"];
		_parameter params ["_src", "_dst"];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		remoteExec ["BrezBlock_fnc_call_derad", _dst];
	},
	{
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	}, "Вводжу Антирадін"
] call ace_common_fnc_progressBar;
