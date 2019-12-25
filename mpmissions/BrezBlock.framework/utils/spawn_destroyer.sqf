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
 
 params['_marker'];
 
 private _ret=[];
 
 private _obj_destroyer = createVehicle ["Land_Destroyer_01_base_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
[_obj_destroyer] call bis_fnc_Destroyer01Init;

_obj_destroyer setPosASL (getMarkerPos _marker);
_obj_destroyer setDir (markerDir _marker);

[_obj_destroyer] call bis_fnc_Destroyer01PosUpdate;
	
_ret pushBackUnique _obj_destroyer;

// Add boat rack0	
private _obj = createVehicle ["Land_Destroyer_01_Boat_Rack_01_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_obj enableSimulation false;
_obj allowDamage false;
_obj setDir (getDir _obj_destroyer + 180);
_obj setPosASL (_obj_destroyer modelToWorldWorld [-11.5,14.43,7.5]);
_obj enableSimulation true;
_obj allowDamage true;

_ret pushBackUnique _obj;

// Add boat rack1
_obj = createVehicle ["Land_Destroyer_01_Boat_Rack_01_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_obj enableSimulation false;
_obj allowDamage false;
_obj setDir (getDir _obj_destroyer + 180);
_obj setPosASL (_obj_destroyer modelToWorldWorld [11.5,14.43,7.5]);
_obj enableSimulation true;
_obj allowDamage true;

_ret pushBackUnique _obj;

// Mk45 Hammer
_obj = createVehicle ["B_Ship_Gun_01_F", [0,0,0], [], 0, "NONE"];
_obj allowDamage false;
_obj setDir (getDir _obj_destroyer + 180);
_obj setPosASL (_obj_destroyer modelToWorldWorld [0,-79.08,12.1]);
//_obj enableSimulation true;
//_obj allowDamage true;

// MRLS
_obj = createVehicle ["B_Ship_MRLS_01_F", [0,0,0], [], 0, "NONE"];
_obj allowDamage false;
_obj setDir (getDir _obj_destroyer + 180);
_obj setPosASL (_obj_destroyer modelToWorldWorld [0,-62.4229,10.7]);
//_obj enableSimulation true;
//_obj allowDamage true;

// Praetorian-1C
_obj = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"];
_obj allowDamage false;
_obj setDir (getDir _obj_destroyer + 180);
_obj setPosASL (_obj_destroyer modelToWorldWorld [0,-48.106,15.1]);
//_obj enableSimulation true;
//_obj allowDamage true;

// Praetorian-1C
_obj = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"];
_obj allowDamage false;
_obj setDir (getDir _obj_destroyer);
_obj setPosASL (_obj_destroyer modelToWorldWorld [0,36.3765,19.7]);
//_obj enableSimulation true;
//_obj allowDamage true;

// Mk49 Spartan
_obj = createVehicle ["B_SAM_System_01_F", [0,0,0], [], 0, "NONE"];
_obj allowDamage false;
_obj setDir (getDir _obj_destroyer);
_obj setPosASL (_obj_destroyer modelToWorldWorld [0,50.6011,15.8]);
//_obj enableSimulation true;
//_obj allowDamage true;

_ret;
