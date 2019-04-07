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
Spawn start objectives, triggers for game intro and players allocation
*/

if (isServer) then {

	Fn_Task_Create_ArriveToIsland = {
		trgJetIsDead = createTrigger ["EmptyDetector", getMarkerPos "wp_air_field_01" ];
		trgJetIsDead setTriggerArea [0, 0, 0, false];
		trgJetIsDead setTriggerActivation ["NONE", "PRESENT", false];
		trgJetIsDead setTriggerStatements [
			"!canMove us_airplane_01 || !alive us_airplane_01",
			"remoteExec ['Fn_Task_Create_ArriveToIsland_JetIsDown', 2]; deleteVehicle trgJetIsDead;",
			""
		];
		[
			west,
			"t_arrive_to_island",
			[localize "TASK_02_DESC",
			localize "TASK_02_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_air_field_01",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_arrive_to_island', "land"] call BIS_fnc_taskSetType;
		sleep 5;
		[
			west,
			"t_rebel_leader",
			[localize "TASK_01_DESC",
			localize "TASK_01_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_air_field_02",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_rebel_leader', "kill"] call BIS_fnc_taskSetType;
	};
	
	Fn_Task_Create_ArriveToIsland_JetIsDown = {
		//sleep 5;
		[0, "BLACK", 8, 1] remoteExec ["BIS_fnc_fadeEffect", 0];
		sleep 3;
		{
			doGetOut _x;
			moveOut _x;
		} forEach playableUnits;
		
		//spawn wreck (just a bit in advance so smoke can raise under the trees)
		_markerPos = getMarkerPos (["wp_plain_crash", 11] call BrezBlock_fnc_Get_RND_Index);
		_us_airplane_02 = [_markerPos, west, ["Land_Wreck_Plane_Transport_01_F", "Crater", "test_EmptyObjectForFireBig"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;

		sleep 5;

		{
			removeAllWeapons _x;
			removeAllItems _x;
			removeAllAssignedItems _x;
			removeBackpack _x;
			removeHeadgear _x;
			removeGoggles _x;
			
			_x addItemToUniform "ACE_EarPlugs";
			_x addItemToUniform "ACE_CableTie";
			for "_i" from 1 to 5 do {_x addItemToUniform "ACE_morphine";};
			for "_i" from 1 to 15 do {_x addItemToUniform "ACE_fieldDressing";};
			_x addGoggles "rhs_googles_clear";
			_x addWeapon "rhsusf_weap_m1911a1";
			_x addItemToVest "rhsusf_mag_7x45acp_MHP";
			for "_i" from 1 to 3 do {_x addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag";};
			for "_i" from 1 to 2 do {_x addItemToVest "Chemlight_green";};
			for "_i" from 1 to 2 do {_x addItemToVest "Chemlight_red";};
			_x setSpeaker "NoVoice";
			//ACEX
			_x addItemToVest "ACE_Canteen";
			_x linkItem "ItemWatch";
			_x linkItem "ItemMap";
			
			_x allowDamage true;
			
			//FIXME: Remove from list on selection
			_markerPos = getMarkerPos (["wp_player_spawn", 20] call BrezBlock_fnc_Get_RND_Index);
			
			//do some damage
			_dmgType = ["leg_l", "leg_r", "hand_r", "hand_l", "body", "head"];
			[_x, 2, selectRandom _dmgType, "bullet"] call ace_medical_fnc_addDamageToUnit;
			
			//parachute
			_x setPos [(_markerPos select 0), (_markerPos select 1), ((_markerPos select 2) + 130)];
			_x addBackpack "B_Parachute";
			_x action ["openParachute", _x];
			
			_x setVariable ["ACE_isUnconscious", true, true];
			_x setUnconscious true;
			
		} forEach playableUnits;
		[1, "BLACK", 10, 1] remoteExec ["BIS_fnc_fadeEffect", 0];
		
		sleep 1;
		{
			_x setVariable ["ACE_isUnconscious", false, false];
			_x setUnconscious false;
		} forEach playableUnits;
		
		{deleteVehicle _x} foreach crew us_airplane_01; deleteVehicle us_airplane_01;
		
		//"test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		/*_fire attachTo [this, [0, 0, 0]];
		_units = units _us_airplane_02;
		{
			_vehicle = assignedVehicle _x;
			if (!isNull _vehicle) exitWith {
				_vehicle setDamage 1;
			};
		} forEach _units;*/

	};

};