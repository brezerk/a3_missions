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
Create civilian presence module
	Arguments: [_marker]
	Usage: [_marker] call BrezBlock_fnc_CreateCivilianPresence;
	Return: none
*/
if (isServer) then {
	params['_marker'];
	
	private _center = getMarkerPos _marker;
	private _good_roads = [];
			
	{
		private _pos = getPosASL _x;
		if ((count (_pos nearEntities[["Car", "Truck"], 8]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 8, false, true]) == 0)) then {
			private _bbox = boundingboxReal _x;
			private _a = _bbox select 0;
			private _b = _bbox select 1;
			private _size = _a distance _b;
			if (_size >= 25) then {
				_good_roads append [_x];
			};
		};
		if (count _good_roads >= 4) exitWith {};
	} count (_center nearRoads 50);
	
	private _road = selectRandom _good_roads;
	if (!isNil "_road") then {
		private _pos = getPosASL _road;
		private _dir = getDir _road;
		private _connected = roadsConnectedto (_road);
					
		if (count _connected > 0) then {
			private _connected_pos = getPos (_connected select 0);
			_dir = [_pos, _connected_pos] call BIS_fnc_DirTo;	
		};
					
		_pos = [_pos, 3, _dir + 90] call BIS_Fnc_relPos;
		private _class = selectRandom ([civilian, D_FRACTION_CIV, "transport_medic"] call Fn_Config_GetFraction_Units);
		private _vehicle = createVehicle [_class, _pos];
		if(D_MOD_CUP_VEHICLES) then {
			if (_class == 'CUP_O_LR_Ambulance_TKA') then {
				_vehicle setObjectTextureGlobal [0, "cup\wheeledvehicles\cup_wheeledvehicles_lr\data\textures\civ_r_lr_base_co.paa"];
			};
		};
		_vehicle setVariable ["ace_medical_medicClass", 1, true];
		_vehicle setDir _dir;
			
		clearWeaponCargoGlobal _vehicle;
		clearMagazineCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		
		if (D_MOD_ACE_MEDICAL) then {
			_vehicle addItemCargoGlobal ["ACE_fieldDressing", 10];
			_vehicle addItemCargoGlobal ["ACE_bloodIV", 4];
			_vehicle addItemCargoGlobal ["ACE_morphine", 2];
			_vehicle addItemCargoGlobal ["ACE_bodyBag", 10];
			_vehicle addItemCargoGlobal ["ACE_epinephrine", 2];
		} else {
			_vehicle addItemCargoGlobal ["Medikit", 1];
			_vehicle addItemCargoGlobal ["FirstAidKit", 10];
		};
	} else {
		systemChat "No good round found. Skip medevac spawn";
	};
	
	private _builing = nearestBuilding (_center);
	private _pos = selectRandom (_builing buildingPos -1);
	if (!isNil "_pos") then {
		private _class = "";
		if (D_MOD_ACE_MEDICAL) then {
			_class = "ACE_medicalSupplyCrate"
		} else {
			_class = selectRandom ['Land_PlasticCase_01_small_idap_F', 'Land_PlasticCase_01_large_idap_F', 'Land_PlasticCase_01_medium_idap_F'];
		};
		private _obj = _class createVehicle [0,0,0];
		_obj setPos _pos;
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;

		if (D_MOD_ACE_MEDICAL) then {
			_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
			_obj addItemCargoGlobal ["ACE_bloodIV", 8];
			_obj addItemCargoGlobal ["ACE_morphine", 8];
			_obj addItemCargoGlobal ["ACE_bodyBag", 10];
			_obj addItemCargoGlobal ["ACE_epinephrine", 2];
		} else {
			_obj addItemCargoGlobal ["Medikit", 2];
			_obj addItemCargoGlobal ["FirstAidKit", 20];
		};
	};	
};