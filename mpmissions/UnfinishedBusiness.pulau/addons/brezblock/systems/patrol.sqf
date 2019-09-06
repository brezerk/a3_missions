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
Create CBA patrol
	Arguments: [_center, _side, _count, _radius]
	Usage: [_center, _side, _count, _radius] call BrezBlock_fnc_CreatePatrol;
	Return: Group
*/
if (isServer) then {
	params['_center', '_side', '_count', '_radius'];

	_Fn_BrezBlock_CreateRandomPatrolSquad = {
		params['_side', '_count'];
		private['_units'];
		private _grp = [];
		switch(_side) do
		{
			case west: {
			
			};
			case east: {
				_units = D_FRACTION_EAST_UNITS_PATROL;
			};
			case resistance: {
				_units = D_FRACTION_INDEP_UNITS_PATROL;
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

	private _cfg = [_side, _count] call _Fn_BrezBlock_CreateRandomPatrolSquad;
	private _pos = [_center, 5, _radius, 3, 0, 0, 0] call BIS_fnc_findSafePos;
	//http://arma3scriptingtutorials.blogspot.com/2014/02/config-viewer-what-is-it-and-how-to-use.html
	//_grp = [_pos, _side, configfile >> "CfgGroups" >> "Indep" >> D_FRACTION_INDEP >> "Infantry" >> _cfg] call BIS_fnc_spawnGroup;
	private _grp = [_pos, _side, _cfg] call BIS_fnc_spawnGroup;
	_grp deleteGroupWhenEmpty true;
	if (isClass(configFile >> "CfgPatches" >> "acex_main")) then {
		{
			private _chance = random 100;
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
	[_grp, _center, _radius, (round (_radius / 15)), "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [5,15,30]] call CBA_fnc_taskPatrol;
	if (_side in D_ADD_INTEL_ACTION) then {
		[
			(leader _grp),
			format [" ['%1'] call Fn_Local_West_Task_CollectIntel_Complete;", _side],
			"holdactions\holdAction_search",
			"ACTION_01",
			"&& ((side _this) in [west, civilian])",
			6,
			true
		] call BrezBlock_fnc_Attach_SearchIntel_Action;
	};
	_grp;
};