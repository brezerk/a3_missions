/*-------
Makes targets pop up at the user's command. Targets go down after being hit,
and return back with user action. Because swivel targets have a different
script assigned to them that works differently from all other targets, 
they are handled separately in the script. If you don't plan
to use swivel targets at all, feel free to delete the corresponding part
of the code.
-------*/



CQB_Reset = {
	params ["_dist", "_center"];	
	0 = [] spawn {
		//params [["_dist",50,[1]],["_center",player,[objNull]]];					//in params
		//params ["_dist"],["_center"];					//in params
		private _dist = 30;
		private _center = getMarkerPos "mrk_t_cqb01";
		_targets = nearestObjects [_center, ["TargetBase"], _dist];	//take all nearby practice targets
		
		if (count _targets < 1) exitWith {
			diag_log "[CQB] Error: No compatible targets were found.";						//exit if no targets have been found
		};
		
		{_x animate ["Terc",0];} forEach _targets;								//get all targets to upright pos
		{
			_x addEventHandler ["HIT", {											//add EH
				(_this select 0) animate ["Terc",1];									//if hit, get to the ground
				(_this select 0) RemoveEventHandler ["HIT",0];							//remove EH
			}];
		} forEach _targets;

		_SwivelTargets = nearestObjects [_center, ["Target_Swivel_01_base_F"], _dist];		//swivel targets work differently
		if (count _SwivelTargets < 1) exitWith {
			diag_log "[CQB] Error: No swivel targets were found";						//exit if no targets have been found
		};
		{
			_x animate ["Terc",0];
			_x setVariable ["BIS_poppingEnabled", false, true];
		} forEach _SwivelTargets;	//nopop has no effect, it's poppingEnabled now
		{
			_x addEventHandler ["HitPart", {
				((_this select 0) select 0) animate ["Terc",1];
				((_this select 0) select 0) RemoveEventHandler ["HitPart",0];
			}];
		} forEach _SwivelTargets;
		diag_log "[CQB]: Ready";
	};
};

CQBP_Reset = {
	//params ["_dist", "_center"];
	0 = [] spawn {
		private _bots = ['rhs_vdv_recon_medic', 'rhs_vdv_recon_rifleman_l', 'rhs_vdv_recon_marksman_asval', 'rhs_vdv_recon_rifleman', 'rhs_vdv_recon_rifleman_akms'];
		{
			private _hpos = _x buildingPos -1;
			for "_i" from 1 to (random 2) do {
				private _pos = selectRandom _hpos;
				private _class = selectRandom _bots;
				private _grp = createGroup east;
				private _unit = _grp createUnit [_class, _pos, [], 0, "FORM"];
				_unit setBehaviour "COMBAT";
				_unit setCombatMode "RED";
				_unit setSpeaker "NoVoice";
				_unit disableConversation true;
				if (D_MOD_CBA) then {
					[_grp, _pos, 5, 1, false, false] call CBA_fnc_taskDefend;
				} else {
					[_grp, _pos] call bis_fnc_taskDefend;
				};
			};
		} forEach [a3ua_mcc_house01, a3ua_mcc_house02, a3ua_mcc_house03, a3ua_mcc_house04, a3ua_mcc_house05];
		diag_log "[CQB]: Ready";
	};
};

