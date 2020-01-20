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

private _fraction = "";
private _logo = "";
private _group = "";
private _header = "";
private _signature = "";
private _text = "";
private _now = date;

private _role = (roleDescription player);

switch (playerSide) do {
	case east: {
		_logo = "UnfinishedBusiness.core\data\images\orders\AOC\faction.paa";
		_group = "UnfinishedBusiness.core\data\images\orders\faction_empty.paa";
		_header = localize "AOC_ORDER_HEADER_01";
		_signature = format["BX.HO 1254\nB4: 5190 10\n%1 %2 %3", (_now select 2), (_now select 1), (_now select 0)];
		_text = format["%1\n\n%2: %3\n\n%4: %5\n\n%6: %7", localize "AOC_BRIEFING_HEADER_01", localize "MISSION", localize "EAST_BRIEFING_01", localize "OBJ_PRI", localize "EAST_BRIEFING_02", localize "OBJ_SEC", localize "EAST_BRIEFING_03"];
	};
	case civilian: {
		_logo = "UnfinishedBusiness.core\data\images\orders\faction_empty.paa";
		_group = "UnfinishedBusiness.core\data\images\orders\faction_empty.paa";
		_header = localize "CIV_ORDER_HEADER_01";
		_signature = format["REVO\n%1 %2 %3", (_now select 2), (_now select 1), (_now select 0)];
		_text = format["%1\n\n%2: %3\n\n%4: %5\n\n%6: %7", format [localize "CIV_BRIEFING_HEADER_01", name player], localize "MISSION", localize "CIV_BRIEFING_01", localize "OBJ_PRI", localize "CIV_BRIEFING_02", localize "OBJ_SEC", localize "CIV_BRIEFING_03"];
	};
	case west: {
		_fraction = D_FRACTION_WEST;
		_logo = format["UnfinishedBusiness.core\data\images\fractions\%1\faction.paa", _fraction];
		//if ((_role find "SpecOps_") >= 0) then {
		//	_group = format["UnfinishedBusiness.core\data\images\fractions\%1\group_spec_logo.paa", _fraction];
		//} else {
			if (mission_plane_send) then {
				
				_group = format["UnfinishedBusiness.core\data\images\fractions\%1\group_rescue_logo.paa", _fraction];
				_header = localize format["%1_ORDER_HEADER_01", _fraction];
				_signature = format["SCO 1169.SE\nMMEA-3\n%1 %2 %3", (_now select 2), (_now select 1), (_now select 0)];
				_text = format["%1\n\n%2: %3\n\n%4: %5\n\n%6: %7", localize format["%1_BRIEFING_HEADER_02", _fraction], localize "MISSION", format [localize "WEST_BRIEFING_11", mission_plane_pass_count, D_LOCATION, mission_plane_send_time, mission_plane_down_time, mission_plane_pass_count], localize "OBJ_PRI",  localize "WEST_BRIEFING_12", localize "OBJ_SEC", localize "WEST_BRIEFING_13"];
			} else {
				_group = format["UnfinishedBusiness.core\data\images\fractions\%1\group_logo.paa", _fraction];
				_header = localize format["%1_ORDER_HEADER_01", _fraction];
				_signature = format["SCO 1715.SE\nMMEA-5\n%1 %2 %3", (_now select 2), (_now select 1), (_now select 0)];
				_text = format["%1\n\n%2: %3\n\n%4: %5\n\n%6: %7", localize format["%1_BRIEFING_HEADER_01", _fraction], localize "MISSION", localize "WEST_BRIEFING_01", localize "OBJ_PRI", format [localize "WEST_BRIEFING_02", D_LOCATION], localize "OBJ_SEC", localize "WEST_BRIEFING_03"];
			};
		//};
	};
	case resistance: {
		_fraction = D_FRACTION_INDEP;
	};
};

private _orderDialog = createDialog "OrderDialog";
 
if (!isNil "_orderDialog") then {
	private _dialog = findDisplay 3800;
	private _ctrl = _dialog displayCtrl 3810;
	if (!isNil "_ctrl") then {
		_ctrl ctrlSetText (_logo);
	};
	
	private _ctrl = _dialog displayCtrl 3811;
	if (!isNil "_ctrl") then {
		_ctrl ctrlSetText _group;
	};
	
	private _ctrl = _dialog displayCtrl 3815;
	if (!isNil "_ctrl") then {
		_ctrl ctrlSetText _header;
	};
	
	private _ctrl = _dialog displayCtrl 3819;
	if (!isNil "_ctrl") then {
		
		_ctrl ctrlSetText _signature;
	};
	
	private _ctrl = _dialog displayCtrl 3820;
	if (!isNil "_ctrl") then {
		_ctrl ctrlSetText _text;
	};	
};
