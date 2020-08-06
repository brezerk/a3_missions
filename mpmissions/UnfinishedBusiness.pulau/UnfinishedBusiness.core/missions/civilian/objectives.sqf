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
Spawn start objectives, triggers for informator contact
*/

//Player side triggers
// Client side code
if (hasInterface) then {};

if (isServer) then {
	task_civ_leader = false;
	
	civ_leader = objNull;
	
	Fn_Spawn_Civ_Cars_Transport = {
        params ["_spawnposition", "_spawndir"];
		private _veh = objNull;
		if (count (nearestObjects [_spawnposition, ["Car", "Tank", "APC", "Boat", "Drone", "Plane", "Helicopter"], 4]) == 0) then {
			private _class = (selectRandom D_FRACTION_CIV_UNITS_TRANSPORT);
			private _pos = _spawnposition; // findEmptyPosition [0, 25, _class];
			//systemChat format ["%1 %2", _class, _pos];
			private _veh = createVehicle [_class, _pos, [], 0];
			_veh setDir _spawndir;
			[_veh] execVM 'addons\BrezBlock.framework\triggers\despawn_transport.sqf';
		};
        _veh;
	};	

	Fn_Task_Spawn_Civ_Objectives = {
		params['_center'];
		private _markers = [];
		{
			if ((markerType _x) == "n_mortar") then {
				_markers append [_x];
			};
		} forEach avaliable_markers;
		private _marker = selectRandom _markers;
		avaliable_markers deleteAt (avaliable_markers find _marker);
		private _center = getMarkerPos (_marker);
		private _dir = markerDir _marker;
		private _pos = [_center, 9, _dir + 90] call BIS_Fnc_relPos;
		private _unitRef = ["civ_base", _center, [0,0,0], 0, true] call LARs_fnc_spawnComp;
		
		private _marker = createMarker ["respawn_civ", _center];
		_marker setMarkerType "hd_destroy";
		_marker setMarkerAlpha 0;
		
		[civ_base_stash_01, "base", civilian, D_FRACTION_CIV] call BrezBlock_fnc_PopulateBaseSupply;
		//[civ_base_stash_02, "base", civilian, D_FRACTION_CIV] call BrezBlock_fnc_PopulateBaseSupply;
		
		{
			[(getPos _x), (getDir _x)] call Fn_Spawn_Civ_Cars_Transport;
		} forEach [place_civ_car01, place_civ_car02];
	};
	
};
