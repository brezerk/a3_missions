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

params["_dst", "_src"];

if (!alive _dst) exitWith {systemChat format ["%1 мертвий.", name _dst];};
if ((_dst distance _src) > 6) exitWith {systemChat format ["%1 занадто далеко.", name _dst];};
if (!("ACE_morphine" in (items player))) exitWith {systemChat format ["Потрібен морфін.", name _dst];};
//Execute revive animation
[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
//Wait for revive animation to be set
waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
//call progress
player removeItem "ACE_morphine";
[
	3,
	[_src, _dst],
	{
		_this params ["_parameter"];
		_parameter params ["_src", "_dst"];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		if (bb_srv_stimpack_level < 4) then {
			switch (bb_srv_stimpack_level) do {
				case 0: {
					player setDamage 0;
				};
				case 1: {
					player setDamage 0.1;
				};
				case 2: {
					player setDamage 0.2;
				};
				case 3: {
					player setDamage 0.3;
				};
			};
			bb_srv_stimpack_level = bb_srv_stimpack_level + 1;
			[] spawn {sleep 600; bb_srv_stimpack_level = bb_srv_stimpack_level - 1;}
		};
	},
	{
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	}, "Вводжу стимулятор"
] call ace_common_fnc_progressBar;
