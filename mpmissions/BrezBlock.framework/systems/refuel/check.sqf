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


params["_target"];		

//Execute revive animation: AinvPknlMstpSnonWrflDr_medic3 InBaseMoves_repairVehicleKnl
[player, "AinvPknlMstpSnonWnonDnon_medicUp3"] remoteExec ["playMoveNow", 0, false];
//Wait for revive animation to be set
waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWnonDnon_medicUp3")};
//call progress
[
	3,
	[_target],
	{
		_this params ["_parameter"];
		_parameter params ["_target"];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		_capacity = _target getVariable ["fuel_capacity", 0];
		if (_capacity > 0) then {
			systemChat format ["Залишки ~%1л!", (round _capacity)];
		} else {
			systemChat "Нема більше пального!";
		};
	},
	{
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	}, "Перевіряємо"
] call ace_common_fnc_progressBar;
