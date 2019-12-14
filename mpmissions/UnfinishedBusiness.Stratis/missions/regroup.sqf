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
	task_complete_regroup = false;
	
	"PUB_fnc_kickFromAssaultGroup" addPublicVariableEventHandler {(_this select 1) call EventHander_Player_Killed};
	
	/*
	Event Handler for loaded or unloaded box
	*/
	EventHander_Player_Killed = {
		private ["_player", "_old_unit"];
		_player = _this select 0;
		_old_unit = _this select 1; //FIXME: Should we use this instead?
		if (_player in assault_group) then {
			assault_group = assault_group - [_player];
		};
	};
	
	while { !task_complete_regroup } do {
		private ["_count"];
		sleep 10;
		_count = 0;
		//Check if assault group members are in the same area
		{	
			//Move trigger if member is still alive
			if (alive _x) exitWith {
				_count = 1;
				{
					if (_x getVariable ["is_assault_group", false]) then {
						_count = _count + 1;
					};
				} forEach nearestObjects [_x, ["SoldierWB"], 15];
			};
		} forEach assault_group;
		if ((_count != 0) && (_count == count assault_group)) exitWith {
			task_complete_regroup = true;
		};
	};
	
	 ['t_regroup', 'SUCCEEDED'] call BIS_fnc_taskSetState;
};
