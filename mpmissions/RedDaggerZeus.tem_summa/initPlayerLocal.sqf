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

waitUntil { !isNull player }; // Wait for player to initialize

execVM "briefing.sqf";

// hide markers
{
	if (_x find "wp_" >= 0) then {_x setMarkerAlphaLocal 0} else {
		if (_x find "mrk_mines_" >= 0) then {_x setMarkerTextLocal (localize "STR_Minefileds")} else {
			if (_x find "mrk_rampat_" >= 0) then {_x setMarkerTextLocal (localize "STR_Rampat")} else {
				if (_x find "mrk_reinf_" >= 0) then {_x setMarkerTextLocal (localize "STR_Reinf")} else {
					if (_x find "mrk_strike_" >= 0) then {_x setMarkerTextLocal (localize "STR_Strike")} else {
						if (_x find "mrk_mortars_" >= 0) then {_x setMarkerTextLocal (localize "STR_Mortars")};
					};
				};
			};
		};
	};
} forEach allMapMarkers;

"respawn_guerrila" setMarkerTextLocal (localize "STR_Logistic");
"respawn_east" setMarkerTextLocal (localize "STR_Logistic");
"marker_oles" setMarkerTextLocal (localize "STR_Rampat_Oles");
"mrk_drg_01" setMarkerTextLocal (localize "STR_DRG_1");
"mrk_drg_02" setMarkerTextLocal (localize "STR_DRG_2");
"mrk_mech_01" setMarkerTextLocal (localize "STR_Mech_01");
"mrk_mech_02" setMarkerTextLocal (localize "STR_Mech_02");


sleep 1;

supply_box_01 addAction ["Стрілок (Rifleman)", {player call compile preprocessFileLineNumbers "gear\player\rifelman_light.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Стрілець-санітар (Combat medic)", {player call compile preprocessFileLineNumbers "gear\player\medic.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Інженер (Engineer)", {player call compile preprocessFileLineNumbers "gear\player\engineer.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Кулеметник (Machine Gunner)", {player call compile preprocessFileLineNumbers "gear\player\mg.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Помічник Кулеметника (Machine Gunner Assistant)", {player call compile preprocessFileLineNumbers "gear\player\mg_assist.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Гранатометник (Grenadier RPG-7)", {player call compile preprocessFileLineNumbers "gear\player\pt.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Помічник Гранатометника (Grenadier Assistant)", {player call compile preprocessFileLineNumbers "gear\player\pt_assist.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Влучний стрілець (Marksman)", {player call compile preprocessFileLineNumbers "gear\player\marksman.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Заступник командира (Dep. Squad leader)", {player call compile preprocessFileLineNumbers "gear\player\rifelman_light.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Командир (Group leader)", {player call compile preprocessFileLineNumbers "gear\player\commander.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];
supply_box_01 addAction ["Оператор-розвідник (DLC Contact)", {player call compile preprocessFileLineNumbers "gear\player\operator.sqf"; [player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;}];


//[] execVM "addons\BrezBlock.framework\ambient.sqf";

[] execVM "addons\BrezBlock.framework\analyzer\init.sqf";

['Україна. Зона ООС.', 'Позиції логістичної бази', format ['1 вересня 2015 %s', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;