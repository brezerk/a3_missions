/***************************************************************************************
 * Copyright (C) 2008-2020 by Oleksii S. Malakhov <brezerk@gmail.com>                  *
 *                                                                                     *
 * This program is is licensed under a                                                 *
 * Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. *
 *                                                                                     *
 * You should have received a copy of the license along with this                      *
 * work. If not, see <http://creativecommons.org/licenses/by-nc-nd/4.0/>.              *
 *                                                                                     *
 **************************************************************************************/

/*
Simulation manager
	Arguments:
		position: central position
		faction: group
		radius: simulation radius
	Usage: [_cener, _grp, 1000] call BrezBlock_fnc_manager;
	Return: nil
*/
 
private _center = _this # 0;
private _grp    = _this # 1;
private _radius = _this # 2;

diag_log "[manager] Init simulation.";

while {true} do {
	{
		_x enableSimulationGlobal false;
	} forEach (units _grp);

	waitUntil {sleep 5; (({_x distance _center < _radius} count (allPlayers - (entities "HeadlessClient_F"))) > 0)};
	
	diag_log "[manager] Players in range. Enable simulation.";
	
	{
		_x enableSimulationGlobal true;
	} forEach (units _grp);
	
	waitUntil {sleep 5; (({_x distance _center < _radius} count (allPlayers - entities "HeadlessClient_F")) isEqualTo 0)};

	diag_log "[manager] Players are not in range. Disable simulation.";

	private _alive = false;
	{
		if (!alive _x) then {
			[_x] join grpNull;
		} else {
			_alive = true;
		};
	} forEach units _grp;
	
	if (!_alive) exitWith {
		diag_log "[manager] All my units are dead. End logic.";
		true;
	};	
};

true;
