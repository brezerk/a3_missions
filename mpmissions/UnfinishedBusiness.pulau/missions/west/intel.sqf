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
		if ((random 100) >= 60) then {
			switch (random 4) do {
				1: { call Fn_Create_Mission_DestroyAmmo; };
				2: { call Fn_Create_Mission_DestroyFuel; };
				3: { call Fn_Create_Mission_DestroyWindMill; };
				4: { call Fn_Create_Mission_KillDoctor; };
			};
		};
		//task_complete_intormator = true;
	};
};
