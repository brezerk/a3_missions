/***************************************************************************
 *   Copyright (C) 2008-2019 by Oleksii S. Malakhov <brezerk@gmail.com>    *
 *                                                                         *
 *   This program is free software: you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation, either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 ***************************************************************************/

/*
End game trigger
	Usage: execVM ["addons/brezblock/triggers/end_game.sqf"];
	Return: true
*/

if (isServer) then {
	private ["_all_dead"];
	_all_dead = false;
	while {!_all_dead} do {
	  sleep 5;
	  if (count (allPlayers - (entities "HeadlessClient_F")) > 0) then {
		  _all_dead = true;
		  {
			if ((alive _x) || (([_x,nil,true] call BIS_fnc_respawnTickets) > 0)) then {
				_all_dead = false;
			}
		  } forEach (allPlayers - (entities "HeadlessClient_F"));
		  if (_all_dead) then {
			call Fn_Endgame_Loss;
		  };
	  };
	};
};
