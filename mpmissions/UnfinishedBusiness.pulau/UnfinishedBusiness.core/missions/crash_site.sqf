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
Crash site side-mission code
*/

// Server-only code
if (isServer) then {
	/*
	Spawn random heli crash site
		Arguments: None
		Usage: call Fn_Task_Create_HelicopterCrashSite
	*/
	Fn_Task_Create_C130J_CrashSite = {
		params ["_markerPos"];
		
		//do envonmental damage
		for "_i" from 1 to 5 do {
			private _boom = createVehicle ["Sh_120mm_HE", _markerPos, [], 0, "FLY"];
			_boom setPos [((getPos _boom select 0) + (round(random 25) - 10)), ((getPos _boom select 1) + (round(random 25) - 10)), 250];
			_boom setVelocity [0,0,-50];
		};
		
		//spawn creater and wreck
		private _crater = "CraterLong" createVehicle (_markerPos); 
		private _obj = ([west, D_FRACTION_WEST, "transport_wreck"] call Fn_Config_GetFraction_Units) createVehicle (_markerPos); 
		_obj attachTo [_crater, [-1.5, -4, 3.5]];
		//put fire and smoke
		private _fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_crater, [0, -10.5, 0]];
		_fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_crater, [0, -6, 0]];
		[_markerPos, resistance, 2, 150] call BrezBlock_fnc_CreatePatrol;
		[_markerPos] remoteExec ["Fn_Task_C130J_CrashSite_Info"];
	};
	
	
	/*
	Spawn cargo crate randomly. Remove all predefined items and populate with a desired ones;
		Arguments: [spawn marker]
		Usage: [{SpawnMarker}]] call Fn_Task_Create_ArriveToIsland_SpawnRandomCargo;
		Return: create object
	*/
	Fn_Task_Create_C130J_SpawnRandomCargo = {
		params ["_markerPos"];
		
		private _pos = [_markerPos, 0, 35, 4, 0, 0, 0] call BIS_fnc_findSafePos;
		private _obj = "B_supplyCrate_F" createVehicle (_pos);
		
		[_obj, "crash", west, D_FRACTION_WEST] call BrezBlock_fnc_PopulateBaseSupply;		
		_obj;
	};
	
	private _crashSitePos = getMarkerPos "mrk_west_crashsite";
	
	[_crashSitePos] call Fn_Task_Create_C130J_CrashSite;

	
	private _free_landing_markers = [];
	{
		if (_x find format["wp_%1_paradrop", D_LOCATION] >= 0) then {
			if (_crashSitePos distance2D getMarkerPos _x <= 1300) then {
				_free_landing_markers pushBack _x;
			};
		};
	} forEach allMapMarkers;

	{
		private _marker = selectRandom _free_landing_markers;
		//_free_landing_markers = _free_landing_markers - [_marker];
		private _markerPos = getMarkerPos _marker;
		//parachute
		_x setPos [((_markerPos select 0) + (200 - (random 400))), ((_markerPos select 1) + (200 - (random 400))), ((_markerPos select 2) + 400 + random 100)];
		_x setVariable ["ACE_isUnconscious", true, true];
		[D_DIFFICLTY] remoteExecCall ["Fn_Local_Jet_Player_DoParadrop", _x];
	} forEach assault_group;
		
	{deleteVehicle _x} foreach crew us_airplane_01; deleteVehicle us_airplane_01;
	
	[_crashSitePos] call Fn_Task_Create_C130J_SpawnRandomCargo;	
	//heli patrol
	[_crashSitePos] call Fn_Patrols_CreateLoiter;
		
	//create tasks assigned to assault_group
	{
		_x setVariable ["ACE_isUnconscious", false, true];
		remoteExecCall ["Fn_Local_Jet_Player_Land", _x];
	} forEach assault_group;
		
	sleep 5;
		
	[] execVM "UnfinishedBusiness.core\missions\regroup.sqf";
	[] execVM "UnfinishedBusiness.core\missions\assoult_group_is_dead.sqf";
	[] execVM "UnfinishedBusiness.core\missions\informator.sqf";
	call Fn_Task_Create_AA;
	

		
	//Send vehicles on patrol
	call Fn_Patrols_Create_Random_Waypoints;
	
	call Fn_Task_Create_RescueMission;
	
	//Cleanup unneded markers
	{
		if (_x find "wp_" >= 0) then {
			deleteMarker _x;
		};
	} forEach allMapMarkers;
	
	sleep 60;
	
	[_crashSitePos, 0] call Fn_Patrols_Create_AssaultGroup;
	remoteExecCall ["Fn_Local_West_Create_Mission_CollectIntel"];
	
	sleep 60;
	
	remoteExecCall ["Fn_Local_Civilian_AttachConfiscate_Action"];
	
	execVM "UnfinishedBusiness.core\missions\ping.sqf";
};