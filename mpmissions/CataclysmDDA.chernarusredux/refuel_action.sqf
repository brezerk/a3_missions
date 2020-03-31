		
params["_src", "_dst"];		
		
if ((_src getVariable ["fuel_capacity", 0]) > 0) then {
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
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
			_capacity = (_src getVariable ["fuel_capacity", 0]);
			if (_capacity >= 0) then {
				if (_capacity >= 10) then {
					_src setVariable ["fuel_capacity", (_capacity - 10), true];
					_dst setFuel ((fuel _dst) + 0.1);
					systemChat "Залито 10л!";
				} else {
					systemChat format ["Залито залишки ~%1л!", _capacity];
					_src setVariable ["fuel_capacity", 0, true];
					_dst setFuel ((fuel _dst) + parseNumber ((_capacity / 1000) toFixed 1));
				};
			} else {
				systemChat "Нема більше пального!";
			};
		},
		{
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		}, "Заправляємо"
	] call ace_common_fnc_progressBar;
} else {
	systemChat "Нема більше пального!";
};
