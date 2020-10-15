/***************************************************************************************
 * Copyright (C) 2008-2020 by Oleksii S. Malakhov <brezerk@gmail.com>                  *
 *                                                                                     *
 * This program is is licensed under a                                                 *
 * Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. *
 *                                                                                     *
 * You should have received a copy of the license along with this                      *
 * work. If not, see <http://creativecommons.org/licenses/by-nc-nd/4.0/>.              *
 *                                                                                     *
 **************************************************************************************/
 
 

 /*
 waitUntil {!isNil "D_HOSPITAL_LCS"};
 
 systemChat str D_HOSPITAL_LCS;
 
 {
	private _marker = createMarker [(format ["mrk_hospital_%1", _forEachIndex]), _x];
	_marker setMarkerType "flag_UN";
 } forEach D_HOSPITAL_LCS;
*/


east_base_built = 0;
west_base_built = 0;

//resistance setFriend [civilian, 0];
//civilian setFriend [resistance, 0];

if (isServer) then {

	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		tf_give_personal_radio_to_regular_soldier = true;
		publicVariable "tf_give_personal_radio_to_regular_soldier";
		
		tf_no_auto_long_range_radio = true;
		publicVariable "tf_no_auto_long_range_radio";

		tf_same_sw_frequencies_for_side = true;
		publicVariable "tf_same_sw_frequencies_for_side";
		
		private _settingsSwWest = false call TFAR_fnc_generateSwSettings;
		_settingsSwWest set [2, ["311","312","313","314","315","316","317","318"]];
		tf_freq_west = _settingsSwWest;
		publicVariable "tf_freq_west";
		
		private _settingsSwEast = false call TFAR_fnc_generateSwSettings;
		_settingsSwEast set [2, ["101","110","117","134","195","131","171","188"]];
		tf_freq_east = _settingsSwEast;
		publicVariable "tf_freq_east";
	};
	
	[west, 35] call BIS_fnc_respawnTickets;
	[east, 35] call BIS_fnc_respawnTickets;
	[independent, 16] call BIS_fnc_respawnTickets;
	
	publicVariable "east_base_built"; 
	publicVariable "west_base_built"; 
	
	waitUntil { time > 5 };
	
	setTimeMultiplier 6;
	
	bb_threat_chem_areas pushBack [obj_target_x25, D_THREAT_CHEM_LOCAL, 140, 0.0003];
	publicVariable "bb_threat_chem_areas";
	
	execVM "cargo.sqf";
	
//	[civilian, 50] call BIS_fnc_respawnTickets;
//	[independent, 50] call BIS_fnc_respawnTickets;
};
