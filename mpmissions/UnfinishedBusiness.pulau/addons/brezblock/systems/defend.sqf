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
	Arguments: [_center, _side, _count, _radius]
	Usage: [_center, _side, _count, _radius] call BrezBlock_fnc_CreateDefend;
	Return: Group
*/
if (isServer) then {

	params['_center', '_side', '_count', '_radius'];

	_Fn_BrezBlock_CreateRandomDefendSquad = {
		params['_side', '_count'];
		private['_units'];
		private _grp = [];
		switch(_side) do
		{
			case west: {
			
			};
			case east: {
				switch (D_FRACTION_EAST) do {
					case "CUP_O_SLA": {
						_units = [
							'CUP_O_sla_Soldier',
							'CUP_O_SLA_Soldier_Backpack',
							'CUP_O_sla_Soldier_GL',
							'CUP_O_sla_Soldier_AR',
							'CUP_O_sla_Medic',
							'CUP_O_sla_Soldier_AT',
							'CUP_O_sla_Sniper',
							'CUP_O_sla_Soldier_MG',
							'CUP_O_sla_Engineer',
							'CUP_O_sla_Soldier_AMG',
							'CUP_O_sla_Soldier_LAT'
						];
					};
					case "CUP_O_TK": {
						_units = [
							'CUP_O_TK_Soldier',
							'CUP_O_TK_Soldier_SL',
							'CUP_O_TK_Soldier_LAT',
							'CUP_O_TK_Medic',
							'CUP_O_TK_Soldier_AMG',
							'CUP_O_TK_Soldier_AT',
							'CUP_O_TK_Soldier_AA',
							'CUP_O_TK_Soldier_MG',
							'CUP_O_TK_Soldier_GL',
							'CUP_O_TK_Soldier_AR'
						];
					};
					case "CUP_O_ChDKZ": {
						_units = [
							'CUP_O_TK_Soldier',
							'CUP_O_TK_Soldier_LAT',
							'CUP_O_TK_Medic',
							'CUP_O_TK_Soldier_AT',
							'CUP_O_TK_Soldier_AAT',
							'CUP_O_TK_Soldier_MG',
							'CUP_O_TK_Soldier_AMG',
							'CUP_O_TK_Soldier_AA',
							'CUP_O_TK_Soldier_SL',
							'CUP_O_TK_Soldier_AR',
							'CUP_O_TK_Soldier_GL'
						];
					};
				};
			};
			case resistance: {
				switch (D_FRACTION_INDEP) do
				{
					case "CUP_I_RACS": { 
						_units = [
							'CUP_I_RACS_Soldier_Light_Mech',
							'CUP_I_RACS_Soldier_AMG_Mech',
							'CUP_I_RACS_Soldier_Mech',
							'CUP_I_RACS_Soldier_Light_Mech',
							'CUP_I_RACS_Soldier_MAT_Mech',
							'CUP_I_RACS_Soldier_Light_Mech',
							'CUP_I_RACS_Medic_Mech',
							'CUP_I_RACS_MMG_Mech',
							'CUP_I_RACS_AR_Mech',
							'CUP_I_RACS_Soldier_Light_Mech',
							'CUP_I_RACS_M_Mech',
							'CUP_I_RACS_Soldier_Light_Mech',
							'CUP_I_RACS_SL_Mech'
						];
					};
					case "CUP_I_NAPA": { 
						_units = [
							'CUP_I_GUE_Soldier_AKS74',
							'CUP_I_GUE_Soldier_AKM',
							'CUP_I_GUE_Soldier_AKSU',
							'CUP_I_GUE_Soldier_MG',
							'CUP_I_GUE_Soldier_AR',
							'CUP_I_GUE_Soldier_AT',
							'CUP_I_GUE_Soldier_AA',
							'CUP_I_GUE_Soldier_GL',
							'CUP_I_GUE_Saboteur',
							'CUP_I_GUE_Medic',
							'CUP_I_GUE_Officer',
							'CUP_I_GUE_Crew'
						];
					};
					case "CUP_I_TK_GUE": { 
						_units = [
							'CUP_I_TK_GUE_Soldier',
							'CUP_I_TK_GUE_Soldier_AK_74S',
							'CUP_I_TK_GUE_Guerilla_Enfield',
							'CUP_I_TK_GUE_Guerilla_Medic',
							'CUP_I_TK_GUE_Soldier_M16A2',
							'CUP_I_TK_GUE_Soldier_AR',
							'CUP_I_TK_GUE_Soldier_AT',
							'CUP_I_TK_GUE_Soldier_AA',
							'CUP_I_TK_GUE_Soldier_MG',
							'CUP_I_TK_GUE_Soldier_TL',
							'CUP_I_TK_GUE_Soldier_LAT',
							'CUP_I_TK_GUE_Sniper'
						];
					};
					case "IND_F": {
						_units = [
							'I_soldier_F',
							'I_Soldier_LAT_F',
							'I_Soldier_AT_F',
							'I_Soldier_AA_F',
							'I_Soldier_GL_F',
							'I_Soldier_TL_F',
							'I_Soldier_M_F',
							'I_Soldier_AR_F',
							'I_support_MG_F',
							'I_Soldier_lite_F',
							'I_medic_F'
						];
					};
					case "IND_G_F": {
						_units = [
							'I_G_Soldier_F',
							'I_G_Soldier_lite_F',
							'I_G_medic_F',
							'I_G_Soldier_SL_F',
							'I_G_Soldier_AR_F',
							'I_G_medic_F',
							'I_G_Soldier_GL_F',
							'I_G_Soldier_M_F',
							'I_G_Soldier_LAT_F',
							'I_G_Soldier_A_F'
						];
					};
				};
			};
			case civilian: {
			
			};
		};
		for "_i" from 1 to _count do
		{
			_grp pushBack (selectRandom _units);
		};
		_grp;
	};
		
	private _cfg = [_side, _count] call _Fn_BrezBlock_CreateRandomDefendSquad;
	private _pos = [_center, 5, _radius, 3, 0, 0, 0] call BIS_fnc_findSafePos;
	
	//http://arma3scriptingtutorials.blogspot.com/2014/02/config-viewer-what-is-it-and-how-to-use.html
	//_grp = [_pos, _side, configfile >> "CfgGroups" >> "Indep" >> D_FRACTION_INDEP >> "Infantry" >> _cfg] call BIS_fnc_spawnGroup;
	private _grp = [_pos, _side, _cfg] call BIS_fnc_spawnGroup;
	_grp deleteGroupWhenEmpty true;
	if (isClass(configFile >> "CfgPatches" >> "acex_main")) then {
		{
			private _chance = (random 100);
			if (_chance > 80) then {
				_x addItemToUniform "ACE_Canteen";
			} else {
				if (_chance > 35) then {
					_x addItemToUniform "ACE_Canteen_Half";
				} else {
					_x addItemToUniform "ACE_Canteen_Empty";
				};
			};
			if (_chance > 60) then {
				_x addItemToUniform (selectRandom ["ACE_MRE_BeefStew",
										  "ACE_MRE_ChickenTikkaMasala",
										  "ACE_MRE_ChickenHerbDumplings",
										  "ACE_MRE_CreamChickenSoup",
										  "ACE_MRE_CreamTomatoSoup",
										  "ACE_MRE_LambCurry",
										  "ACE_MRE_MeatballsPasta",
										  "ACE_MRE_SteakVegetables"]);
			};
		} forEach units _grp;
	};
	
	if (isClass(configFile >> "CfgPatches" >> "cba_main")) then {
		[_grp, _center, _radius] call CBA_fnc_taskDefend;
	} else {
		[_grp, _center] call bis_fnc_taskDefend;
	};
	
	_grp;
};