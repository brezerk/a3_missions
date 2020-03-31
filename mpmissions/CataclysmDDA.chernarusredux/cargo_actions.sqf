params["_cargo", "_dst"];	

private _loaded = false;

private _spots = _dst getVariable ["loaded", [0, 0, 0]];
private _index = _spots find 0;
if (_index >= 0) then {
	[
		5,
		[_cargo, _dst],
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
} else {
	systemChat "Ці вантажівку зайнято. Знайдіть вільну вантажівку з відкритим верхом!";
};
	