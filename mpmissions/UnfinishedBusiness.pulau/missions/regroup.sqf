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
		
		//["killed handler acticated"] remoteExec ["systemChat"];
		
		if (_player in assault_group) then {
			//["ok. kick from group"] remoteExec ["systemChat"];
			assault_group = assault_group - [_player];
		};
		/*
		private ["_vehicle", "_item", "_value"];

		_value = _this select 2;
		if (_vehicle == ua_ural_ammo_01) then {
			if (typeName _item == "OBJECT") then {
				//FIXME: maybe we need dynamic eval
				if (_item == ua_supply_box_01) then { task_loaded_ua_supply_box_01 = _value; };
				if (_item == ua_supply_box_02) then { task_loaded_ua_supply_box_02 = _value; };
				if (_item == ua_supply_box_03) then { task_loaded_ua_supply_box_03 = _value; };
				if (_item == ua_supply_box_04) then { task_loaded_ua_supply_box_04 = _value; };
				if (_item == ua_supply_box_05) then { task_loaded_ua_supply_box_05 = _value; };
			};
		};
		
		//[<oldUnit>, <killer>, <respawn>, <respawnDelay>]
		_oldUnit = _this select 0; //killed player, getUnitLoadout

		
		*/
	};
	
	while { !task_complete_regroup } do {
		sleep 10;
		_count = 0;
		//Check if assault group members are in the same area
		{	
			//Move trigger if member is still alive
			if (alive _x) exitWith { 
				//["move trigger"] remoteExec ["systemChat"];
				_trgRegroupPoint setPos (getPos _x);
				{
					if (_x inArea _trgRegroupPoint) then {
						//["unit in area +1"] remoteExec ["systemChat"];
						_count = _count + 1;
					};
				} forEach list _trgRegroupPoint;
				
				//[format ["%1 %2", _count, count assault_group]] remoteExec ["systemChat"];
				if ((_count != 0) && (_count == count assault_group)) exitWith {
					['t_regroup', 'SUCCEEDED'] call BIS_fnc_taskSetState;
					task_complete_regroup = true;
				};
			};
		} forEach assault_group;
	};
	
	deleteVehicle _trgRegroupPoint;
};