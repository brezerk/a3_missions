		
params["_dst", "_src"];		
		
if ((fuel _src) > 0) then {
	//systemChat format ["refuel: %1 to %2", _src, _dst];		
	//Execute revive animation
	[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
	//Wait for revive animation to be set
	waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
	//call progress
	[
		5,
		[_src, _dst],
		{
			_this params ["_parameter"];
			_parameter params ["_src", "_dst"];
			//systemChat format ["refuel DONE: %1 to %2", _src, _dst];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
			_capacity = (fuel _src);
			_cur_fuel = _dst getVariable ["fuel_capacity", 0];
			if (_capacity >= 0) then {
				if (_capacity >= 0.1) then {
					_dst setVariable ["fuel_capacity", (_cur_fuel + 10), true];
					_src setFuel ((fuel _src) - 0.1);
					systemChat "Злито 10л!";
				} else {
					_capacity = floor(_capacity * 1000);
					_dst setVariable ["fuel_capacity", (_cur_fuel + _capacity), true];
					_src setFuel 0;
					systemChat format ["Злито залишки ~%1л!", _capacity];
				};
			} else {
				systemChat "Нема більше пального!";
			};
		},
		{
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		}, "Зливаємо пальне"
	] call ace_common_fnc_progressBar;
} else {
	systemChat "Нема більше пального!";
};
