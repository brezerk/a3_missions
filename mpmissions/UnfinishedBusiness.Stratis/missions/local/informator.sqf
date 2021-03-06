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
	Fn_Local_Create_MissionInformator = {
		params['_lcs', '_pois'];
		private _uri = "";
		{
			_uri = _uri + format["<marker name = 'wp_city_%1'>%2</marker> ", _forEachIndex, _x select 0];
		} forEach _pois;
		[
			west,
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
	};
	
	Fn_Task_Create_Informator_Complete = {
		PUB_fnc_informatorFound = [player, _this select 0];
		publicVariableServer "PUB_fnc_informatorFound";
		['t_find_informator', 'SUCCEEDED'] call BIS_fnc_taskSetState;
	};
};
