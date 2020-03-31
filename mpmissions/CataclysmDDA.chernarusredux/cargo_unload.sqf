params["_cargo"];

if (!isNull _cargo) then {
	[
		5,
		[_cargo],
		{
			_this params ["_parameter"];
			_parameter params ["_cargo"];
			_pos = [player, 1, 4, 1, 0, 0, 0] call BIS_fnc_findSafePos;
			_vech = attachedTo _cargo;
			if (!isNull _vech) then {
				private _spots = _vech getVariable ["loaded", [0, 0, 0]];
				private _index = _spots find _cargo;
				if (_index >= 0) exitWith {
					_spots set [_index, 0];
					_vech setVariable ["loaded", _spots, true];
				};
			};
			detach _cargo;
			_cargo setPos _pos;
			_cargo enableSimulation false;
			_cargo allowDamage false;
			_cargo setVariable ["loaded", false, true];
		},
		{}, "Розвантажую"
	] call ace_common_fnc_progressBar;
};