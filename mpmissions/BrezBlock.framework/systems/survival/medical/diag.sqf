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
		_levels = _target getVariable["bb_srv_health", "000"]; // chem, rad, bac
		_symptoms = [];
		_response = "";
		//systemChat format["levels %1", _levels];
		if ((_player getVariable ["ace_medical_medicClass", 0]) > 0) then {
			switch (_levels select [0,1]) do {
				case "1": { _symptoms pushBack "легкого хімічного отруєння"; };
				case "2": { _symptoms pushBack "середнього хімічного отруєння"; };
				case "3": { _symptoms pushBack "важкого хімічного отруєння"; };
			};
			switch (_levels select [1,1]) do {
				case "1": { _symptoms pushBack "легкого радіаційного ураження"; };
				case "2": { _symptoms pushBack "середнього радіаційного ураження"; };
				case "3": { _symptoms pushBack "важкого радіаційного ураження"; };
			};
			switch (_levels select [2,1]) do {
				case "1": { _symptoms pushBack "легкої респираторної хвороби"; };
				case "2": { _symptoms pushBack "середньої респираторної хвороби"; };
				case "3": { _symptoms pushBack "важкої респираторної хвороби"; };
			};
		} else {
			switch (_levels select [0,1]) do {
				case "1": { _symptoms pushBack "легкої респираторної хвороби"; };//FIME: randomize? :)
				case "2": { _symptoms pushBack "хімічного отруєння"; };
				case "3": { _symptoms pushBack "хімічного отруєння"; };
			};
			switch (_levels select [1,1]) do {
				case "2": { _symptoms pushBack "радіаційного ураження"; };
				case "3": { _symptoms pushBack "радіаційного ураження"; };
			};
			switch (_levels select [2,1]) do {
				case "1": { _symptoms pushBack "респираторної хвороби"; };
				case "2": { _symptoms pushBack "респираторної хвороби"; };
				case "3": { _symptoms pushBack "респираторної хвороби"; };
			};
		};

		_damage = (damage _target);
		if (_damage > 0) then {
			if (_damage > 0.5) then {
				_symptoms pushBack "обширного ураження тканин";
			} else {
				if (_damage > 0.3) then {
					_symptoms pushBack "ураження тканини";
				} else {
					_symptoms pushBack "легкого ураження тканини";
				};
			};
		};

		if ((count _symptoms) == 0) then {
			_response = "виглядає Здоровим.";
		} else {
			_response = "має симптоми: ";
			{
				if (_forEachIndex != 0) then {
					_response = _response + ", " + _x;
				} else {
					_response = _response + _x;
				};
			} forEach _symptoms;
		};

		systemChat format ["%1: %2", name _target, _response];
		
	},
	{
		_this params ["_parameter"];
		_parameter params ["_target", "_player"];
		[_player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[_player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	}, "Провожу обстеження"
] call ace_common_fnc_progressBar;
