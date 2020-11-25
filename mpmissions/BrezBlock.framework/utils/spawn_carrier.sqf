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

_marker = "test_01";

carrier_01 = createVehicle ["Land_Carrier_01_base_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
carrier_01 setPosWorld (getMarkerPos _marker);
carrier_01 setDir (markerDir _marker);
[carrier_01] call BIS_fnc_Carrier01PosUpdate;
[carrier_01] call BIS_fnc_Carrier01Init;

//deck level == 23.6  B_AAA_System_01_F

test = createVehicle ["B_SAM_System_02_F", [0,0,0], [], 0, "NONE"];
test allowDamage false;
test setDir (getDir carrier_01 + 180);
test setPosASL (carrier_01 modelToWorldWorld [30.4,174.8,19.6]);

test = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"]; 
test allowDamage false; 
test setDir (getDir carrier_01); 
test setPosASL (carrier_01 modelToWorldWorld [-16.8,188.9,11.3]);

test = createVehicle ["B_SAM_System_01_F", [0,0,0], [], 0, "NONE"]; 
test allowDamage false; 
test setDir (getDir carrier_01 + 180); 
test setPosASL (carrier_01 modelToWorldWorld [-39.5,178.4,19.8]);

test = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 90);  
test setPosASL (carrier_01 modelToWorldWorld [47.5,0,18.1]); 

test = createVehicle ["B_SAM_System_02_F", [0,0,0], [], 0, "NONE"];
test allowDamage false;
test setDir (getDir carrier_01 + 180);
test setPosASL (carrier_01 modelToWorldWorld [24.8,-115,16.8]); 

test = createVehicle ["B_SAM_System_02_F", [0,0,0], [], 0, "NONE"];
test allowDamage false;
test setDir (getDir carrier_01 + 180);
test setPosASL (carrier_01 modelToWorldWorld [-29.3,-100.8,19.4]); 

test = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"];
test allowDamage false;
test setDir (getDir carrier_01 - 90);
test setPosASL (carrier_01 modelToWorldWorld [-30,-105.4,17.6]); 



// HUMVEE

test = createVehicle ["CUP_B_HMMWV_M1114_USMC", [0,0,0], [], 0, "NONE"]; 
test allowDamage false; 
test setDir (getDir carrier_01 + 174); 
test setPosASL (carrier_01 modelToWorldWorld [-40,64,23.6]); 

test = createVehicle ["CUP_B_HMMWV_M1114_USMC", [0,0,0], [], 0, "NONE"]; 
test allowDamage false; 
test setDir (getDir carrier_01 + 174);  
test setPosASL (carrier_01 modelToWorldWorld [-26,66,23.6]); 

// HUMVEE 2

test = createVehicle ["CUP_B_HMMWV_M1114_USMC", [0,0,0], [], 0, "NONE"]; 
test allowDamage false; 
test setDir (getDir carrier_01 - 90);        
test setPosASL (carrier_01 modelToWorldWorld [41,92,23.6]); 

test = createVehicle ["CUP_B_HMMWV_M1114_USMC", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 - 90);         
test setPosASL (carrier_01 modelToWorldWorld [41,82,23.6]); 

test = createVehicle ["CUP_B_HMMWV_M1114_USMC", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 - 90);         
test setPosASL (carrier_01 modelToWorldWorld [41,72,23.6]); 


// CRATE

test = createVehicle ["B_supplyCrate_F", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 174);  
test setPosASL (carrier_01 modelToWorldWorld [-31,66,23.6]); 

test = createVehicle ["B_supplyCrate_F", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 174);   
test setPosASL (carrier_01 modelToWorldWorld [-35,65.5,23.6]); 

//  Medbay

test = createVehicle ["Land_MedicalTent_01_MTP_closed_F", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 176);    
test setPosASL (carrier_01 modelToWorldWorld [-34,78.5,23.6]); 

// Little bird

test = createVehicle ["CUP_B_MH6J_USA", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 90);   
test setPosASL (carrier_01 modelToWorldWorld [-29,50,23.6]); 

test = createVehicle ["CUP_B_MH6J_USA", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 90);    
test setPosASL (carrier_01 modelToWorldWorld [-29,35,23.6]); 

test = createVehicle ["CUP_B_MH6J_USA", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 90);     
test setPosASL (carrier_01 modelToWorldWorld [-29,18,23.6]); 

//hawk

test = createVehicle ["CUP_B_MH60S_USMC", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 90);       
test setPosASL (carrier_01 modelToWorldWorld [-31,-10,23.6]); 

//transport

test = createVehicle ["CUP_B_CH53E_USMC", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 180);       
test setPosASL (carrier_01 modelToWorldWorld [35,124,23.6]); 

// attack

test = createVehicle ["CUP_B_AH1Z_Dynamic_USMC", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 90);        
test setPosASL (carrier_01 modelToWorldWorld [-31,-35,23.6]); 

test = createVehicle ["CUP_B_AH1Z_Dynamic_USMC", [0,0,0], [], 0, "NONE"];  
test allowDamage false;  
test setDir (getDir carrier_01 + 90);        
test setPosASL (carrier_01 modelToWorldWorld [-31,-60,23.6]); 

/*
[215bacbeb00# 392500: carrier_01_hull_01_f.p3d,"pos_hull_1"],
[215bacbe080# 392501: carrier_01_hull_02_f.p3d,"pos_hull_2"],
[215bacbd600# 392502: carrier_01_hull_03_1_f.p3d,"pos_hull_3_1"],
[215bacbcb80# 392503: carrier_01_hull_03_2_f.p3d,"pos_hull_3_2"],
[215bacbc100# 392504: carrier_01_hull_04_1_f.p3d,"pos_hull_4_1"],
[215d1a3a080# 392505: carrier_01_hull_04_2_f.p3d,"pos_hull_4_2"],
[215d1a3ab00# 392506: carrier_01_hull_05_1_f.p3d,"pos_hull_5_1"],
[215bacb7580# 392507: carrier_01_hull_05_2_f.p3d,"pos_hull_5_2"],
[215bacb6b00# 392508: carrier_01_hull_06_1_f.p3d,"pos_hull_6_1"],
[215bacb6080# 392509: carrier_01_hull_06_2_f.p3d,"pos_hull_6_2"],
[215bacb5600# 392510: carrier_01_hull_07_1_f.p3d,"pos_hull_7_1"],
[215bacb4b80# 392511: carrier_01_hull_07_2_f.p3d,"pos_hull_7_2"],
[215bacb4100# 392512: carrier_01_hull_08_1_f.p3d,"pos_hull_8_1"],
[215ad443580# 392513: carrier_01_hull_08_2_f.p3d,"pos_hull_8_2"],
[215ad442b00# 392514: carrier_01_hull_09_1_f.p3d,"pos_hull_9_1"],
[215ad442080# 392515: carrier_01_hull_09_2_f.p3d,"pos_hull_9_2"],
[215ad441600# 392516: carrier_01_island_01_f.p3d,"pos_island_1"],
[215ad440b80# 392517: carrier_01_island_02_f.p3d,"pos_island_2"],
[215ad440100# 392518: carrier_01_island_03_f.p3d,"pos_island_3"],
[215cf5ef580# 392519: empty.p3d,"pos_Airport"]]

//USS_FREEDOM_CARRIER setVariable ["bis_carrierParts",_nearbyCarrierParts];
//["Carrier %1 was empty. Now contains %2.",str "bis_carrierParts",USS_FREEDOM_CARRIER getVariable ["bis_carrierParts", []]] call BIS_fnc_logFormatServer;

_obj;

/*

[_obj_destroyer] call bis_fnc_Destroyer01Init;

_obj_destroyer setPosASL ();
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
_obj setPosASL (_obj_destroyer modelToWorldWorld [0,-62.4229,10.8]);
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
//_obj allowDamage true;*/

_ret;
