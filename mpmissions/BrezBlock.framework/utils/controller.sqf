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
	Arguments:
		position: Object, PositionAGL or Position2D - where to find markers, center position 
		range: Effective ranage
	Usage: [_center, _range] call BrezBlock_fnc_CotrollerCreate;
	Return: array of found and unprocessed markers
*/
if (isServer) then {
	params['_pos', '_range'];
	private _markers = [];
	//Process markers in area and spawn units
	{
		private _marker_pos = getMarkerPos _x;
		if ((_pos distance2D (_marker_pos)) <= _range) then {
			switch (markerBrush _x) do
			{
				case "Solid": {
					private _marker_type = markerType _x;
					switch (true) do {
						case (_marker_type in ["ellipse", "square"]): {
							[_x] call BrezBlock_fnc_CreateCivilianPresence;
							if (D_MOD_ACEX) then {
								[_x] call BrezBlock_fnc_CreateCivilianSupply;
							};
							deleteMarkerLocal _x;
						};
						case (_marker_type == "loc_Hospital"): {
							if (markerAlpha _x == 0) then {
								[_x] call BrezBlock_fnc_CreateCivilianHospital;
								deleteMarkerLocal _x;
							};
						};
						case (_marker_type in ["o_mech_inf", "n_mech_inf", "o_motor_inf", "n_motor_inf", "o_armor", "n_armor"]): {
							[_x] call BrezBlock_fnc_CreateArmor;
							deleteMarkerLocal _x;
						};
						default {
							_markers pushBackUnique _x;
						};
					};
				};
				case "SolidBorder": {
					[_x] call BrezBlock_fnc_MarkerCreateDefend;
					deleteMarkerLocal _x;
				};
				case "DiagGrid": {
					[_x] call BrezBlock_fnc_MarkerCreatePatrol;
					deleteMarkerLocal _x;
				};
				case "Horizontal": {
					[_x] call BrezBlock_fnc_CreateCheckPoint;
					deleteMarkerLocal _x;
				};
			};
			if (D_DEBUG) then { _x setMarkerAlpha 1; };			
		};
	} count allMapMarkers;
	_markers;
};
