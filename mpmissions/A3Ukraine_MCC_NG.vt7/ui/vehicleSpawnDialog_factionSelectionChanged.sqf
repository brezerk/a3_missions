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
 
private _cbFraction = lbCurSel 2201;
private _faction = D_SIDE_FACTIONS # _cbFraction;

private _cbClass = "soldier";

switch (lbCurSel 2200) do {
	case 0: { _cbClass = "carx"};
	case 1: { _cbClass = "tankX"};
	case 2: { _cbClass = "helicopterrtd"};
	case 3: { _cbClass = "airplanex"};
	case 4: { _cbClass = "shipx"};
};

private _dialog = findDisplay 3873;
private _cbVehicles = _dialog displayCtrl 2202;

if (!isNil "_cbVehicles") then {
	D_FACTION_CACHE = [_faction, _cbClass] call Fn_Config_GetFactionVehicles;
	lbClear _cbVehicles;
	{
		private _name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
		_cbVehicles lbAdd (_name);
	} forEach (D_FACTION_CACHE);
	_cbVehicles lbSetCurSel 0;
};



//configfile >> "CfgVehicles" >> "RHS_BM21_VDV_01" >> "unitInfoType"   unitInfoType = "RscUnitInfoArtillery"; unitInfoType = "RscUnitInfoSoldier";
//configfile >> "CfgVehicles" >> "RHS_BM21_VDV_01" >> "type"           0

//configfile >> "CfgVehicles" >> "rhs_pchela1t_vvs" >> "armor"
//configfile >> "CfgVehicles" >> "rhs_pchela1t_vvs" >> "maxSpeed"
//configfile >> "CfgVehicles" >> "rhs_pchela1t_vvs" >> "transportSoldier"
//configfile >> "CfgVehicles" >> "rhs_pchela1t_vvs" >> "textSingular"
//configfile >> "CfgVehicles" >> "rhs_pchela1t_vvs" >> "picture"
 