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

private ["_group"];
//Remove unit if it was in the assault group
call Fn_Local_FailTasks;

PUB_fnc_kickFromAssaultGroup = [player, _this select 0];
publicVariableServer "PUB_fnc_kickFromAssaultGroup";

/*
switch (playerSide) do
{
	case west:
	{
		systemChat "switched";
		_group = createGroup east;
		[player] joinSilent _group;
	};
};*/
