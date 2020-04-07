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
bb_srv_temp_body  = 36.6; // 0 - 32 -- cold; 32 - 35 -- chilly; 36 comfort; 
bb_srv_temp_body_feaver  = 0; // > 4.4 letal; 
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
		playSound "bb_head_03";
		sleep 3;
		addCamShake [(random 5), 4, ((random 35) + 5)];
		_effect ppEffectAdjust[0, 0, true];
		_effect ppEffectCommit 3;
		playSound "bb_head_03";
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
		playSound "bb_head_03";
		sleep 5;
		addCamShake [(random 5), 4, ((random 35) + 5)];
		_effect ppEffectAdjust[0, 0, 0];
		_effect ppEffectCommit 5;
		playSound "bb_head_03";
		sleep 5;
	//};
	_effect ppEffectEnable false;
	ppEffectDestroy _effect;
	enableCamShake false;
};

private _shiver = {
	enableCamShake true;
	addCamShake [5,1,7];
	private _sound = selectRandom [
		"A3\Sounds_f\characters\human-sfx\P01\drowning_01.wss",
		"A3\Sounds_f\characters\human-sfx\P01\Drowning_1.wss",
		"A3\Sounds_f\characters\human-sfx\P01\drowning_02.wss",
		"A3\Sounds_f\characters\human-sfx\P01\Drowning_2.wss"
	];
	playsound3d [_sound, player];	
	sleep 5;
	enableCamShake false;
};

Fn_Update_Temperature = {
	_rain = rain;
	_t_diff_base = -0.009 * (2.5 * _rain);
	_t_local = 16;
	if ((vehicle player) != player) then {
		_t_diff_base = 0.005;
		_t_local = 18;
	} else {
		lineIntersectsSurfaces [
			getPosWorld player, 
			getPosWorld player vectorAdd [0, 0, 50], 
			player, objNull, true, 1, "GEOM", "NONE"
		] select 0 params ["","","","_house"];
		if (!isNil "_house") then {
			if (_house isKindOf "House") then { _t_diff_base = 0.002; _t_local = 17; };
		};
	};
	if (count (nearestObjects [player, ["Land_Campfire_burning"], 5]) > 0) then {
		_t_diff_base = _t_diff_base + 0.015;
		_t_local = 24;
	};
	_img = "addons\BrezBlock.framework\data\survival\weather-cold.paa";
	_color = [];
	if (_t_local > 16) then {
		_img = "addons\BrezBlock.framework\data\survival\weather-hot.paa";
		_color = [0.949, 0.949, 0.949 - (_t_diff_base * 25), 0.8];
	} else {
		_color = [0.8 - (0.35 * _rain), 0.9 - (0.35 * _rain), 1, 0.8];
	};
	bb_srv_temp_body = bb_srv_temp_body + _t_diff_base;
	
	private _ctrl = uiNamespace getVariable "bb_survival_hud" displayCtrl 2993;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText _img; _ctrl ctrlSetTextColor _color; };
	
	_t_diff_base = bb_srv_temp_body + bb_srv_temp_body_feaver;
	
	if (_t_diff_base > 36.9) then {
		_color = [0.949, 0.949 - ((_t_diff_base - 36.9) * 0.25), 0.949 - ((_t_diff_base - 36.8) * 0.25), 0.9];
	} else {
		if (_t_diff_base <= 36.2) then {
			_color = [0.949 - ((36.3 - _t_diff_base) * 0.5), 0.949 - ((36.2 - _t_diff_base) * 0.5), 0.949, 0.9];
		} else {
			_color = [0.949, 0.949, 0.949, 0.8];
		};
	};
	
	_ctrl = uiNamespace getVariable "bb_survival_hud" displayCtrl 2994;
	if (!isNil "_ctrl") then { _ctrl ctrlSetTextColor _color; };
};

//sleep 4;
//call _hallucinations_01;

while {(!isNull player)} do  {
	private _threat = 0;
	waitUntil {alive player};
	systemChat format ["Chemical: %1 Radiation: %2 Temp: %3", bb_srv_dmg_chem, bb_srv_dmg_rad, bb_srv_temp_body];
	if (bb_srv_dmg_chem > 0) then {
		_chance = 0;
		_symptmos = [_cough];
		if (bb_srv_dmg_chem < 10) then {
			_chance = 20;
		} else {
			if (bb_srv_dmg_chem < 20) then {
				_chance = 40;
				_symptmos pushBack _hallucinations_01;
				_symptmos pushBack _hallucinations_02;
			} else {
				_symptmos pushBack _puke;
				_chance = 60;
			};
		};
		if ((random 100) <= _chance) then {
			call selectRandom _symptmos;
		};
	};
	call Fn_Update_Temperature;
	sleep 1;
};