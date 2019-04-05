/*
Spawn OPFOR composition and order them to guard wp
	Arguments: [spawn marker, composition name, designation marker]
	Usage: [{SpawnMarker}],[{CompositionName},{DesignationMarker}] call Fn_Spawn_OPFOR_Forces
	Return: _unitRef to spawned Objects
*/

//run on dedicated server only
if (isServer) then {	
	params ["_spawnposition", "_composition"];
	//[format ["Enemy forces %1 inbound: %2", _composition, _spawnposition]] remoteExec ["systemChat"];
	_unitRef = [_composition, getMarkerPos _spawnposition, [0,0,0], 0, true] call LARs_fnc_spawnComp;
	_HVT = [_unitRef] call LARs_fnc_getCompObjects;
	{
		_type = typeName _x;
		if (_type == "GROUP") then {
			[_x, getMarkerPos _spawnposition, 25, 3, 0, 100] call CBA_fnc_taskDefend;
			_x setBehaviour "STEALTH";
			_x setCombatMode "WHITE";
		};
	} forEach _HVT;
	_HVT;
};
