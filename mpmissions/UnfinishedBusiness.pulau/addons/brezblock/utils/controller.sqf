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

/*
Create Spawn\Despawn controller
	Arguments: None
	Usage: call BrezBlock_fnc_CotrollerCreate;
	Return: Group
*/
if (isServer) then {
	BrezBlock_fnc_Cotroller_Process_Marker = {
		params['_marker'];
		private['_grp'];
		switch(markerBrush _marker) do
		{
			case "Solid": {_grp = [_x] call BrezBlock_fnc_CreateCivilianPresence;};
			case "SolidBorder": {_grp = [_x] call BrezBlock_fnc_CreateDefend;};
			case "DiagGrid": {_grp = [_x] call BrezBlock_fnc_CreatePatrol;};
		};
		_grp;
	};
	
	BrezBlock_fnc_Cotroller_Spawn = {
		params['_trigger'];
		private['_grp'];
		{
			_grp = [_x] call BrezBlock_fnc_Cotroller_Process_Marker;
			_trigger setVariable [_x, _grp, false];
		} forEach (_trigger getVariable ["markers", []]);
	};
	
	BrezBlock_fnc_Cotroller_Despawn = {
		params['_trigger'];
		private['_grp', '_markers'];
		_markers = _trigger getVariable ["markers", []];
		{
			_grp = _trigger getVariable [_x, grpNull];
			if (!(isNull _grp)) then {
				if ({ alive _x } count units _grp == 0) then {
					deleteMarker _x;
					_markers deleteAt (_markers find _x);
				} else {
					{deletevehicle _x} foreach units _grp;
					_trigger setVariable [_x, grpNull, false];
				};
			} else {
				//["WARNING: Looks like AI group was killed\lost?"] remoteExec ["systemChat"];
			};
		} forEach _markers;
		if (count _markers == 0) then {
			//systemChat "Ok. No markers left. Removing trigger.";
			deleteVehicle _trigger;
		};
	};
	
	//Setup all Triggers
	{
		private['_trigger', '_markers'];
		_markers = [];
		_trigger = _x;
		//systemChat "Got trigger!";
		_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trigger setTriggerStatements [
			"this",
			"[thisTrigger] call BrezBlock_fnc_Cotroller_Spawn;",
			"[thisTrigger] call BrezBlock_fnc_Cotroller_Despawn;"
		];
		//Build marker's Cache
		{
			if (getMarkerPos _x inArea _trigger) then {
				if (markerType _x in ["ellipse", "square"]) then {
					_markers pushBack _x;
				};
			};
		} forEach allMapMarkers;
		_trigger setVariable ["markers", _markers, false];
	} forEach allMissionObjects "EmptyDetector";
};
