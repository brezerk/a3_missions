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
 
private _cbVehicle = lbCurSel 2202;
if (_cbVehicle >= 0) then {
	private _vehicle = D_FACTION_CACHE # _cbVehicle;
	ctrlSetText [2210, (getText (configfile >> "CfgVehicles" >> _vehicle >> "editorPreview"))];
	ctrlSetText [1202, format[
		localize "STR_FROM_02_INFO_03",
		(getText (configFile >> "CfgVehicles" >> _vehicle >> "textSingular")),
		(getNumber (configFile >> "CfgVehicles" >> _vehicle >> "enginePower")),
		(getNumber (configFile >> "CfgVehicles" >> _vehicle >> "maxSpeed")),
		(getNumber (configFile >> "CfgVehicles" >> _vehicle >> "ace_refuel_fuelCapacity")),
		(getNumber (configFile >> "CfgVehicles" >> _vehicle >> "transportSoldier")),
		localize (["STR_FROM_INFO_NO", "STR_FROM_INFO_YES"] # (getNumber (configFile >> "CfgVehicles" >> _vehicle >> "tf_hasLRradio"))),  //Boold
		localize (["STR_FROM_INFO_NO", "STR_FROM_INFO_YES"] # (getNumber (configFile >> "CfgVehicles" >> _vehicle >> "enableGPS")))  //Boold
	]];
} else {
	ctrlSetText [2210, ""];
	ctrlSetText [1202, ""];
};
 