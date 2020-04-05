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


bb_srv_dmg_chem   = 0; // 0 - 20 light damage; 30 - 100 heavy damage; 100 + letal damage
bb_srv_dmg_rad    = 0; // 0 - 20 light damage; 300 - 1000 heavy damage; 1000 + letal damage
bb_srv_dmg_bac    = 0; // 0 - 300 light damage; 300 - 1000 heavy damage; 1000 + letal damage
bb_srv_temp_body  = 0; // 0 - 32 -- cold; 32 - 35 -- chilly; 36 comfort; 
bb_srv_temp_local = 0; // 0 - 32 -- cold; 32 - 35 -- chilly; 36 comfort; 

player setVariable['bb_srv_dmg_chem', bb_srv_dmg_chem,   true];
player setVariable['bb_srv_dmg_rad',  bb_srv_dmg_rad,    true];
player setVariable['bb_srv_dmg_bac',  bb_srv_dmg_bac,    true];
player setVariable['bb_srv_temp_body', bb_srv_temp_body, true];

// symptoms

private _cough = {
	private _sound = selectRandom [
		"A3\Sounds_f\characters\human-sfx\Person0\P0_choke_02.wss",
		"A3\Sounds_f\characters\human-sfx\Person0\P0_choke_03.wss",
		"A3\Sounds_f\characters\human-sfx\Person0\P0_choke_04.wss",
		"A3\Sounds_f\characters\human-sfx\Person1\P1_choke_04.wss",
		"A3\Sounds_f\characters\human-sfx\Person2\P2_choke_04.wss",
		"A3\Sounds_f\characters\human-sfx\Person2\P2_choke_05.wss",
		"A3\Sounds_f\characters\human-sfx\Person3\P3_choke_02.wss",
		"A3\Sounds_f\characters\human-sfx\P06\Soundbreathinjured_Max_2.wss",
		"A3\Sounds_f\characters\human-sfx\P05\Soundbreathinjured_Max_5.wss"
	];
	playsound3d [_sound, player];	
	sleep 2;
};

private _puke = {
	[player, "AinvPknlMstpSlayWrflDnon_healed2"] remoteExec ["playMoveNow", 0, false];
	//Wait for revive animation to be set
	waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSlayWrflDnon_healed2")};
	private _sound = selectRandom [
		"A3\Sounds_f\characters\human-sfx\P01\drowning_01.wss",
		"A3\Sounds_f\characters\human-sfx\P01\Drowning_1.wss",
		"A3\Sounds_f\characters\human-sfx\P01\drowning_02.wss",
		"A3\Sounds_f\characters\human-sfx\P01\Drowning_2.wss"
	];
	playsound3d [_sound, player];	
	sleep 5;
	[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
	[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
};

private _hallucinations_01 = {
	private _effect = ppEffectCreate ["ChromAberration", 250];
	_effect ppEffectEnable true;
	//for "_i" from 1 to ((random 1) + 1) do {
		enableCamShake true;
		addCamShake [(random 5), 4, ((random 35) + 5)];
		_effect ppEffectAdjust[1, (((random 8) + 1) * 0.1) , true];
		_effect ppEffectCommit 3;
		sleep 3;
		addCamShake [(random 5), 4, ((random 35) + 5)];
		_effect ppEffectAdjust[0, 0, true];
		_effect ppEffectCommit 3;
		sleep 3;
	//};
	_effect ppEffectEnable false;
	ppEffectDestroy _effect;
	enableCamShake false;
};

private _hallucinations_02 = {
	private _effect = ppEffectCreate ["ColorInversion", 300];
	_effect ppEffectEnable true;
	//for "_i" from 1 to ((random 1) + 1) do {
		enableCamShake true;
		addCamShake [(random 5), 4, ((random 35) + 5)];
		_effect ppEffectAdjust[(((random 8) + 1) * 0.1), (((random 8) + 1) * 0.1), (((random 8) + 1) * 0.1)];
		_effect ppEffectCommit 5;
		sleep 5;
		addCamShake [(random 5), 4, ((random 35) + 5)];
		_effect ppEffectAdjust[0, 0, 0];
		_effect ppEffectCommit 5;
		sleep 5;
	//};
	_effect ppEffectEnable false;
	ppEffectDestroy _effect;
	enableCamShake false;
};

while {(!isNull player)} do  {
	private _threat = 0;
	waitUntil {alive player};
	systemChat format ["Chemical: %1 Radiation: %2", bb_srv_dmg_chem, bb_srv_dmg_rad];
	if (bb_srv_dmg_chem > 0) then {
		_chance = 0;
		_symptmos = [_cough];
		if (bb_srv_dmg_chem < 10) then {
			_chance = 20;
		} else {
			if (bb_srv_dmg_chem < 20) then {
				_chance = 40;
				_symptmos pushBack _hallucinations_01;
			} else {
				_symptmos pushBack _puke;
				_symptmos pushBack _hallucinations_02;
				_chance = 60;
			};
		};
		if ((random 100) <= _chance) then {
			call selectRandom _symptmos;
		};
	};
	sleep 1;
};