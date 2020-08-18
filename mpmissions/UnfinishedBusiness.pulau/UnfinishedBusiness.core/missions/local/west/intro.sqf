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

//Player side triggers
// Client side code
if (hasInterface) then {

	west_order_seen = false;

	Fn_Local_Create_WEST_MissionIntro = {
		if (side player != west) exitWith {};
		if (player getVariable ["is_civilian", false]) exitWith {};
		if (!mission_plane_send) then {
			if (!west_order_seen) then {
				[] execVM "UnfinishedBusiness.core\ui\orderDialog.sqf";
				west_order_seen = true;
			};
			if ((roleDescription player find "SpecOps") >= 0) then {
				waitUntil {!isNull obj_specops_target};
				switch (typeOf obj_specops_target) do {
					case "C_scientist_F": {
						[getPos obj_specops_target] call Fn_Local_Create_Mission_KillDoctor;
					};
					case "B_Slingload_01_Ammo_F": {
						[getPos obj_specops_target] call Fn_Local_Create_Mission_DestroyAmmo;
					};
					case "Land_wpp_Turbine_V1_off_F": {
						[getPos obj_specops_target] call Fn_Local_Create_Mission_DestroyWindMill;
					};
					case "Land_dp_smallTank_F": {
						[getPos obj_specops_target] call Fn_Local_Create_Mission_DestroyFuel;
					};
				};
			} else {
				if (player in ((units us_group_01) + (units us_group_02) + (units us_group_03))) then {
					[
						player,
						"t_arrive_to_island",
						[
						format [localize "TASK_02_DESC", D_LOCATION],
						format [localize "TASK_02_TITLE", D_LOCATION],
						localize "TASK_ORIG_01"],
						getMarkerPos "mrk_airfield",
						"CREATED",
						0,
						true
					] call BIS_fnc_taskCreate;
					['t_arrive_to_island', "land"] call BIS_fnc_taskSetType;
				} else {
					[
						player,
						"t_wait_for_orders",
						[
						format [localize "TASK_18_DESC", D_LOCATION],
						format [localize "TASK_18_TITLE", D_LOCATION],
						localize "TASK_ORIG_01"],
						getPos player,
						"CREATED",
						0,
						true
						] call BIS_fnc_taskCreate;
						['t_wait_for_orders', 'wait'] call BIS_fnc_taskSetType;
				};
			};
		} else {
			if ((alive us_airplane_01) && (canMove us_airplane_01)) then {
				[
					player,
					"t_wait_for_orders",
					[
					format [localize "TASK_18_DESC", D_LOCATION],
					format [localize "TASK_18_TITLE", D_LOCATION],
					localize "TASK_ORIG_01"],
					getPos player,
					"CREATED",
					0,
					true
				] call BIS_fnc_taskCreate;
				['t_wait_for_orders', 'wait'] call BIS_fnc_taskSetType;
			} else {
				//Airplan is down, We need to assign resque mission
				call Fn_Local_Create_RescueMission;
				//FIXME: we need some flag set by controller.sqf
				//to confirm server is done with spawning units :(
				sleep 60;
				call Fn_Local_Civilian_AttachConfiscate_Action;
				call Fn_Local_Civilian_AttachInformator_Action;
				call Fn_Local_Create_MissionAA;
				call Fn_Local_West_Create_Mission_CollectIntel;
			};
		};
	};
	
};