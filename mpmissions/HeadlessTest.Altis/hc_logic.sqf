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
 
private _cfg_inf = ['O_Soldier_F',
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
				'O_medic_F'];

private _cfg_veh = [
	['O_MRAP_02_gmg_F', 'O_MRAP_02_hmg_F'],
	['O_MRAP_02_gmg_F', 'O_MRAP_02_hmg_F'],
	['O_APC_Wheeled_02_rcws_v2_F', 'O_APC_Tracked_02_cannon_F'],
	['O_APC_Wheeled_02_rcws_v2_F', 'O_APC_Tracked_02_cannon_F'],
	['O_MBT_02_cannon_F']
];

Fn_Generate_InfCop = {
	private _comp = [];
	for "_i" from 1 to 10 do {
		_comp pushBack selectRandom _cfg_inf;
	};
	_comp;
};

for "_i" from 1 to 3 do {
	[format ["Wave %1 of 5...", _i]] remoteExecCall ["systemChat"];
	for "_x" from 1 to 5 do {
		private _pos = [_center, 700, 1000, 15, 0, 0, 0] call BIS_fnc_findSafePos;
		private _comp = [];
		_comp pushBack selectRandom (_cfg_veh select _i);
		_comp = _comp + (call Fn_Generate_InfCop);
		
		private _grp = [_pos, east, _comp] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		[_grp, _center] call BIS_fnc_taskAttack;
	};
	 
	sleep 350;
};
 
sleep 600;
 
"EveryoneWon" call BIS_fnc_endMissionServer;