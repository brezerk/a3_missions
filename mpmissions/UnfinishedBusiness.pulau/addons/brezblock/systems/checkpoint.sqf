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
	Usage: [_marker] call BrezBlock_fnc_CreateDefend;
	Return: Group
*/
if (isServer) then {

	params['_marker'];
	private['_side'];

	_Fn_BrezBlock_GetRandomVehicle = {
		params['_side'];
		private['_units'];
		switch(_side) do
		{
			case west: {
			
			};
			case east: {
				switch (D_FRACTION_EAST) do {
					case "CUP_O_SLA": {
						switch (D_DIFFICLTY) do {
							case 0: {
								_units = [
									'CUP_O_UAZ_AGS30_SLA',
									'CUP_O_UAZ_AGS30_SLA'
								];
							};
							case 1: {
								_units = [
									'CUP_O_BMP2_SLA',
									'CUP_O_BRDM2_SLA',
									'CUP_O_BTR60_SLA'
								];
							};
							case 2: {
								_units = [
									'CUP_O_T55_SLA',
									'CUP_O_T72_SLA'
								];
							};
						};
					};
					case "CUP_O_TK": {
						switch (D_DIFFICLTY) do {
							case 0: {
								_units = [
									'CUP_O_UAZ_AGS30_TKA',
									'CUP_O_UAZ_AGS30_TKA'
								];
							};
							case 1: {
								_units = [
									'CUP_O_BMP2_TKA',
									'CUP_O_BRDM2_TKA',
									'CUP_O_BTR60_TKA'
								];
							};
							case 2: {
								_units = [
									'CUP_O_T55_TK',
									'CUP_O_T34_TKA'
								];
							};
						};
					};
					case "CUP_O_ChDKZ": {
						switch (D_DIFFICLTY) do {
							case 0: {
								_units = [
									'CUP_O_UAZ_AGS30_TKA',
									'CUP_O_UAZ_AGS30_TKA'
								];
							};
							case 1: {
								_units = [
									'CUP_O_BMP2_TKA',
									'CUP_O_BRDM2_TKA',
									'CUP_O_BTR60_TKA'
								];
							};
							case 2: {
								_units = [
									'CUP_O_T55_TK',
									'CUP_O_T34_TKA'
								];
							};
						};
					};
				};
			};
			case resistance: {
				switch (D_FRACTION_INDEP) do
				{
					case "CUP_I_RACS": { 
						switch (D_DIFFICLTY) do {
							case 0: {
								_units = [
									'CUP_I_LR_MG_RACS'
								];
							};
							case 1: {
								_units = [
									'CUP_I_LAV25_RACS',
									'CUP_I_LAV25M240_RACS',
									'CUP_I_M113_RACS'
								];
							};
							case 2: {
								_units = [
									'CUP_I_M60A3_RACS',
									'CUP_I_T72_RACS'
								];
							};
						};
					};
					case "CUP_I_NAPA": { 
						switch (D_DIFFICLTY) do {
							case 0: {
								_units = [
									'CUP_I_Datsun_PK',
									'CUP_I_Datsun_PK_Random'
								];
							};
							case 1: {
								_units = [
									'CUP_I_BMP2_NAPA',
									'CUP_I_BRDM2_NAPA'
								];
							};
							case 2: {
								_units = [
									'CUP_I_T34_NAPA',
									'CUP_I_T55_NAPA'
								];
							};
						};
					};
					case "CUP_I_TK_GUE": { 
						switch (D_DIFFICLTY) do {
							case 0: {
								_units = [
									'CUP_I_Datsun_PK',
									'CUP_I_Datsun_PK_Random'
								];
							};
							case 1: {
								_units = [
									'CUP_I_BMP2_NAPA',
									'CUP_I_BRDM2_NAPA'
								];
							};
							case 2: {
								_units = [
									'CUP_I_T34_NAPA',
									'CUP_I_T55_NAPA'
								];
							};
						};
					};
					case "IND_F": {
						switch (D_DIFFICLTY) do {
							case 0: {
								_units = [
									'CUP_I_LR_MG_AAF',
									'CUP_I_LR_SF_GMG_AAF',
									'CUP_I_LR_SF_HMG_AAF'
								];
							};
							case 1: {
								_units = [
									'CUP_I_M113_AAF',
									'CUP_I_APC_tracked_30_cannon_F'
								];
							};
							case 2: {
								_units = [
									'CUP_LT_01_AT_F',
									'CUP_LT_01_cannon_F'
								];
							};
						};
					};
					case "IND_G_F": {
						switch (D_DIFFICLTY) do {
							case 0: {
								_units = [
									'I_G_Offroad_01_AT_F',
									'I_G_Offroad_01_F',
									'I_G_Offroad_01_armed_F'
								];
							};
							case 1: {
								_units = [
									'I_G_Offroad_01_AT_F',
									'I_G_Offroad_01_F',
									'I_G_Offroad_01_armed_F'
								];
							};
							case 2: {
								_units = [
									'I_G_Offroad_01_AT_F',
									'I_G_Offroad_01_F',
									'I_G_Offroad_01_armed_F'
								];
							};
						};
					};
				};
			};
			case civilian: {
			
			};
		};
		selectRandom _units;
	};
	
	private _center = getMarkerPos _marker;
	private _roads = _center nearRoads 25;
	private _good_roads = [];
			
	{
		private _pos = position _x;
		if ((count (nearestObjects [_pos, ["Car", "Truck"], 10]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 10, false, true]) == 0)) then {
			private _bbox = boundingboxReal _x;
			private _a = _bbox select 0;
			private _b = _bbox select 1;
			private _size = _a distance _b;
			if (_size >= 25) then {
				_good_roads append [_x];
			};
		};
		if (count _good_roads >= 4) exitWith {};
	} forEach _roads;
	
	private _road = selectRandom _good_roads;
	if (!isNil "_road") then {
		private _pos = position _road;
		private _dir = getDir _road;
		private _connected = roadsConnectedto (_road);
					
		if (count _connected > 0) then {
			private _connected_pos = getPos (_connected select 0);
			_dir = [_pos, _connected_pos] call BIS_fnc_DirTo;	
		};
					
		private _o_pos = [_pos, 6, _dir + 90] call BIS_Fnc_relPos;
		private _vehicle = createVehicle ["Land_BagBunker_01_small_green_F", _o_pos];
		_vehicle setDir _dir;
		_o_pos = [_pos, -5, _dir + 90] call BIS_Fnc_relPos;
		_o_pos = [_o_pos, 1, _dir] call BIS_Fnc_relPos;
		_vehicle = createVehicle ["Land_HBarrier_01_line_3_green_F", _o_pos];
		_vehicle setDir _dir;
		
		
		_o_pos = [_pos, 5, _dir + 90] call BIS_Fnc_relPos;
		_o_pos = [_o_pos, 7, _dir] call BIS_Fnc_relPos;
		
		private _obj = "Land_WoodenCrate_01_F" createVehicle (_o_pos);
			
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		
		_obj addWeaponCargoGlobal ["ACE_Banana", ((random 15) + 10)];
		
		/*
		_o_pos = [_pos, 1, _dir + 90] call BIS_Fnc_relPos;
		_o_pos = [_o_pos, -6.5, _dir] call BIS_Fnc_relPos;
		_vehicle = createVehicle ["Land_BarGate_01_open_F", _o_pos];
		_vehicle setDir _dir;
		checkpoint_gate_group append [_vehicle];
		*/
		
		//https://community.bistudio.com/wiki/Arma_3_CfgMarkerColors
		switch (getMarkerColor _marker) do
		{
			case "ColorWEST": { _side = west; };
			case "ColorEAST": { _side = east; };
			case "ColorGUER": { _side = resistance; };
			case "ColorWEST": { _side = civilian; };
		};
		
		_o_pos = [_pos, -6, _dir + 90] call BIS_Fnc_relPos;
		_o_pos = [_o_pos, 7, _dir] call BIS_Fnc_relPos;
		_vehicle = createVehicle [([_side] call _Fn_BrezBlock_GetRandomVehicle), _o_pos];
		_vehicle setDir (_dir + 180);
		private _crew = createVehicleCrew (_vehicle);
		
		private _def_marker = createMarker [format ["wp_defend_%1", _marker], _pos];
		_def_marker setMarkerAlpha 0;
		_def_marker setMarkerSize [25, 25];
		_def_marker setMarkerBrush "SolidBorder";
		_def_marker setMarkerShape "ellipse";
		_def_marker setMarkerColor (getMarkerColor _marker);
		[_def_marker] call BrezBlock_fnc_CreateDefend;
		deleteMarker _def_marker;

	};
};