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


	private _selections = profileNamespace getVariable ["a3ua_mcc_userSettings", []];

	private _settingsDialog = createDialog "SettingsDialog";
	 
	if (!isNil "_settingsDialog") then {
		private _dialog = findDisplay 3773;
		 
		private _cbDiff = _dialog displayCtrl 2101;
		if (!isNil "_cbDiff") then {
			_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_01");
			_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_02");
			_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_03");
			if (count _selections > 0) then {
				_cbDiff lbSetCurSel (_selections # 0);
			} else {
				_cbDiff lbSetCurSel 0;
			};
		};
		
		private _cbLocation = _dialog displayCtrl 2100;
		if (!isNil "_cbLocation") then {
			{
				_cbLocation lbAdd _x;
			} forEach D_LOCATIONS;
			if (count _selections > 0) then {
				_cbLocation lbSetCurSel (_selections # 1);
			} else {
				_cbLocation lbSetCurSel 0;
			};
		};
		
		private _cbMedical01 = _dialog displayCtrl 2102;
		if (!isNil "_cbMedical01") then {
			_cbMedical01 lbAdd (localize "FROM_01_OPTION_OFF");
			_cbMedical01 lbAdd (localize "FROM_01_OPTION_ON");
			_cbMedical01 lbAdd (localize "STR_ACE_Medical_Treatment_AdvancedBandages_EnabledCanReopen");
			if (count _selections > 0) then {
				_cbMedical01 lbSetCurSel (_selections # 2);
			} else {
				_cbMedical01 lbSetCurSel 0;
			};
		};
		
		private _cbMedical02 = _dialog displayCtrl 2103;
		if (!isNil "_cbMedical02") then {
			_cbMedical02 lbAdd (localize "FROM_01_OPTION_OFF");
			_cbMedical02 lbAdd (localize "STR_ACE_Medical_Treatment_HolsterRequired_Lowered");
			_cbMedical02 lbAdd (localize "STR_ACE_Medical_Treatment_HolsterRequired_LoweredExam");
			_cbMedical02 lbAdd (localize "STR_ACE_Medical_Treatment_HolsterRequired_Holstered");
			_cbMedical02 lbAdd (localize "STR_ACE_Medical_Treatment_HolsterRequired_HolsteredExam");
			if (count _selections > 0) then {
				_cbMedical02 lbSetCurSel (_selections # 3);
			} else {
				_cbMedical02 lbSetCurSel 0;
			};
		};
		
		private _cbMedical03 = _dialog displayCtrl 2104;
		if (!isNil "_cbMedical03") then {
			_cbMedical03 lbAdd (localize "FROM_01_OPTION_OFF");
			_cbMedical03 lbAdd (localize "STR_ACE_Medical_Fractures_SplintHealsFully");
			_cbMedical03 lbAdd (localize "STR_ACE_Medical_Fractures_SplintHealsNoSprint");
			_cbMedical03 lbAdd (localize "STR_ACE_Medical_Fractures_SplintHealsNoJog");
			if (count _selections > 0) then {
				_cbMedical03 lbSetCurSel (_selections # 4);
			} else {
				_cbMedical03 lbSetCurSel 0;
			};
		};
		
		private _cbMedical04 = _dialog displayCtrl 2109;
		if (!isNil "_cbMedical04") then {
			_cbMedical04 lbAdd (localize "FROM_01_OPTION_OFF");
			_cbMedical04 lbAdd (localize "STR_ACE_Medical_Limping_LimpOnOpenWounds");
			_cbMedical04 lbAdd (localize "STR_ACE_Medical_Limping_LimpRequiresStitching");
			if (count _selections > 0) then {
				_cbMedical04 lbSetCurSel (_selections # 5);
			} else {
				_cbMedical04 lbSetCurSel 0;
			};
		};

		private _cbFractionWest = _dialog displayCtrl 2105;
		if (!isNil "_cbFractionWest") then {
			_factions = [side player] call NECK_fnc_configGetFactions;
			//if ((side player) == east) then {
			//	_factions = [side player] call NECK_fnc_configGetFactions;
			//} else {
			//	_factions = [west] call NECK_fnc_configGetFactions;
			//	_factions append ([independent] call NECK_fnc_configGetFactions);
			//};
			_cacheFactions = [];
			{
				private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
				_cbFractionWest lbAdd (_name);
				_cacheFactions pushBackUnique _x;
			} forEach (_factions);
			
			if (count _selections > 0) then {
				_cbFractionWest lbSetCurSel (_selections # 6);
			} else {
				_cbFractionWest lbSetCurSel 14;
			};
			uiNamespace setVariable ["settingsDialog_cacheFaction", _cacheFactions];
		};
	};
