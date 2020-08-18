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

	/*
		Create a marker for west main base;
		
		@params Position
	*/
	Fn_West_MissionPlanning_CreateMarkers_Base = {
		params['_center'];
		
		//Place naval marker
		private _marker = createMarker ["mrk_west_base_01", _center];
		_marker setMarkerType "b_naval";
		_marker setMarkerAlpha 0;
		_marker setMarkerText 'USS "Democracy"';
		
		//Mark 'safe' area
		//Note: it's size will be used for evacuation trigger
		_marker = createMarker ["mrk_west_safezone_01", _center];
		_marker setMarkerSize [2000, 2000];
		_marker setMarkerBrush "BDiagonal";
		_marker setMarkerShape "ellipse";
		_marker setMarkerColor "ColorWEST";
		_marker setMarkerAlpha 0;
		
		"mrk_west_specops" setMarkerAlpha 0;
		"mrk_spec_boat02" setMarkerAlpha 0;
		"mrk_spec_boat01" setMarkerAlpha 0;
	};
	
	Fn_West_MissionPlanning_CreateMarkers_EastBase = {
		// East base (respawn point)
		private _dir = 0;
		private _markers = [];
		private _center = getMarkerPos format ["wp_%1_east_respawn", D_LOCATION];
		private _marker = createMarker ["respawn_east", _center];
		_marker setMarkerType "hd_destroy";
		_marker setMarkerAlpha 0;
		
		_marker = createMarker ["mrk_east_base_01", _center];
		_marker setMarkerType "hd_warning";
		_marker setMarkerText 'Base "Alpha"';
		_marker setMarkerColor "ColorEAST";
		
		_marker = createMarker ["mrk_east_dangerzone_01", _center];
		_marker setMarkerSize [300, 300];
		_marker setMarkerBrush "BDiagonal";
		_marker setMarkerShape "ellipse";
		_marker setMarkerColor "ColorEAST";
		
		{
			private _marker = format["wp_%1_%2", D_LOCATION, _x];
			_center = getMarkerPos _marker;
			_dir = markerDir _marker;
			_marker = createMarker [format ["mrk_%1", _x], _center];
			_marker setMarkerDir _dir;
			_marker setMarkerType "hd_destroy";
			_marker setMarkerAlpha 0;
		} forEach ["east_helicopter", "east_fuel", "east_ammo", "east_truck"];
		
		// East base AntiAir
		_center = getMarkerPos format ["wp_%1_aa", D_LOCATION];
		_marker = createMarker ["mrk_east_base_02", _center];
		_marker setMarkerType "hd_warning";
		_marker setMarkerText 'Base "Bravo"';
		_marker setMarkerColor "ColorEAST";
		
		_marker = createMarker ["mrk_east_dangerzone_02", _center];
		_marker setMarkerSize [500, 500];
		_marker setMarkerBrush "BDiagonal";
		_marker setMarkerShape "ellipse";
		_marker setMarkerColor "ColorEAST";
		
		// Hidden markers, primarely used by mission logic
		{
			private _ref_marker = format ["wp_%1_%2", D_LOCATION, _x];
			_marker = createMarker [format ["mrk_%1", _x], (getMarkerPos _ref_marker)];
			_marker setMarkerType "hd_destroy";
			_marker setMarkerAlpha 0;
			_marker setMarkerDir (markerDir _ref_marker);
		} forEach ['aa', 'airfield', 'cesna', 'heli', 'spawn_point' , 'patrol_heli', 'leader'];
		
		if (D_START_TYPE == 0) then {
			_center = getMarkerPos format ["wp_%1_waypoint", D_LOCATION];
			_dir = markerDir format ["wp_%1_waypoint", D_LOCATION];
		} else {
			_center = getMarkerPos format ["wp_%1_waypoint_express", D_LOCATION];
			_dir = markerDir format ["wp_%1_waypoint_express", D_LOCATION];
		};
		_marker = createMarker ["mrk_flight_waypoint", _center];
		_marker setMarkerDir _dir;
		_marker setMarkerType "hd_destroy";
		_marker setMarkerAlpha 0;
		
		{
			if (_x find format["wp_%1_crashsite", D_LOCATION] >= 0) then {
				_markers pushBack _x;
			};
		} forEach allMapMarkers;
	
		//Create crash site marker
		_center = getMarkerPos (selectRandom _markers);
		_marker = createMarker ["mrk_west_crashsite", [(((_center select 0) + 250) - random(250)), (((_center select 1) + 250) - random(250)), 0]];
		_marker setMarkerType "hd_destroy";
		_marker setMarkerAlpha 0;
		
		_markers = [];
		{
			if ((_x find "mrk_blacklist_") >= 0) then {
				_markers pushBack _x;
				_x setMarkerAlpha 0;
			};
		} forEach allMapMarkers;
		
		/*
		_markers = [];
		{
			if (_x find format["wp_west_specops", D_LOCATION] >= 0) then {
				_markers pushBack _x;
			};
		} forEach allMapMarkers;
	
		//Create crash site marker
		
		_center = getMarkerPos (selectRandom _markers);
		_marker = createMarker ["mrk_west_specops", _center];
		_marker setMarkerType "b_recon";
		_marker setMarkerAlpha 0;
		
		{
			private _pos = _x select 0;
			private _marker = createMarker [(format ["mrk_spec_boat0%1", (_forEachIndex + 1)]), _pos];
			_marker setMarkerType "b_naval";
			_marker setMarkerAlpha 0;
			if (_forEachIndex == 1) exitWith {};
			
			private _obj = ((selectRandom D_FRACTION_WEST_UNITS_BOATS) createVehicle (_pos));
			_obj addItemCargoGlobal ["V_RebreatherIA", 6];
			_obj addItemCargoGlobal ["I_Assault_Diver", 6];
			_obj addItemCargoGlobal ["G_I_Diving", 6];
			if (D_MOD_ACE) then {
				_obj addItemCargoGlobal ["ACE_EarPlugs", 6];
			};
		} forEach (selectBestPlaces [_center, 600, "((waterDepth factor [1,1.4])/(1 + waterDepth))", 15, 12]);
		*/
		
		private _houses = nearestObjects [_center, D_PRISONS, 2000];
		while {count _houses > 0} do {
			private _blaklisted = false;
			private _house = selectRandom(_houses);
			{
				if (_house inArea _x) exitWith { _blaklisted = true; };
			} forEach _markers;
			if (!_blaklisted) exitWith {
				obj_prison = _house;
				private _marker = createMarker ["mrk_prison_01", getPos obj_prison];
				_marker setMarkerType "b_naval";
				_marker setMarkerText 'PRISON';
				_marker setMarkerAlpha 0;
			};
			if (_blaklisted) then {
				_houses = _houses - [_house];
			};
		};
		[_center] call Fn_Task_West_SafeHouse_WaponStash;
	};
};