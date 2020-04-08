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


		//Execute revive animation
		[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
		//Wait for revive animation to be set
		waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
		//call progress
		player removeMagazine "rvg_flare";
		[
			10,
			[],
			{
				[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
				[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];			
				private _obj = "Land_Campfire" createVehicle ([0,0,0]);
				_obj setPosASL (player modelToWorldWorld [0,2,0]);
				_obj inflame true;
				[_obj] spawn BrezBlock_fnc_Local_Systems_Survival_Fireplace_Despawn;
			},
			{
				[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
				[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
			},
			"Розводжу багаття",
			{
				//fixme: 
				true
			}
		] call ace_common_fnc_progressBar;
