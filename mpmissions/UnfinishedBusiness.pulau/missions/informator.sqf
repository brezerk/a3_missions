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

	//Global task state
	task_complete_intormator = false;


	"PUB_fnc_informatorFound" addPublicVariableEventHandler {(_this select 1) call EventHander_InformatorFound};
	
	/*
	Event Handler for loaded or unloaded box
	*/
	EventHander_InformatorFound = {
		task_complete_intormator = true;
	};

	/*
	Select random Informator unit. Disable MOVE and place the trigger
		Arguments: None
		Usage: call Fn_Task_Create_Informator
	*/
	Fn_Task_Create_Informator = {
		private ["_monse", "_minanga", "_lalomo", "_apal"];
		//Assign civilians to groups
		_monse = [
			p_civ_10,
			p_civ_11,
			p_civ_12
		];
		_minanga = [
			p_civ_00,
			p_civ_01,
			p_civ_02,
			p_civ_03
		];
		_lalomo = [
			p_civ_20,
			p_civ_21,
			p_civ_22,
			p_civ_23,
			p_civ_24
		];
		_apal = [
			p_civ_30,
			p_civ_31,
			p_civ_32,
			p_civ_33,
			p_civ_34
		];
		
		// try to make civilians not to run away
		east setFriend [civilian, 1];
		civilian setFriend [east, 1];
		independent setFriend [civilian, 1];
		civilian setFriend [independent, 1];
		
		{ _x setBehaviour "CARELESS"; } forEach _monse;
		{ _x setBehaviour "CARELESS"; } forEach _minanga;
		{ _x setBehaviour "CARELESS"; } forEach _lalomo;
		{ _x setBehaviour "CARELESS"; } forEach _apal;
		
		selectRandom [_monse] call Fn_Task_Create_Informator_Attach_Action;
		selectRandom [_minanga] call Fn_Task_Create_Informator_Attach_Action;
		selectRandom [_lalomo] call Fn_Task_Create_Informator_Attach_Action;
		selectRandom [_apal] call Fn_Task_Create_Informator_Attach_Action;
	};
	
	/*
	Select random Informator unit. Disable MOVE and place the trigger
		Arguments: None
		Usage: call Fn_Task_Create_Informator_Attach_Action
	*/
	Fn_Task_Create_Informator_Attach_Action = {
		params['_obj'];
		private['_action_id'];
		
		_obj disableAi "MOVE";
		_action_id = [
			_obj,
			{ _this call Fn_Task_Create_Informator_Complete; },
			"simpleTasks\types\talk",
			"ACTION_02",
			"&& alive _target"
		] call BrezBlock_fnc_Attach_Hold_Action;
		
		remoteExecCall ["Fn_Local_Create_MissionInformator", -2];
	};	
};