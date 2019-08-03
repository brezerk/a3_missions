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
	task_complete_ammo = false;
	task_complete_fuel = false;
	task_complete_wind = false;
	task_complete_lab = false;
	
	idep_ammo_01 = objNull;
	idep_fuel_01 = objNull;
	idep_wind_01 = objNull;
	idep_lab_01 = objNull;
	
	Fn_Task_Spawn_Indep_Objectives = {
		params['_center'];
		
		private _classes = ["Land_Research_HQ_F", "Land_Cargo_HQ_V4_F", "Land_wpp_Turbine_V1_off_F", "Land_dp_smallTank_F"];
		
		_markers = [];
		{
			if ((markerType _x) in ["n_mortar"]) then {
				if (_x find D_LOCATION >= 0) then {
					if ((_center distance2D (getMarkerPos _x)) <= 3000) then {
						_markers append [_x];
					};
				};
			};
		} forEach allMapMarkers;
		
		for "_i" from 1 to 2 do {
			private _marker = selectRandom _markers;
			private _pos = getMarkerPos (_marker);
			_markers = _markers - [_marker];
			
			_marker = createMarker [format ["mrk_objective_0%1", _i], _pos];
			_marker setMarkerType "hd_destroy";
			_marker setMarkerAlpha 1;
			
			private _unitRef = ["defence_point", _pos, [0,0,0], 0, true] call LARs_fnc_spawnComp;
			
			private _class = selectRandom (_classes);
			_classes = _classes - [_class];
			switch (_class) do {
				case 'Land_Research_HQ_F': {
					private _obj = createVehicle [_class, _pos];
					_obj setVectorUp [0,0,1];
				};
				case 'Land_Cargo_HQ_V4_F': {
					private _obj = createVehicle [_class, _pos];
					_obj setVectorUp [0,0,1];
				};
				case 'Land_wpp_Turbine_V1_off_F': {
					idep_wind_01 = createVehicle [_class, _pos];
					idep_wind_01 setVectorUp [0,0,1];
				};
				case 'Land_dp_smallTank_F': {
					idep_fuel_01 = createVehicle [_class, _pos];
					idep_fuel_01 setVectorUp [0,0,1];
				};
			};
		};
		
		// 
		// CUP_O_Ural_Reammo_RU
	
	};
};
