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
 
missionNamespace setVariable ["#EM_FMin", 140];
missionNamespace setVariable ["#EM_FMax", 143];
missionNamespace setVariable ["#EM_SMin", -60];
missionNamespace setVariable ["#EM_SMax", -10];
missionNamespace setVariable ["#EM_SelMin", 141.6];
missionNamespace setVariable ["#EM_SelMax", 141.9];

_TargetSigs = [["Target1", 141.8],["Target2", 140.85]];
_ScannerRange = 300;
_DirDifrence = 0;
_TargetSigsArray = [];
_Tracker = objNull;
while {true} do { 
	{
		if ("hgun_esd_" in handgunWeapon _x) then {
			_Tracker = _x;
		};
	} forEach allPlayers;
	if (isNull _Tracker) then {
		hint "doesn't exist";
	} else {
		for "_i" from 0 to (count _TargetSigs) -1 do {
			_Target = _TargetSigs select _i;
			_TargetName = _Target select 0;
			_TargetFrq = _Target select 1;
			_TargetObj = missionNamespace getVariable [_TargetName , objNull];
			_DirTgtfromTracker =  _Tracker getDir _TargetObj;
			_TrackerFacingDir = direction  _Tracker;
			if (_TrackerFacingDir < _DirTgtfromTracker) then {
				_DirDifrence = (_DirTgtfromTracker - _TrackerFacingDir);
			} else {
				if (_TrackerFacingDir > _DirTgtfromTracker) then {
					_DirDifrence = (_TrackerFacingDir - _DirTgtfromTracker);
				} else {
					_DirDifrence = 0;
				};   
			};
			if (_DirDifrence < 0) then { _DirDifrence = _DirDifrence*(-1) };
			_Distance =  _Tracker distance _TargetObj;
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
