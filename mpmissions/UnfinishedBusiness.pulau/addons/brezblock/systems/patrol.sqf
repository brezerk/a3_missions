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
	Arguments: [_marker]
	Usage: [_marker] call BrezBlock_fnc_CreatePatrol;
	Return: Group
*/
if (isServer) then {
	params['_marker'];
	private['_grp', '_center', '_radius', '_side', '_cfg'];
	
	_radius = getMarkerSize _marker select 0;
	_center = getMarkerPos _marker;
	
	//https://community.bistudio.com/wiki/Arma_3_CfgMarkerColors
	switch (getMarkerColor _marker) do
	{
		case "ColorWEST": { _side = west; };
		case "ColorEAST": { _side = east; };
		case "ColorGUER": { 
			_side = resistance;
			switch (D_FRACTION_INDEP) do
			{
				case "CUP_I_NAPA": { _cfg = selectRandom["CUP_I_NAPA_InfTeam_1", "CUP_I_NAPA_InfTeam_2"]; };
				case "CUP_I_TK_GUE": { _cfg = "CUP_I_TK_GUE_Patrol"; };
				case "IND_F": { _cfg = "HAF_InfSentry"; };
				case "IND_G_F": { _cfg = "I_G_InfTeam_Light"; };
			};
			 
			//_cfg =  (configfile >> "CfgGroups" >> "Indep" >> "CUP_I_NAPA" >> "Infantry" >> (selectRandom []));
		};
		case "ColorWEST": { _side = civilian; };
		 default { _side = sideUnknown };
	};
	_pos = [_center, 5, _radius, 3, 0, 0, 0] call BIS_fnc_findSafePos;
	//http://arma3scriptingtutorials.blogspot.com/2014/02/config-viewer-what-is-it-and-how-to-use.html
	_grp = [_pos, _side, configfile >> "CfgGroups" >> "Indep" >> D_FRACTION_INDEP >> "Infantry" >> _cfg] call BIS_fnc_spawnGroup;
	_grp deleteGroupWhenEmpty true;
	systemChat format ["F %1", (round (_radius / 15) + 5)];
	[_grp, _center, _radius, round (round (_radius / 15) + 5), "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [5,15,30]] call CBA_fnc_taskPatrol;
	_grp;
};