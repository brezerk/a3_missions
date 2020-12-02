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

D_LOCATION = "Main";

D_ROLE = "I_G_Survivor_F";

private _cbStart = lbCurSel 2102;
private _cbDiff = lbCurSel 2101;

private _cbFractionWest = lbCurSel 2105;
D_FACTION = D_SIDE_FACTIONS # _cbFractionWest;
private _cbFractionClass = lbCurSel 2106;
private _factionClases = [D_FACTION, "soldier"] call Fn_Config_GetFactionVehicles;
D_ROLE = _factionClases # _cbFractionClass;

private _cbMedical01 = lbCurSel 2102;
private _cbMedical02 = lbCurSel 2103;
private _cbMedical03 = lbCurSel 2104;
private _cbMedical04 = lbCurSel 2109;

ace_medical_treatment_advancedBandages = _cbMedical01;
ace_medical_treatment_holsterRequired = _cbMedical02;
ace_medical_fractures = _cbMedical03;
ace_medical_limping = _cbMedical04;

switch (_cbDiff) do {
	case 0: {
		ace_medical_playerDamageThreshold = 3;
		ace_advanced_fatigue_loadFactor = 0.5;
		ace_advanced_fatigue_performanceFactor = 2;
		ace_advanced_fatigue_recoveryFactor = 2;
		ace_advanced_fatigue_swayFactor = 0.5;
		ace_advanced_fatigue_terrainGradientFactor = 0.5;
	};
	case 1: {
		ace_medical_playerDamageThreshold = 1;
		ace_advanced_fatigue_loadFactor = 1;
		ace_advanced_fatigue_performanceFactor = 1.5;
		ace_advanced_fatigue_recoveryFactor = 1.5;
		ace_advanced_fatigue_swayFactor = 1;
		ace_advanced_fatigue_terrainGradientFactor = 1;
	};
	case 3: {
		ace_medical_playerDamageThreshold = 1;
		ace_advanced_fatigue_loadFactor = 1;
		ace_advanced_fatigue_performanceFactor = 1.5;
		ace_advanced_fatigue_recoveryFactor = 1.5;
		ace_advanced_fatigue_swayFactor = 1;
		ace_advanced_fatigue_terrainGradientFactor = 1;
	};
};

mission_generated = true;

closeDialog 1;

//Fix MCC artillery calculator issue
call Fn_Local_Respawn;

/* 
if (!mission_requested) then { 

	private _cbFractionCiv = lbCurSel 2108;
	private _cbFractionIndep = lbCurSel 2107;
	private _cbFractionEast = lbCurSel 2106;
	private _cbFractionWest = lbCurSel 2105;
	private _cbNavToolsCompass = lbCurSel 2104;
	private _cbNavToolsMap = lbCurSel 2103;
	private _cbStart = lbCurSel 2102;
	private _cbDiff = lbCurSel 2101;
	private _cbLocation = lbCurSel 2100;
	private _cbPrisoner = lbCurSel 2109;

	private _D_LOCATION = nil;

	switch (_cbLocation) do {
		case 0: {
			_D_LOCATION = selectRandom D_LOCATIONS;
		};
		case 1: {
			_D_LOCATION = D_LOCATIONS select 0;
		};
		case 2: {
			_D_LOCATION = D_LOCATIONS select 1;
		};
	};

	PUB_fnc_missionPlanned = [_cbDiff, _D_LOCATION, _cbStart, _cbNavToolsMap, _cbNavToolsCompass, _cbFractionWest, _cbFractionEast, _cbFractionIndep, _cbFractionCiv, _cbPrisoner];
	publicVariableServer "PUB_fnc_missionPlanned";
	
	closeDialog 1;
};
*/
