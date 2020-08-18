 
_lnd = createVehicle ["Land_HelipadEmpty_F", [0, 0, 0], [], 0, "CAN_COLLIDE"]; 
_pos = (getPos player); 
_lnd setPosATL [_pos # 0, _pos # 1, 0]; 
 
_cargo = createVehicle ["B_supplyCrate_F", [0, 0, 0], [], 0, "CAN_COLLIDE"]; 
_cargo allowDamage false; 


_veh = createVehicle ["CUP_B_CH53E_USMC", [0, 0, 0], [], 0, "FLY"]; 
_veh enableSimulation false; 
_veh allowDamage false; 
_pos = getMarkerPos "mrk_west_supply_start"; 
_grp = createVehicleCrew (_veh); 
_veh setPosASL [_pos # 0, _pos # 1, 60]; 
_cargo setPosASL [_pos # 0, _pos # 1, 50];
_veh allowDamage true; 
_veh enableSimulation true; 
_cargo allowDamage true; 
 

_veh setSlingLoad _cargo;  

 
private _wp = _grp addWaypoint [(getPos _lnd), 0]; 
    _wp setWaypointCombatMode "YELLOW"; 
    _wp setWaypointBehaviour "SAFE"; 
    _wp setWaypointSpeed "LIMITED"; 
    _wp setWaypointCompletionRadius 20; 
    _wp setWaypointFormation "NO CHANGE"; 
    _wp setWaypointType "UNHOOK"; 
_wp = _grp addWaypoint [(getMarkerPos "mrk_west_supply_end"), 0]; 
    _wp setWaypointCombatMode "YELLOW"; 
    _wp setWaypointBehaviour "SAFE"; 
    _wp setWaypointSpeed "LIMITED"; 
    _wp setWaypointCompletionRadius 20; 
    _wp setWaypointFormation "NO CHANGE"; 
    _wp setWaypointType "MOVE"; 
