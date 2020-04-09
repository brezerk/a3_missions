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
//Execute revive animation
[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
//Wait for revive animation to be set
waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
//call progress
[
	3,
	[_src, _dst],
	{
		_this params ["_parameter"];
		_parameter params ["_src", "_dst"];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		//[owner _src] remoteExec ["BrezBlock_fnc_call_diag", _dst];
		
		_response = "";
		
		if (bb_srv_dmg_chem > 0) then {
			_response = " Має симптоми хімічного отруєння.";
		};

		if (bb_srv_dmg_rad > 0) then {
			_response = _response + " Має симптоми радіаційного ураження.";
		};

		if (bb_srv_dmg_bac > 0) then {
			_response = _response + " Має симптоми респираторної хвороби.";
		};


		if (_response == "") then {
			_response = "виглядає Здоровим.";
		};

		systemChat format ["%1: %2", name player, _response];
	},
	{
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	}, "Провожу обстеження"
] call ace_common_fnc_progressBar;
