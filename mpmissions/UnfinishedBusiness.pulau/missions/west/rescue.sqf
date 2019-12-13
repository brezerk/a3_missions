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

if (isServer) then {

	Fn_Task_Create_RescueMission = {
		{
			remoteExecCall ["Fn_Local_Create_RescueMission", _x];
			[_x, true] remoteExecCall ["allowDamage"];
		} forEach  (playableUnits + switchableUnits);
		
		//FIXME: _trigger = [objnull, "myMarkerName"] call BIS_fnc_triggerToMarker;
		//This will make a new trigger that is the same size and position of the 
		//passed in marker name (marker has to be of type "RECTANGLE" or "ELLIPSE").
		trgRescueMission = createTrigger ["EmptyDetector", getPos us_liberty_01];
		trgRescueMission setTriggerArea [2000, 2000, 0, false];
		trgRescueMission setTriggerActivation ["WEST", "PRESENT", false];
		trgRescueMission setTriggerStatements [
			"call Fn_RescueMission_TriggerEval;",
			"['t_west_rescue', 'SUCCEEDED'] call BIS_fnc_taskSetState; call Fn_Endgame_EvacPoint;",
			""
		];
	};
	
	Fn_RescueMission_TriggerEval = {
		private _all = true;
		if ((count assault_group) <= 0) then { 
			_all = false;
		} else {
			{
				if (!(_x inArea trgRescueMission)) then {
					_all = false;
				};
			} forEach assault_group;
		};
		_all;
	};

};