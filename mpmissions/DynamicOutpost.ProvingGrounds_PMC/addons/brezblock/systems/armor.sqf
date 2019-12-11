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
Create CBA defend
	Arguments: [_marker]
	Usage: [_marker] call BrezBlock_fnc_CreateArmor;
	Return: Group
*/
if (isServer) then {

	params['_marker'];
	
	private _center = getMarkerPos _marker;
	private _class = objNull;
	private _grp = grpNull;

	switch (markerType _marker) do
	{
		case "o_motor_inf": { _class = selectRandom D_FRACTION_EAST_UNITS_CARS; };
		case "n_motor_inf": { _class = selectRandom D_FRACTION_INDEP_UNITS_CARS; };
		case "o_mech_inf": { _class = selectRandom D_FRACTION_EAST_UNITS_LIGHT; };
		case "n_mech_inf": { _class = selectRandom D_FRACTION_INDEP_UNITS_LIGHT; };
		case "o_armor": { _class = selectRandom D_FRACTION_EAST_UNITS_HEAVY; };
		case "n_armor": { _class = selectRandom D_FRACTION_INDEP_UNITS_HEAVY; };
	};
	
	if (!isNil "_class") then {		
		private _vehicle = createVehicle [_class, _center];
		_vehicle setDir (markerDir _marker);
		_grp = createVehicleCrew (_vehicle);
	};

	_grp;
};