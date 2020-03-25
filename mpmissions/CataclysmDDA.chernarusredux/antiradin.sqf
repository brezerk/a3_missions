		//Execute revive animation
		[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
		//Wait for revive animation to be set
		waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
		//call progress
		player removeItem "ACE_plasmaIV";
		[
			5,
			[],
			{
				[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
				[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
				player setDamage 0;
			},
			{
				[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
				[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
			}, "Використовую Антірадін"
		] call ace_common_fnc_progressBar;