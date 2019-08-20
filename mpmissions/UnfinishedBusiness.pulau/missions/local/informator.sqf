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

if (hasInterface) then {
	Fn_Local_Civilian_AttachInformator_Action = {
		{
			if ((side _x) == civilian) then {
				{
					_action_id = [
						_x,
						{ [name _target] call Fn_Local_Informator_Complete; },
						"simpleTasks\types\talk",
						"ACTION_02",
						"&& alive _target",
						6,
						false
					] call BrezBlock_fnc_Attach_Hold_Action;
				} forEach (units _x);
			};
		} forEach allGroups;
	};

	Fn_Local_Create_MissionInformator = {
		params['_lcs', '_pois'];
		private _uri = "";
		{
			_uri = _uri + format["<marker name = 'mrk_city_%1'>%2</marker> ", _forEachIndex, _x select 0];
		} forEach _pois;
		
		[
			player,
			"t_find_informator",
			[format[localize "TASK_05_DESC", _uri],
			localize "TASK_05_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_find_informator', "talk"] call BIS_fnc_taskSetType;
		
		{
			private ["_trg"];
			_trg = createTrigger ["EmptyDetector", _x select 1];
			_trg setTriggerArea [180, 180, 0, false];
			_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
			_trg setTriggerStatements [
				"(vehicle player) in thisList",
				format ["[ localize 'INFO_LOC_01', format [localize 'INFO_SUBLOC_02', '%1'], format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;", _x select 0],
				""
			];
		} forEach _lcs;
		call Fn_Local_Civilian_AttachInformator_Action;
	};
	
	Fn_Local_Find_Assault_Group = {
		if (D_DEBUG) then {
			systemChat "Searching...";
		};
		params['_name'];
		if (!informator_told) then {
			informator_told = true;
			{
				if ((side _x) == west) then {
					if (_x != player) then {
						if (!(_x getVariable ["is_civilian", false])) then {
							private _pos = getPos _x;
							_pos = mapGridPosition [((_pos select 0) + (round(random 600) - 300)), ((_pos select 1) + (round(random 600) - 300)), _pos select 2];
							systemChat format[localize "INFO_PING_02", _name, _pos];
						};
					};
				};
			} forEach (playableUnits + switchableUnits);
			execVM 'missions\local\informator_reset.sqf';
		} else {
			systemChat format[localize "INFO_PING_01", _name];
		};
	};
	
	Fn_Local_CarmaKillCiv = {
		systemChat format[localize "KARMA_DROP_01"];
	};
	
	Fn_Local_Informator_Complete = {
		params['_name'];
		if ((playerSide == west) and (player getVariable ["is_assault_group", false])) then {
			PUB_fnc_informatorFound = [player, _this select 0];
			publicVariableServer "PUB_fnc_informatorFound";
			['t_find_informator', 'SUCCEEDED'] call BIS_fnc_taskSetState;
			call Fn_Local_Create_Task_West_WaponStash;
		};
		[_name] call Fn_Local_Find_Assault_Group;
	};
};
