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
 
 if (isServer) then {
	private _lc = call BrezBlock_fnc_GetRandomCity;
	private _center = (_lc select 1);
	
	//Create HQ
	private _marker = createMarker ["respawn_guer", _center];
	_marker setMarkerType "hd_destroy";
	_marker setMarkerAlpha 1;
	
	//Create Netural lcoations
	private _lcs = [_center, 6000, 30] call BrezBlock_fnc_GetAllCitiesInRange;
	{
		private _lc = _x;
		private _city = ["new", [(_lc select 0), (_lc select 1), (_lc select 2)]] call CityInfo;
		D_GAME_LOCATIONS pushBackUnique _city;
	} forEach (_lcs select 1);
	
	private _avalibleLocations = +D_GAME_LOCATIONS;
	
	for "_i" from 1 to 4 do {
		private _lc = selectRandom _avalibleLocations;
		//FIMXE: deleteAt or deleteRange instead?
		_avalibleLocations = _avalibleLocations - [_lc];
		["setSide", resistance] call _lc;
	};
	
	for "_i" from 1 to 4 do {
		private _lc = selectRandom _avalibleLocations;
		//FIMXE: deleteAt or deleteRange instead?
		_avalibleLocations = _avalibleLocations - [_lc];
		["setSide", east] call _lc;
	};
	
	private _lcs = nearestLocations [_center, ["NameMarine"], 7000];
	
	if ((count (_lcs)) > 0) then {
		_lc = selectRandom (_lcs);
		private _lcs = selectBestPlaces [(locationPosition _lc), 2000, "((waterDepth factor [35,60])/(1 + waterDepth))", 15, 1];
		private _pos = [];
		if ((count (_lcs)) > 0) then {
			_pos = (selectRandom (_lcs) select 0);
		} else {
			_pos = (locationPosition _lc);
		};
		_pos = [_pos select 0, _pos select 1, 0];
		systemChat format ["%1", _pos];
		_marker = createMarker ["respawn_west", _pos];
		_marker setMarkerType "b_hq";
		_marker setMarkerAlpha 1;
		
		private _obj_destroyer = createVehicle ["Land_Destroyer_01_base_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		 [_obj_destroyer] call bis_fnc_Destroyer01Init;
		_obj_destroyer setPosASL _pos;
		[_obj_destroyer] call bis_fnc_Destroyer01PosUpdate;
		
		[[_obj_destroyer, "Land_Destroyer_01_hull_04_F"] call BIS_fnc_Destroyer01GetShipPart, 1, false] call BIS_fnc_Destroyer01AnimateHangarDoors;
		//([_obj, "ShipFlag_US_F"] call bis_fnc_destroyer01GetShipPart) setFlagTexture (getText (configFile >> "CfgFactionClasses" >> D_FRACTION_WEST >> "flag"));
		private _house = [_obj_destroyer, "Land_Destroyer_01_hull_04_F"] call BIS_fnc_Destroyer01GetShipPart;
		_pos = getPos _house;
		//FIMXE: not MP complant
		player setPosASL [_pos select 0, _pos select 1, 8];
		
		_obj = createVehicle ["Land_Destroyer_01_Boat_Rack_01_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj enableSimulation false;
		_obj allowDamage false;
		_obj setDir (getDir _obj_destroyer + 180);
		_obj setPosASL (_obj_destroyer modelToWorldWorld [-11.5,14.43,7.5]);
		_obj enableSimulation true;
		_obj allowDamage true;
		
		_obj = createVehicle ["Land_Destroyer_01_Boat_Rack_01_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj enableSimulation false;
		_obj allowDamage false;
		_obj setDir (getDir _obj_destroyer + 180);
		_obj setPosASL (_obj_destroyer modelToWorldWorld [11.5,14.43,7.5]);
		_obj enableSimulation true;
		_obj allowDamage true;
		
		// Mk45 Hammer
		_hammer = createVehicle ["B_Ship_Gun_01_F", [0,0,0], [], 0, "NONE"];
		_hammer allowDamage false;
		_hammer setDir (getDir _obj_destroyer + 180);
		_hammer setPosASL (_obj_destroyer modelToWorldWorld [0,-79.08,12.1]);
		
		 // MRLS
		_vls = createVehicle ["B_Ship_MRLS_01_F", [0,0,0], [], 0, "NONE"];
		_vls allowDamage false;
		_vls setDir (getDir _obj_destroyer + 180);
		_vls setPosASL (_obj_destroyer modelToWorldWorld [0,-62.4229,10.7]);

		// Praetorian-1C
		_aa1 = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"];
		_aa1 allowDamage false;
		_aa1 setDir (getDir _obj_destroyer + 180);
		_aa1 setPosASL (_obj_destroyer modelToWorldWorld [0,-48.106,15.1]);

		// Praetorian-1C
		_aa2 = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"];
		_aa2 allowDamage false;
		_aa2 setDir (getDir _obj_destroyer);
		_aa2 setPosASL (_obj_destroyer modelToWorldWorld [0,36.3765,19.3]);

		// Mk49 Spartan
		_spartan = createVehicle ["B_SAM_System_01_F", [0,0,0], [], 0, "NONE"];
		_spartan allowDamage false;
		_spartan setDir (getDir _obj_destroyer);
		_spartan setPosASL (_obj_destroyer modelToWorldWorld [0,50.6011,15.8]);
		
		
	} else {
		systemChat "ERROR: NameMarine not found";
	};
 };