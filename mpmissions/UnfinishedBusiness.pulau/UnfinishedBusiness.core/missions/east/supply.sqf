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

//Player side triggers
// Client side code
if (hasInterface) then {};

if (isServer) then {

	/* 
		Iterate over all markers and spawn on matching the selected location
	*/
	Fn_Spawn_East_SupplyBoxes = {
		private _filter = format ["wp_%1_east_supply", D_LOCATION];
		{
			if (_x find _filter >= 0) then {
				[getMarkerPos _x] call Fn_Spawn_East_SupplyBox;
			};
		} forEach allMapMarkers;
	};

	/*
		Spawn supply box for EAST side
		//FIXME: Use sourced gear configuration map!
		
		@params Position
		
		@return SupplyBox object
	*/
	Fn_Spawn_East_SupplyBox = {
		params ['_pos'];
		private _obj = "B_supplyCrate_F" createVehicle (_pos);
		[_obj, "base", east, D_FRACTION_EAST] call BrezBlock_fnc_PopulateBaseSupply;
		_obj;
	};

};