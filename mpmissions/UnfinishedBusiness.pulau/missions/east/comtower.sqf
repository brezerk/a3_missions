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
		Spawn East Comtower. I'ts triggers and defenders;
		
		@params Position
	*/
	Fn_Spawn_East_Comtower = {
		params['_center'];
		
		private _markers = [_center, ["o_mortar"], 3000] call BrezBlock_fnc_GetAllMarkerTypesInRange;
		private _marker = selectRandom _markers;
		private _center = getMarkerPos (_marker);
		deleteMarker _marker;
		_marker = createMarker ["mrk_east_commtower", _center];
		_marker setMarkerType "hd_warning";
		_marker setMarkerText 'AOC Commtower';
		_marker setMarkerColor "ColorEAST";
		_marker setMarkerAlpha 0;
				
		_marker = createMarker ["mrk_east_commtower_zone", getMarkerPos "mrk_east_commtower"];
		_marker setMarkerSize [150, 150];
		_marker setMarkerBrush "BDiagonal";
		_marker setMarkerShape "ellipse";
		_marker setMarkerColor "ColorEAST";
		_marker setMarkerAlpha 0;
		
		//Spawn named object
		obj_east_comtower = createVehicle ["Land_Communication_F", _center];
		obj_east_comtower setVectorUp [0,0,1];
		//Publist to every client
		publicVariable "obj_east_comtower";
		
		[_center, east, 5, 50] call BrezBlock_fnc_CreateDefend;
	
		[_center, east, 2, 50] call BrezBlock_fnc_CreatePatrol;
		[_center, east, 2, 200] call BrezBlock_fnc_CreatePatrol;
		
		
		private _trg = createTrigger ["EmptyDetector", getPos obj_east_comtower];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"!alive obj_east_comtower;",
			"call Fn_Task_Destroy_Commtower_Complete; deleteVehicle thisTrigger;",
			""
		];
	};
	
	Fn_Task_Create_Destroy_Commtower = {
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_Create_Mission_Destroy_Commtower"];
		} else {
			remoteExecCall ["Fn_Local_Create_Mission_Destroy_Commtower", -2];
		};
		"mrk_east_commtower" setMarkerAlpha 1;
		"mrk_east_commtower_zone" setMarkerAlpha 1;
	};
	
	/*
		Executed on Comtower destruction;
	*/
	Fn_Task_Destroy_Commtower_Complete = {
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_Task_Destroy_Commtower_Complete"];
		} else {
			remoteExecCall ["Fn_Local_Task_Destroy_Commtower_Complete", -2];
		};
		task_complete_commtower = true;
	};
};