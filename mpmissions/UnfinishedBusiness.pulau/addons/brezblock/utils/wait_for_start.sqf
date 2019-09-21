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

if (!isNil "_missionLogo") then {

	playMusic (selectRandom ["AmbientTrack01b_F_EXP", "AmbientTrack02b_F_EXP", "AmbientTrack02c_F_EXP", "AmbientTrack02d_F_EXP"]);

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
		_cam camCommitPrepared 20;
		
		cutText ["S", "BLACK IN"];
		//
		{
			sleep 1;
			if (_forEachIndex in [0, 4, 8]) then {
				cutText [localize "INFO_WAIT_01", "PLAIN DOWN", 2];
			};
			if (mission_requested) then { breakTo "main"; };
		} forEach [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
		cutText ["S", "BLACK OUT"];
		//
	};

	[0, "BLACK", 2] call BIS_fnc_fadeEffect;

	closeDialog 1;
	
	_cam cameraEffect ["terminate","back"];
	camUseNVG false;
	camDestroy _cam;
	["Default"] call BIS_fnc_setPPeffectTemplate;
	[1, "BLACK", 5, 1] call BIS_fnc_fadeEffect;
	cutText [localize "INFO_WAIT_02", "PLAIN DOWN", 2];
	
	playMusic "";
};

