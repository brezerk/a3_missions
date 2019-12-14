/*
Spawn static objective composition
	Arguments: [spawn marker, composition name]
	Usage: [{SpawnMarker}],[{CompositionName}] call Fn_Spawn_Objective
	Return: _unitRef to spawned Objects
*/
 
//run on dedicated server only
if (isServer) then {
	params ["_spawnposition", "_composition"];
	//systemChat format ["Objective %1 spawned: %2", _composition, _spawnposition];
	_unitRef = [_composition, getmarkerpos _spawnposition, [0,0,0], 0, true] call LARs_fnc_spawnComp;
	_HVT = [_unitRef] call LARs_fnc_getCompObjects;
	{
		_type = typeName _x;
		if (_type == "GROUP") then {
			_x setBehaviour "STEALTH";
			_x setCombatMode "GREEN";
			_x setSpeedMode "LIMITED";
		};
	} forEach _HVT;
	_HVT;
};