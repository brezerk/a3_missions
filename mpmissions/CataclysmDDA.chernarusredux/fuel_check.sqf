		
params["_target"];		
		
	
	//Execute revive animation
	[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
	//Wait for revive animation to be set
	waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
	//call progress
	[
		5,
		[_target],
		{
			_this params ["_parameter"];
			_parameter params ["_target"];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
			_capacity = _target getVariable ["fuel_capacity", 0];
			if (_capacity > 0) then {
				systemChat format ["Залишки ~%1л!", _capacity];
			} else {
				systemChat "Нема більше пального!";
			};
		},
		{
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		}, "Перевіряємо"
	] call ace_common_fnc_progressBar;




		