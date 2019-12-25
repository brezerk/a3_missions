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


if (isServer) then { 

	Fn_Task_Create_Checkpoint_Trigger = {
		{
			private _pos = getPos _x;
			private _trg = createTrigger ["EmptyDetector", getPos ua_gate01];
			_trg setTriggerArea [15, 15, 0, false];
			_trg setTriggerActivation ["ANY", "PRESENT", true];
			_trg setTriggerStatements [
				"",
				format ["(checkpoint_gate_group select %1) animate ['Door_1_rot', 1];", _forEachIndex];
				format ["(checkpoint_gate_group select %1) animate ['Door_1_rot', 0];", _forEachIndex];
			];
		} forEach checkpoint_gate_group;
	};

};
