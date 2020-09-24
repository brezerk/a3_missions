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

resistance setFriend [civilian, 0];
civilian setFriend [resistance, 0];

if (isServer) then {
	box_01 addMagazineCargo ["CL_Antibiotic", 20];
	box_01 addMagazineCargo ["CL_PainKillers", 20];
	box_01 addItemCargo ["CL_Axe", 20];
	box_01 addItemCargo ["CL_Matches", 20];
	
	[west, 50] call BIS_fnc_respawnTickets;
	[east, 50] call BIS_fnc_respawnTickets;
	[civilian, 50] call BIS_fnc_respawnTickets;
	[independent, 50] call BIS_fnc_respawnTickets;
};
