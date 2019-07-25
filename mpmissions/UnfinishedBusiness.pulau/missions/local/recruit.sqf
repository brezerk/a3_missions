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

/*
Local player script
*/
if (hasInterface) then {
	Fn_Local_Attach_Recruit_Action = {
		params ['_object'];
		_object addAction 
		[
			localize "ACTION_08", 
			{
				_this call Fn_Local_Reqruit;
			},
			[],
			1.5, 
			true, 
			true, 
			"",
			"alive _target && (side _this == side _target)", // _target, _this, _originalTarget
			3
		];
	};
	
	Fn_Local_Attach_Dismiss_Action = {
		params ['_object'];
		_object addAction 
		[
			localize "ACTION_09", 
			{
				_this call Fn_Local_Dismiss;
			},
			[],
			1.5, 
			true, 
			true, 
			"",
			"alive _target && (side _this == side _target)", // _target, _this, _originalTarget
			3
		];
		_object addAction 
		[
			localize "ACTION_10", 
			{
				_this call Fn_Local_Dismiss_Group;
			},
			[],
			2, 
			true, 
			true, 
			"",
			"alive _target && (side _this == side _target)", // _target, _this, _originalTarget
			3
		];
	};
	
	Fn_Local_Reqruit = {
		params ["_target", "_caller"];
		if (!(_target getVariable ["joined", false])) then {
			switch (side _caller) do {
				case west: {
					if (_caller getVariable ["is_civilian", false]) then {
						//will join for free
						_target setVariable ["joined", true, true];
						[_target] join _caller;
						removeAllActions _target;
						[_target] call Fn_Local_Attach_Dismiss_Action;
					} else {
						//will require 5 u.o.
						private _uo = {"ACE_Banana" == _x} count (items _caller);
						if (_uo >= 5) then {
							for "_i" from 1 to 5 do {
								_caller removeItem "ACE_Banana";
							};
							_target setVariable ["joined", true, true];
							[_target] join _caller; 
							removeAllActions _target;
							[_target] call Fn_Local_Attach_Dismiss_Action;
						} else {
							systemChat format[localize "INFO_NOT_JOINED_02", name _target];
						};
					};
				};
				case east: {
					if (count (units (group _caller)) <= 3) then {
						recruted_units pushBackUnique _target;
						//will join for free
						//FIXME: not more than 3
						_target setVariable ["joined", true, true];
						[_target] join _caller;
						removeAllActions _target;
					} else {
						systemChat format[localize "INFO_NOT_JOINED_03", name _target];
					};
				};
			};
		} else {
			systemChat format[localize "INFO_JOINED_01", name _target];
		};
	};
	
	Fn_Local_Dismiss = {
		params ["_target", "_caller"];
		if ((_target getVariable ["joined", false])) then {
			_target setVariable ["joined", false, true];
			[_target] joinSilent createGroup [(side _caller), true];
			removeAllActions _target;
			[_target] call Fn_Local_Attach_Recruit_Action;
		} else {
			systemChat format[localize "INFO_NOT_JOINED_01", name _target];
		};
	};
	
	Fn_Local_Dismiss_Group = {
		params ["_target", "_caller"];
		if ((_target getVariable ["joined", false])) then {
			private _group = createGroup [(side _caller), true];
			{
				if (!(_x in playableunits) && !(_x in switchableunits)) then {
					[_x] joinSilent _group;
					_x setVariable ["joined", false, true];
					removeAllActions _target;
					[_x] call Fn_Local_Attach_Recruit_Action;
				};
			} forEach (units (group _caller));
			_group setBehaviour "SAFE";
			_group setCombatMode "YELLOW";
			[_group, getPos _caller, 100] call CBA_fnc_taskDefend;
		} else {
			systemChat format[localize "INFO_NOT_JOINED_01", name _target];
		};
	};
};
