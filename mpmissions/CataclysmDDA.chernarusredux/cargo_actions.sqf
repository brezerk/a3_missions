params["_cargo"];

//CUP_C_V3S_Open_TKC

private _vechs = nearestObjects [player, ["CUP_C_V3S_Open_TKC"], 50];
private _loaded = false;
if ((count _vechs) > 0) then {
	{
		private _spots = _x getVariable ["loaded", [0, 0, 0]];
		private _index = _spots find 0;
		if (_index >= 0) exitWith {
			[
				5,
				[_cargo, _x],
				{
					_this params ["_parameter"];
					_parameter params ["_object", "_veh"];
					_spots = _veh getVariable ["loaded", [0, 0, 0]];
					_index = _spots find 0;
					if (_index >= 0) then {
						if (isNull attachedTo _object) then {
							_spots set [_index, _object];
							_veh setVariable ["loaded", _spots, true];
							_object enableSimulation false;
							_object allowDamage false;
							_object attachTo [_veh, [0, 0.3 - (_index * 1.45), 0.2]];
							_object setVariable ["loaded", true, true];
						};
					} else {
						systemChat "Ці вантажівкі зайняти. Знайдіть вільну вантажівку з відкритим верхом!";
					};
				},
				{
				}, "Завантажую"
			] call ace_common_fnc_progressBar;
			_loaded = true;
		};
		/*
		if (!(_x getVariable ["loaded", false])) exitWith {
			_x setVariable ["loaded", true, true];
			_object enableSimulation false;
			_object allowDamage false;
			_object attachTo [_x, [0, -1, 0]]; 
			_loaded = true;
		} */
	} forEach (_vechs); 
	if (!_loaded) then {
		systemChat "Ці вантажівкі зайняти. Знайдіть вільну вантажівку з відкритим верхом!";
	};
} else {
	systemChat "Ці вантажівкі не підходять. Знайдіть вантажівку з відкритим верхом!";
};