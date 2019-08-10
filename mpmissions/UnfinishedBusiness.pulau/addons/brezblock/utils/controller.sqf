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
	params['_pos', '_range'];

	BrezBlock_fnc_Cotroller_Process_Marker = {
		params['_marker'];
		private _grp = objNull;
		switch(markerBrush _marker) do
		{
			case "Solid": {
				private _pos = getMarkerPos _marker;
				_grp = [_x] call BrezBlock_fnc_CreateCivilianPresence;
				if (isClass(configFile >> "CfgPatches" >> "acex_field_rations")) then {
					[_x] call BrezBlock_fnc_CreateCivilianSupply;
				};
				{
					if ((markerType _x) == "loc_Hospital") then {
						
						private _range = getMarkerSize _marker select 0;
						if ((_pos distance2D (getMarkerPos _x)) <= _range) then {
							[_x] call BrezBlock_fnc_CreateCivilianHospital;
						};
					};
				} forEach allMapMarkers;
			};
			case "SolidBorder": {
				private _pos = getMarkerPos _marker;
				_grp = [_marker] call BrezBlock_fnc_MarkerCreateDefend;
				{
					if ((markerType _x) in ["b_motor_inf", "o_motor_inf", "n_motor_inf"]) then {
						private _range = getMarkerSize _marker select 0;
						if ((_pos distance2D (getMarkerPos _x)) <= _range) then {
							[_x] call BrezBlock_fnc_CreateArmor;
							deleteMarker _x;
						};
					};
				} forEach allMapMarkers;
			};
			case "DiagGrid": {_grp = [_marker] call BrezBlock_fnc_MarkerCreatePatrol;};
			case "Horizontal": {
				//_marker setMarkerAlpha 1;
				[_marker] call BrezBlock_fnc_CreateCheckPoint;
			};
		};
		_grp;
	};

	//Process markers in area and spawn units
	{
		if (markerType _x in ["ellipse", "square"]) then {
			if ((_pos distance2D (getMarkerPos _x)) <= _range) then {
				private _grp = [_x] call BrezBlock_fnc_Cotroller_Process_Marker;
				deleteMarker _x;
//				_x setMarkerAlpha 1;
			};
		};
	} forEach allMapMarkers;
};
