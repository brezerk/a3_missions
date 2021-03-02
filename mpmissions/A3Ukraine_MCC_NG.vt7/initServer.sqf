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

#include "addons\CQB_script\reset.sqf";

missionNamespace setVariable ["bg_spectator_enabled", false];
private _anim = selectRandom ['STAND_U1', 'STAND_U2', 'STAND_U3', 'GUARD', 'LISTEN_BRIEFING'];
{
	[_x, _anim, "NONE"] call BIS_fnc_ambientAnim;
	_x allowDamage false;
	_x setVariable ["lambs_danger_disableAI", true];
	_x setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_x setVariable ['neck_noSurrender', true];
	_x setSpeaker "NoVoice";
	_x disableConversation true;
	_x setBehaviour "CARELESS";
	_x enableFatigue false;
	_x setSkill ["courage", 1];
	_x setUnitPos "UP";
	_x setMass 7000;
	_x disableAI "ALL"; 
} forEach [a3ua_mcc_medic01, a3ua_mcc_medic02];

