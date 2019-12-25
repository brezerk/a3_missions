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
Spawn start objectives, triggers for informator contact
*/

//Player side triggers
// Client side code
if (hasInterface) then {
	
};

if (isServer) then {
	"PUB_fnc_intelFound" addPublicVariableEventHandler {(_this select 1) call EventHander_IntelFound};
	/*
	Event Handler for loaded or unloaded box
	*/
	EventHander_IntelFound = {
		params['_caller', '_target', '_side'];
		if (D_DEBUG) then {
			systemChat format ["W: %1", _side];
		};
		if ((random 100) >= 60) then {
			private _type = 0; //round(random 1);
			if (_side == "GUER") then {
				switch (_type) do {
					case 0: {
						private _missions = [];
						if ((!task_complete_ammo) && (!isNull indep_ammo_01)) then {
							_missions pushBack Fn_Create_Mission_DestroyAmmo;
						};
						if ((!task_complete_fuel) && (!isNull indep_fuel_01)) then {
							_missions pushBack Fn_Create_Mission_DestroyFuel;
						};
						if ((!task_complete_wind) && (!isNull indep_wind_01)) then {
							_missions pushBack Fn_Create_Mission_DestroyWindMill;
						};
						if ((!task_complete_lab) && (!isNull indep_lab_01)) then {
							_missions pushBack Fn_Create_Mission_KillDoctor;
						};
						[_caller] call (selectRandom _missions); 
					};
					case 1: { systemChat "miss!"; };
					default { systemChat "woot?"; };
				};
			};
		};
	};
};
