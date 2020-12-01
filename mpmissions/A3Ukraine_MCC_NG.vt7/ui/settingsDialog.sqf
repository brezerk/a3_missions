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

params ["_exitCode"];

if (_exitCode in [0, 2]) then { 

sleep 5;

private _settingsDialog = createDialog "SettingsDialog";
 
if (!isNil "_settingsDialog") then {
	private _dialog = findDisplay 3773;
	 
	private _cbDiff = _dialog displayCtrl 2101;
	if (!isNil "_cbDiff") then {
		_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_01");
		_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_02");
		_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_03");
		_cbDiff lbSetCurSel 0;
	};
	
	private _cbLocation = _dialog displayCtrl 2100;
	if (!isNil "_cbLocation") then {
		{
			_cbLocation lbAdd _x;
		} forEach D_LOCATIONS;
		_cbLocation lbSetCurSel 0;
	};
	
	private _cbMedical01 = _dialog displayCtrl 2102;
	if (!isNil "_cbMedical01") then {
		_cbMedical01 lbAdd (localize "FROM_01_OPTION_OFF");
		_cbMedical01 lbAdd (localize "FROM_01_OPTION_ON");
		_cbMedical01 lbAdd (localize "STR_ACE_Medical_Treatment_AdvancedBandages_EnabledCanReopen");
		_cbMedical01 lbSetCurSel 0;
	};
	
	private _cbMedical02 = _dialog displayCtrl 2103;
	if (!isNil "_cbMedical02") then {
		_cbMedical02 lbAdd (localize "FROM_01_OPTION_OFF");
		_cbMedical02 lbAdd (localize "STR_ACE_Medical_Treatment_HolsterRequired_Lowered");
		_cbMedical02 lbAdd (localize "STR_ACE_Medical_Treatment_HolsterRequired_LoweredExam");
		_cbMedical02 lbAdd (localize "STR_ACE_Medical_Treatment_HolsterRequired_Holstered");
		_cbMedical02 lbAdd (localize "STR_ACE_Medical_Treatment_HolsterRequired_HolsteredExam");
		_cbMedical02 lbSetCurSel 0;
	};
	
	private _cbMedical03 = _dialog displayCtrl 2104;
	if (!isNil "_cbMedical03") then {
		_cbMedical03 lbAdd (localize "FROM_01_OPTION_OFF");
		_cbMedical03 lbAdd (localize "STR_ACE_Medical_Fractures_SplintHealsFully");
		_cbMedical03 lbAdd (localize "STR_ACE_Medical_Fractures_SplintHealsNoSprint");
		_cbMedical03 lbAdd (localize "STR_ACE_Medical_Fractures_SplintHealsNoJog");
		_cbMedical03 lbSetCurSel 0;
	};
	
	private _cbMedical04 = _dialog displayCtrl 2109;
	if (!isNil "_cbMedical04") then {
		_cbMedical04 lbAdd (localize "FROM_01_OPTION_OFF");
		_cbMedical04 lbAdd (localize "STR_ACE_Medical_Limping_LimpOnOpenWounds");
		_cbMedical04 lbAdd (localize "STR_ACE_Medical_Limping_LimpRequiresStitching");
		_cbMedical04 lbSetCurSel 0;
	};

	Fn_Config_GetFactions = {
		params ["_side"];
		private _factions = [];
		{ _factions pushBackUnique (configName _x) } forEach ( (format ["(getNumber ( _x >> ""side"") == %1)", _side]) configClasses (configfile >> "CfgFactionClasses"));
		_factions
	};
	
	Fn_Config_GetFactionClasses = {
		//params ["_side"];
		params ["_faction"];
		private _classes = [];
		{ _classes pushBackUnique (configName _x) } forEach ( (format ["(getText ( _x >> ""faction"") == ""%1"") && (getText ( _x >> ""category"") == ""Men"")", _faction]) configClasses (configfile >> "CfgVehicles"));
		_classes
	};

	private _cbFractionWest = _dialog displayCtrl 2105;
	if (!isNil "_cbFractionWest") then {
		{
			private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
			_cbFractionWest lbAdd (_name);
		} forEach ([2] call Fn_Config_GetFactions);
		_cbFractionWest lbSetCurSel 22;
	};
	
	private _cbFractionEast = _dialog displayCtrl 2106;
	if (!isNil "_cbFractionEast") then {
		{
			private _name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			_cbFractionEast lbAdd (_name);
		} forEach (["LOP_UKR"] call Fn_Config_GetFactionClasses);
		_cbFractionEast lbSetCurSel 0;
	};

	/*
	private _cbFractionIndep = _dialog displayCtrl 2107;
	if (!isNil "_cbFractionIndep") then {
		{
			private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
			_cbFractionIndep lbAdd (_name);
		} forEach ([independent] call Fn_Config_GetFractions);
		_cbFractionIndep lbSetCurSel 0;
	};
	
	private _cbFractionCiv = _dialog displayCtrl 2108;
	if (!isNil "_cbFractionCiv") then {
		{
			private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
			_cbFractionCiv lbAdd (_name);
		} forEach ([civilian] call Fn_Config_GetFractions);
		_cbFractionCiv lbSetCurSel 0;
	};
	*/
};

};
