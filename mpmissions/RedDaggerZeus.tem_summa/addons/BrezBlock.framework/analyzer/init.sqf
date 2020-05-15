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
 
missionNamespace setVariable ["#EM_FMin", 65];
missionNamespace setVariable ["#EM_FMax", 343];
missionNamespace setVariable ["#EM_SMin", -60];
missionNamespace setVariable ["#EM_SMax", -10];
missionNamespace setVariable ["#EM_SelMin", 140.6];
missionNamespace setVariable ["#EM_SelMax", 165.9];

_TargetSigs = [["target_01", 91.8],["target_02", 310.85],["target_03", 120.45]];
_ScannerRange = 2000;
_DirDifrence = 0;
_TargetSigsArray = [];
while {true} do { 
	if ("hgun_esd_" in handgunWeapon player) then {
		for "_i" from 0 to (count _TargetSigs) -1 do {
			_Target = _TargetSigs select _i;
			_TargetName = _Target select 0;
			_TargetFrq = _Target select 1;
			_TargetObj = missionNamespace getVariable [_TargetName , objNull];
			_DirTgtfromTracker =  player getDir _TargetObj;
			playerFacingDir = direction  player;
			if (playerFacingDir < _DirTgtfromTracker) then {
				_DirDifrence = (_DirTgtfromTracker - playerFacingDir);
			} else {
				if (playerFacingDir > _DirTgtfromTracker) then {
					_DirDifrence = (playerFacingDir - _DirTgtfromTracker);
				} else {
					_DirDifrence = 0;
				};   
			};
			if (_DirDifrence < 0) then { _DirDifrence = _DirDifrence*(-1) };
			_Distance =  player distance _TargetObj;
			_DistanceStrength = round((100 / _ScannerRange) * (_ScannerRange-_Distance));
			_DirectionStrength = round((100 / 180) * (180-_DirDifrence));
			if (_DirectionStrength < 0) then {_DirectionStrength = _DirectionStrength*(-1) };
			_SigStrength = (100-((_DistanceStrength+_DirectionStrength)/2))*(-1);
			_TargetSigsArray append [_TargetFrq, _SigStrength];
		};
	};
	missionNamespace setVariable ["#EM_Values", _TargetSigsArray];
	_TargetSigsArray = [];
	sleep 0.5;
};
