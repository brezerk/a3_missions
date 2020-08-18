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

// Intended to be executed on player side
if (hasInterface) then {

	Fn_Local_Create_CIV_MissionIntro = {
		if (side player != civilian) exitWith {};
		if (player getVariable ["is_assault_group", false]) exitWith {};
	
		if (!civ_order_seen) then {
			civ_order_seen = true;
			[] execVM "UnfinishedBusiness.core\ui\orderDialog.sqf";
			"respawn_civ" setMarkerTextLocal (localize "INFO_SUBLOC_12");
			"respawn_civ" setMarkerAlphaLocal 1;
			"mrk_civ_hospital" setMarkerAlphaLocal 1;
			"mrk_west_base_01" setMarkerAlphaLocal 0;
			"mrk_west_specops" setMarkerAlphaLocal 0;
			"mrk_west_safezone_01" setMarkerAlphaLocal 0;
			"mrk_east_stash_01" setMarkerAlphaLocal 0;
			"mrk_east_stash_02" setMarkerAlphaLocal 0;
			
		};

		//player setPos (getMarkerPos "respawn_civ");
		call Fn_Local_Create_Task_Civilian_FloodedShip;
		call Fn_Local_Create_Task_Civilian_WaponStash;
		//call Fn_Local_Create_Task_Civilian_Police;
		call Fn_Local_Create_Task_Civilian_Liberate_MissionIntro;
		call Fn_Local_Create_Mission_CrashSite;
	};
};