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

params ["_var"];

private _center = [(worldSize/2), (worldSize/2), 0];
private _cam = "camera" camCreate _center;
cameraEffectEnableHUD false;
showCinemaBorder false;
["Mediterranean"] call BIS_fnc_setPPeffectTemplate;

//enable NVG if needed
if (sunOrMoon < 1) then {camUseNVG true} else {camUseNVG false};

private _missionLogo = createDialog "MissionLogo";
private _intoFrame = 0;

if (D_DEBUG) then {
	_intoFrame = 4;
	[0] execVM "ui\SettingsDialog.sqf";
};

//text = "data\images\logo.paa";

if (!isNil "_missionLogo") then {

	private _dialog = findDisplay 2772;
	
	private _lblText = _dialog displayCtrl 2700;
	private _imgLogo = _dialog displayCtrl 2710;
	


	[
		["AmbientTrack01b_F_EXP",
		 "AmbientTrack02b_F_EXP",
		 //"AmbientTrack02c_F_EXP",
		 "AmbientTrack02d_F_EXP",
		 "LeadTrack01_F_Tacops",
		 "LeadTrack02_F_Tacops",
		 "LeadTrack03_F_Tacops"],
	0] call BIS_fnc_music;

	//playMusic (selectRandom []);

	scopeName "main";
	while {true} do {
		private _pos = [] call BIS_fnc_randomPos;
		_pos set [2, (random [2, 5, 20])];
		private _dir = [_pos, _center] call BIS_fnc_dirTo;
		private _target = [_pos, 600, _dir] call BIS_fnc_relPos;

		_cam cameraEffect ["internal", "BACK"];
		_cam camSetPos _pos;
		_cam camSetTarget _target;
		_cam camCommit 0;

		_preparePos = _pos getPos [15, 90];
		_preparePos set [2, (_pos select 2)];

		_cam camPreparePos _preparePos;
		_cam camCommitPrepared 25;
		
		cutText ["", "BLACK IN"];

		//
		{
			sleep 1;
			if (_forEachIndex in [0, 4, 8]) then {
				if (_intoFrame > 2) then {
					cutText [localize "INFO_WAIT_01", "PLAIN DOWN", 2, true, true];
				};
				switch (_intoFrame) do {
					case 0: {
					
						_lblText ctrlSetFade 1;
						_lblText ctrlCommit 0;
						_imgLogo ctrlSetFade 1;
						_imgLogo ctrlCommit 0;
						
						sleep 2;
						
						ctrlSetText [2700, localize "INFO_DEV_01"];
						ctrlSetText [2710, "data\images\logo_bb.paa"];
						
						_lblText ctrlSetFade 0;
						_lblText ctrlCommit 2;
						_imgLogo ctrlSetFade 0;
						_imgLogo ctrlCommit 2;

						sleep 3;
						
						_lblText ctrlSetFade 1;
						_lblText ctrlCommit 2;
						_imgLogo ctrlSetFade 1;
						_imgLogo ctrlCommit 2;
						
						_intoFrame = _intoFrame + 1;
					};
					case 1: {
						_lblText ctrlSetFade 1;
						_lblText ctrlCommit 0;
						_imgLogo ctrlSetFade 1;
						_imgLogo ctrlCommit 0;
						
						ctrlSetText [2700, localize "INFO_DEV_02"];
						ctrlSetText [2710, "data\images\logo_a3_ua.paa"];
						
						_lblText ctrlSetFade 0;
						_lblText ctrlCommit 2;
						_imgLogo ctrlSetFade 0;
						_imgLogo ctrlCommit 2;

						sleep 3;
						
						_lblText ctrlSetFade 1;
						_lblText ctrlCommit 2;
						_imgLogo ctrlSetFade 1;
						_imgLogo ctrlCommit 2;
						
						_intoFrame = _intoFrame + 1;
					};
					case 2: {
						_lblText ctrlSetFade 1;
						_lblText ctrlCommit 0;
						_imgLogo ctrlSetFade 1;
						_imgLogo ctrlCommit 0;
						
						ctrlSetText [2700, localize "INFO_DEV_03"];
						ctrlSetText [2710, "data\images\logo.paa"];
						
						_lblText ctrlSetFade 0;
						_lblText ctrlCommit 2;
						_imgLogo ctrlSetFade 0;
						_imgLogo ctrlCommit 2;

						sleep 3;
						
						_lblText ctrlSetFade 1;
						_lblText ctrlCommit 2;
						
						_intoFrame = _intoFrame + 1;
					};
					case 3: {
						if (((roleDescription player) == "Squad Leader") || (D_DEBUG)) then {
							[0] execVM "ui\SettingsDialog.sqf";
						};
						_intoFrame = _intoFrame + 1;
						if (!D_MOD_ACE) then { systemChat localize "INFO_MOD_NF_ACE"; };
						if (!D_MOD_ACE_MEDICAL) then { systemChat localize "INFO_MOD_NF_ACE_MEDICAL"; };
						if (!D_MOD_ACEX) then { systemChat localize "INFO_MOD_NF_ACEX"; };
						if (!D_MOD_CUP_VEHICLES) then { systemChat localize "INFO_MOD_NF_FACTIONS"; };
					};
				};
			};
			if (mission_requested) then { breakTo "main"; };
		} forEach [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
		cutText ["", "BLACK OUT"];
		//
	};

	[0, "BLACK", 2] call BIS_fnc_fadeEffect;

	closeDialog 1;
	
	_cam cameraEffect ["terminate","back"];
	camUseNVG false;
	camDestroy _cam;
	["Default"] call BIS_fnc_setPPeffectTemplate;
	[1, "BLACK", 1, 1] call BIS_fnc_fadeEffect;
	cutText [localize "INFO_WAIT_02", "PLAIN DOWN", 2, true, true];
	
	[[""]] call BIS_fnc_music;
};

