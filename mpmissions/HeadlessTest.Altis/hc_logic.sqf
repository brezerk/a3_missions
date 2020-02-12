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
 
 sleep 15;
 
 private _center = getMarkerPos "start";
 //private _lcs = nearestLocations [_center, ["NameVillage", "NameCity", "NameCityCapital"], 1500];

for "_i" from 1 to 3 do {

	[format ["Wave %1 of 5...", _i]] remoteExecCall ["systemChat"];

	for "_i" from 1 to 3 do {

		//private _lc = selectRandom _lcs;
		//private _pos = (locationPosition _lc) findEmptyPosition [600, 600, "O_Soldier_F"];
		private _pos = [_center, 700, 1000, 15, 0, 0, 0] call BIS_fnc_findSafePos;
		private _grp = [_pos, east, [
						'O_MRAP_02_hmg_F',
						'O_Soldier_F',
						'O_Soldier_F',
						'O_Soldier_F',
						'O_Soldier_F',,
						'O_Soldier_lite_F',
						'O_Soldier_SL_F',
						'O_Soldier_TL_F',
						'O_Soldier_GMG_F',
						'O_Soldier_HMG_F',
						'O_Soldier_AMG_F',
						'O_Soldier_GL_F',
						'O_Soldier_AR_F',
						'O_Soldier_A_F',
						'O_Soldier_AAR_F',
						'O_medic_F']] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		[_grp, _center] call BIS_fnc_taskAttack;
	 };
	 
	 for "_i" from 1 to 1 do {

		//private _lc = selectRandom _lcs;
		//private _pos = (locationPosition _lc) findEmptyPosition [600, 600, "O_Soldier_F"];
		private _pos = [_center, 700, 1000, 15, 0, 0, 0] call BIS_fnc_findSafePos;
		private _grp = [_pos, east, [
						'O_APC_Tracked_02_cannon_F',
						'O_Soldier_F',
						'O_Soldier_F',
						'O_Soldier_F',
						'O_Soldier_lite_F',
						'O_Soldier_SL_F',
						'O_Soldier_TL_F',
						'O_Soldier_GMG_F',
						'O_Soldier_HMG_F',
						'O_Soldier_AMG_F',
						'O_Soldier_GL_F',
						'O_Soldier_AT_F',
						'O_Soldier_A_F',
						'O_Soldier_AAR_F',
						'O_medic_F']] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		[_grp, _center] call BIS_fnc_taskAttack;
	 };
 
	sleep 420;
	
 };
 
 for "_i" from 4 to 6 do {

	[format ["Wave %1 of 6...", _i]] remoteExecCall ["systemChat"];

	for "_i" from 1 to 3 do {

		//private _lc = selectRandom _lcs;
		//private _pos = (locationPosition _lc) findEmptyPosition [600, 600, "O_Soldier_F"];
		private _pos = [_center, 700, 1000, 15, 0, 0, 0] call BIS_fnc_findSafePos;
		private _grp = [_pos, east, [
						'O_APC_Wheeled_02_rcws_v2_F',
						'O_Soldier_F',
						'O_Soldier_F',
						'O_Soldier_F',
						'O_Soldier_lite_F',
						'O_Soldier_SL_F',
						'O_Soldier_TL_F',
						'O_Soldier_GMG_F',
						'O_Soldier_HMG_F',
						'O_Soldier_AMG_F',
						'O_Soldier_GL_F',
						'O_Soldier_AR_F',
						'O_Soldier_A_F',
						'O_Soldier_AAR_F',
						'O_medic_F']] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		[_grp, _center] call BIS_fnc_taskAttack;
	 };
	 
	 for "_i" from 1 to 2 do {

		//private _lc = selectRandom _lcs;
		//private _pos = (locationPosition _lc) findEmptyPosition [600, 600, "O_Soldier_F"];
		private _pos = [_center, 700, 1000, 15, 0, 0, 0] call BIS_fnc_findSafePos;
		private _grp = [_pos, east, [
						'O_MBT_02_cannon_F',
						'O_Soldier_F',
						'O_Soldier_F',
						'O_Soldier_F',
						'O_Soldier_lite_F',
						'O_Soldier_SL_F',
						'O_Soldier_TL_F',
						'O_Soldier_GMG_F',
						'O_Soldier_HMG_F',
						'O_Soldier_AMG_F',
						'O_Soldier_GL_F',
						'O_Soldier_AT_F',
						'O_Soldier_A_F',
						'O_Soldier_AAR_F',
						'O_medic_F']] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		[_grp, _center] call BIS_fnc_taskAttack;
	 };
 
	sleep 420;
	
 };
 
 sleep 600;
 
 "EveryoneWon" call BIS_fnc_endMissionServer;