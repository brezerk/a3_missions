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

// Intended to be executed on player side
Fn_Task_HelicopterCrashSite_Info = {
	if (!isDedicated) then {
		params['_marker'];
		private ["_trg"];
		_trg = createTrigger ["EmptyDetector", getMarkerPos _marker];
		_trg setTriggerArea [50, 50, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerStatements [
			"(vehicle player) in thisList",
			"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_05', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
			""
		];
	};
};

// Server-only code
if (isServer) then {
	/*
	Spawn random heli crash site
		Arguments: None
		Usage: call Fn_Task_Create_HelicopterCrashSite
	*/
	Fn_Task_Create_HelicopterCrashSite = {
		private ["_marker"];
		_marker = ["wp_t_heli_crash", 8] call BrezBlock_fnc_Get_RND_Index;
		[_marker, ["rus_heli_crash", 4] call BrezBlock_fnc_Get_RND_Index] call BrezBlock_fnc_Spawn_Objective;
		[
			p_officer_02,
			{ _this remoteExec ["Fn_Task_HelicopterCrashSite_DocsFound", 2] }
		] call BrezBlock_fnc_Attach_Hold_Action;
		[
			independent,
			"t_heli_scured",
			[localize "TASK_07_DESC",
			localize "TASK_07_TITLE",
			localize "TASK_ORIG_02"],
			getMarkerPos _marker,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_heli_scured', "unknown"] call BIS_fnc_taskSetType;
		trgHeliSecured = createTrigger ["EmptyDetector", getMarkerPos _marker];
		trgHeliSecured setTriggerArea [18, 18, 0, false];
		trgHeliSecured setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		trgHeliSecured setTriggerStatements [
			"this",
			"if (isServer) then { task_completed_02 = true; ['t_heli_scured', 'SUCCEEDED'] call BIS_fnc_taskSetState; deleteVehicle trgHeliSecured; [1000] call Fn_Modify_Rating; };",
			""
		];
		[_marker] remoteExec ["Fn_Task_HelicopterCrashSite_Info"];
	};
	
	/*
	If Heli docs were found;
	*/
	Fn_Task_HelicopterCrashSite_DocsFound = {
		task_completed_05 = true;
		[
			independent,
			["t_doc_02", "t_doc_search"],
			[localize "TASK_11_DESC",
			localize "TASK_11_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"SUCCEEDED",
			0,
			true
		] call BIS_fnc_taskCreate;
		["outpost_docs_found"] remoteExec ["playSound"];
		["rhs_usa_land_rc_28"] remoteExec ["playSound"];
		[2000] call Fn_Modify_Rating;
		if (task_completed_07 && task_completed_06 && task_completed_05 && task_completed_04) then {
			["t_doc_search", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;
		};
	};
};
