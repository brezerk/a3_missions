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

//Player side triggers
// Client side code
if (hasInterface) then {
	
};

if (isServer) then {
	private ["_count", "_trgRegroupPoint"];

	task_complete_regroup = false;

	_trgRegroupPoint = createTrigger ["EmptyDetector", getMarkerPos 'wp_air_field_01'];
	_trgRegroupPoint setTriggerArea [30, 30, 0, false];
	_trgRegroupPoint setTriggerActivation ["WEST", "PRESENT", true];
	_trgRegroupPoint setTriggerStatements [
			"this",
			"",
			""
	];
	
	"PUB_fnc_kickFromAssaultGroup" addPublicVariableEventHandler {(_this select 1) call EventHander_Player_Killed};
	
	/*
	Event Handler for loaded or unloaded box
	*/
	EventHander_Player_Killed = {
		private ["_player", "_old_unit"];
		_player = _this select 0;
		_old_unit = _this select 1;
		
		if (_player in assault_group) then {
			assault_group = assault_group - [_player];
		};
	};
	
	while { !task_complete_regroup } do {
		sleep 10;
		_count = 0;
		//Check if assault group members are in the same area
		{	
			//Move trigger if member is still alive
			if (alive _x) then { 
				_trgRegroupPoint setPos (getPos _x);
				{
					if (_x inArea _trgRegroupPoint) then {
						_count = _count + 1;
					};
				} forEach list _trgRegroupPoint;
				
				if ((_count != 0) && (_count == count assault_group)) exitWith {
					['t_regroup', 'SUCCEEDED'] call BIS_fnc_taskSetState;
					task_complete_regroup = true;
				};
			};
		} forEach assault_group;
	};
	
	deleteVehicle _trgRegroupPoint;
};
