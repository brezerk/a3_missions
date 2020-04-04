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

while {true} do {
	if (!isNull player) then {
		waitUntil {"ChemicalDetector_01_watch_F" in assignedItems player};
		if (bb_player_threat_rad > 0) then {
			playsound selectRandom["geiger_01", "geiger_02", "geiger_03"];
			sleep (bb_player_threat_rad);
			//Chemical Detector Display
			if (bb_player_threat_rad >= bb_player_threat_chem) then {
				"ThreatDisplay" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];  
				private _ui = uiNamespace getVariable "RscWeaponChemicalDetector"; 
				if (!isNull _ui) then {
					private _obj = _ui displayCtrl 101; 
					if (!isNull _obj) then {
						_obj ctrlAnimateModel ["Threat_Level_Source", (1.4 - bb_player_threat_rad), true];
					};
				};
			};
		} else {
			//Chemical Detector Display
			if (bb_player_threat_chem == 0) then {
				"ThreatDisplay" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];  
				private _ui = uiNamespace getVariable "RscWeaponChemicalDetector"; 
				if (!isNull _ui) then {
					private _obj = _ui displayCtrl 101; 
					if (!isNull _obj) then {
						_obj ctrlAnimateModel ["Threat_Level_Source", 0.0, true];
					};
				};
			};
			waitUntil {bb_player_threat_rad > 0};
		};
	};
};