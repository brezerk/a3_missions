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
	sleep 0.3;
	playsound3d [_sound, player];
	sleep 2;
};

private _puke = {
	if (player getVariable ['ACEX_field_rations_thirst', 0] < 75) then {
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
		player setVariable ['ACEX_field_rations_thirst', player getVariable ['ACEX_field_rations_thirst', 0] + 25];
		sleep 5;
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	} else {
		call _cough;
	};
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
	_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
	enableCamShake true;
	addCamShake [5,1,7];
	private _sound = selectRandom [
		"addons\BrezBlock.framework\sounds\survival\shiver_01.ogg",
		"addons\BrezBlock.framework\sounds\survival\shiver_02.ogg",
		"addons\BrezBlock.framework\sounds\survival\shiver_03.ogg",
		"addons\BrezBlock.framework\sounds\survival\shiver_04.ogg",
		"addons\BrezBlock.framework\sounds\survival\shiver_05.ogg",
		"addons\BrezBlock.framework\sounds\survival\shiver_06.ogg",
		"addons\BrezBlock.framework\sounds\survival\shiver_07.ogg"
	];
	sleep 0.3;
	playsound3d [format ["%1%2", _soundPath, _sound], player];	
	sleep 3;
	enableCamShake false;
};

private _sneeze = {
	_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
	enableCamShake true;
	private _sound = selectRandom [
		"addons\BrezBlock.framework\sounds\survival\sneeze_01.ogg",
		"addons\BrezBlock.framework\sounds\survival\sneeze_02.ogg"
	];
	sleep 0.3;
	playsound3d [format ["%1%2", _soundPath, _sound], player];
	addCamShake [15,1,3];
	sleep 3;
	enableCamShake false;
};

private _sniffle = {
	_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
	private _sound = selectRandom [
		"addons\BrezBlock.framework\sounds\survival\sniffle_01.ogg",
		"addons\BrezBlock.framework\sounds\survival\sniffle_02.ogg",
		"addons\BrezBlock.framework\sounds\survival\sniffle_03.ogg"
	];
	sleep 0.3;
	playsound3d [format ["%1%2", _soundPath, _sound], player];
	sleep 2;
};

Fn_Update_Temperature = {
	_rain = rain;
	_t_diff_base = -0.005 * (2.5 * _rain);
	_t_local = 16;
	_img = "";
	_color = [0.949, 0.949, 0.949, 1];
	_veh = vehicle player;
	if ((_veh) != player) then {
		if (isEngineOn _veh) then {
			_t_diff_base = 0.010;
			_t_local = 20;
		} else {
			_t_diff_base = 0.005;
			_t_local = 18;
		};
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
	{
		if (inflamed _x) exitWith {
			_t_diff_base = _t_diff_base + 0.025;
			_t_local = 24;
		};
	} forEach (nearestObjects [player, ["Land_Campfire_burning", "Land_Campfire"], 5]);
	_t_diff_base = _t_diff_base + linearConversion [0, 20, speed player, 0, 0.015, true];
	if (_t_diff_base > 0) then {
		if (_t_diff_base >= 0.005) then {
			_img = "addons\BrezBlock.framework\data\survival\temp_warm.paa";
		} else {
			_img = "addons\BrezBlock.framework\data\survival\temp_gradus.paa";
		};
	} else {
		_img = "addons\BrezBlock.framework\data\survival\temp_cold.paa";
		//_color = [linearConversion [0, 1, (_t_local - _t_diff_base), 0.949, 0.322, true], linearConversion [0, 1, (_t_local - _t_diff_base), 0.949, 0.322, true], 0.949, 0.8];
	};
	private _ctrl = uiNamespace getVariable "bb_survival_hud" displayCtrl 2981;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText _img; };
	bb_srv_temp_body = bb_srv_temp_body + _t_diff_base;
	if (bb_srv_temp_body >= 37.0) then {
		bb_srv_temp_body = 37.0;
	} else {
		if (bb_srv_temp_body <= 34.9) then {
			bb_srv_dmg_bac = bb_srv_dmg_bac + (34.9 - bb_srv_temp_body);
		};
	};
	if (_t_diff_base >= 0) then {
		if (_t_diff_base >= 0.002) then {
			if (_t_diff_base >= 0.010) then {
				_img = "addons\BrezBlock.framework\data\survival\temp_up2.paa";
			} else {
				_img = "addons\BrezBlock.framework\data\survival\temp_up1.paa";
			};
		} else {
			_img = "addons\BrezBlock.framework\data\survival\empty.paa";
		};
	} else {
		if (_t_diff_base < -0.010) then {
			systemChat format ["diff: %1", _t_diff_base];
			_img = "addons\BrezBlock.framework\data\survival\temp_down1.paa";
		} else {
			_img = "addons\BrezBlock.framework\data\survival\temp_down2.paa";
		};
	};
	private _ctrl = uiNamespace getVariable "bb_survival_hud" displayCtrl 2983;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText _img; };
	
	_t_diff_base = bb_srv_temp_body + bb_srv_temp_body_feaver;
	
	if (_t_diff_base > 36.9) then {
		_color = [0.949, linearConversion [36.6, 38.0, _t_diff_base, 0.949, 0.322, true], linearConversion [36.6, 38.0, _t_diff_base, 0.949, 0.322, true], 0.9];
	} else {
		if (_t_diff_base <= 36.2) then {
			_color = [linearConversion [36.6, 34.9, _t_diff_base, 0.949, 0.322, true], linearConversion [36.6, 34.9, _t_diff_base, 0.949, 0.322, true], 0.949, 0.9];
		} else {
			_color = [0.949, 0.949, 0.949, 0.8];
		};
	};
	
	_img = format ["addons\BrezBlock.framework\data\survival\temp_t0%1.paa", round linearConversion [34.9, 38.0, _t_diff_base, 1, 5, true]];
	
	private _ctrl = uiNamespace getVariable "bb_survival_hud" displayCtrl 2982;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText _img; _ctrl ctrlSetTextColor _color; };
};

Fn_Update_ACEX_Rations = {
	//player setVariable ['ACEX_field_rations_thirst', _status + 1];
	_t_diff = linearConversion [0, 20, speed player, 0, 0.015, true];
	player setVariable ['ACEX_field_rations_thirst', ((player getVariable ['ACEX_field_rations_thirst', 0]) + _t_diff)];
	
	private _status = player getVariable ['ACEX_field_rations_thirst', 0];
	private _img = format ["addons\BrezBlock.framework\data\survival\food%1.paa", round linearConversion [0, 80, _status, 4, 0, true]];
	
	private _ctrl = uiNamespace getVariable "bb_survival_hud" displayCtrl 2991;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText _img; };
	
	_status = player getVariable ['ACEX_field_rations_hunger', 0];
	_img = format ["addons\BrezBlock.framework\data\survival\water%1.paa", round linearConversion [0, 80, _status, 4, 0, true]];
	
	//player setVariable ['ACEX_field_rations_hunger', _status + 1];
	
	_ctrl = uiNamespace getVariable "bb_survival_hud" displayCtrl 2992;
	//if (!isNil "_ctrl") then { _ctrl ctrlSetTextColor _color; };
	if (!isNil "_ctrl") then { _ctrl ctrlSetText _img; };
};

Fn_ProgressIllness = {
	if (bb_srv_dmg_bac > 10) then {
		bb_srv_dmg_bac = bb_srv_dmg_bac + 0.03;
		bb_srv_temp_body_feaver = linearConversion [0, 100, bb_srv_dmg_bac, 0.01, 5.4, true];
	};
};

//sleep 4;
//call _hallucinations_01;

_count = 0;

while {(!isNull player)} do  {
	private _threat = 0;
	_count = _count + 1;
	waitUntil {alive player};
	/*
	if (!isNil "ACEX_field_rations_hud") then {
		ACEX_field_rations_hud cutText ["", "PLAIN"];
	};*/
	call Fn_Update_Temperature;
	call Fn_Update_ACEX_Rations;
	call Fn_ProgressIllness;
	
	systemChat format ["Chem: %1 Rad: %2 Temp: %3 F: %4 Body Result: %5 Bac: %6 T %7 H %8", bb_srv_dmg_chem, bb_srv_dmg_rad, bb_srv_temp_body, bb_srv_temp_body_feaver, (bb_srv_temp_body + bb_srv_temp_body_feaver), bb_srv_dmg_bac, player getVariable ['ACEX_field_rations_thirst', 'nan'], player getVariable ['ACEX_field_rations_hunger', 'nan']];
	
	if (_count >= 15) then {
		_symptmos = [];
		if (bb_srv_dmg_chem > 0) then {
			_symptmos pushBack _cough;
			if (bb_srv_dmg_chem < 10) then {
			} else {
				if (bb_srv_dmg_chem < 20) then {
					_chance = 40;
					_symptmos pushBack _hallucinations_01;
					_symptmos pushBack _hallucinations_02;
				} else {
					_symptmos pushBack _puke;
				};
			};
		};
		if (bb_srv_temp_body <= 36.2) then {
			_symptmos pushBack _shiver;
		};
		if (bb_srv_dmg_bac >= 10) then {
			_symptmos pushBack _sneeze;
			if (bb_srv_dmg_bac >= 20) then {
				_symptmos pushBack _sniffle;
				if (bb_srv_dmg_bac >= 30) then {
					_symptmos pushBack _cough;
				};
			};
		};
		if (count _symptmos > 0) then {
			[] spawn selectRandom _symptmos;
		};
		_count = 0;
	};
	sleep 1;
};