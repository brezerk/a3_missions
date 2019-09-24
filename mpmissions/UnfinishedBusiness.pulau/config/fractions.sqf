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
 
  Fn_Config_GetFractions = {
	params ['_side'];
	private _fractions = [];
	private _cfg = [];
	switch (_side) do {
		case independent: { _cfg = D_FRACTION_INDEP_CFG };
		case west: { _cfg = D_FRACTION_WEST_CFG };
		case east: { _cfg = D_FRACTION_EAST_CFG };
		case civilian: { _cfg = D_FRACTION_CIV_CFG };
	};
	{
		private _fraction = _x select 0;
		if (isClass(configFile >> "CfgFactionClasses" >> _fraction)) then {
			_fractions pushBackUnique _fraction;
		};
	} forEach _cfg;
	_fractions;
 };
 
 Fn_Config_GetFraction_Units = {
	params ['_side', '_fraction', '_type'];
	private _cfg = [];
	switch (_side) do {
		case independent: { _cfg = D_FRACTION_INDEP_CFG };
		case west: { _cfg = D_FRACTION_WEST_CFG };
		case east: { _cfg = D_FRACTION_EAST_CFG };
		case civilian: { _cfg = D_FRACTION_CIV_CFG };
	};
	{
		private _cfg_fraction = _x select 0;

		if (_cfg_fraction == _fraction) exitWith {
			{	
				private _cfg_type = _x select 0;
				if (_cfg_type == _type) exitWith {
					_x select 1;
				};
			} forEach (_x select 2);
		};
	} forEach _cfg;
 };
 
 D_FRACTION_WEST_CFG = [
	[
		'CUP_B_USMC', 'CUP Civilian', []   //Wreck Land_UWreck_MV22_F
	],
	[
		'BLU_F', 'NATO', [
			[
			'transport', ['B_Heli_Transport_01_F']
			],
			[
			'heli', ['B_Heli_Light_01_F']
			],
			[
			'boats', ['B_Boat_Armed_01_minigun_F']
			],
			['transport_wreck', 'Land_Wreck_Heli_02_Wreck_01_F'],
			['Team Leader', 'B_Soldier_TL_F'],
			['Corpsman', 	'B_medic_F'],
			['Grenadier', 	'B_Soldier_GL_F'],
			['Rifleman', 	'B_Soldier_F'],
			['Squad Leader','B_Soldier_SL_F'],
			['Autorifleman','B_Soldier_AR_F'],
			['Sniper', 		'B_sniper_F'],
			['Spotter', 	'B_spotter_F'],
			['stash_base_items', 	[
					["arifle_MX_F",				  2 ],
					["arifle_MX_SW_F",			  2 ],
					["Laserdesignator",			  1 ],
					["30Rnd_65x39_caseless_mag",  24],
					["16Rnd_9x21_Mag",			  16],
					["30Rnd_45ACP_Mag_SMG_01",	  16],
					["20Rnd_762x51_Mag",		  16],
					["7Rnd_408_Mag",			  10],
					["100Rnd_65x39_caseless_mag", 16],
					["1Rnd_HE_Grenade_shell",	  20],
					["3Rnd_HE_Grenade_shell",	  10],
					["Chemlight_green",			  20],
					["Laserbatteries",			  3 ],
					["HandGrenade",				  20],
					["SmokeShell",				  10],
					["SmokeShellGreen",			  10],
					["acc_flashlight",			  2 ],
					["bipod_01_F_blk",			  1 ]
				]
			],
			['stash_safe_items', 	[
					["launch_NLAW_F",			  2 ],
					["arifle_MX_F",				  3 ],
					["arifle_MX_SW_F",			  3 ],
					["30Rnd_65x39_caseless_mag",  12],
					["16Rnd_9x21_Mag",			  4 ],
					["30Rnd_45ACP_Mag_SMG_01",	  8 ],
					["20Rnd_762x51_Mag",		  6 ],
					["100Rnd_65x39_caseless_mag", 4 ],
					["NLAW_F",					  4 ],
					["1Rnd_HE_Grenade_shell",	  8 ],
					["Chemlight_green",			  8 ],
					["HandGrenade",				  10],
					["SmokeShell",				  4 ],
					["SmokeShellGreen",			  6 ],
					["acc_flashlight",			  2 ],
					["H_HelmetB_sand",			  3 ],
					["G_Tactical_Clear",          4 ],
					["bipod_01_F_blk",			  1 ]
				]
			],
			['stash_crash_items', 	[
					["launch_NLAW_F",			  2 ],
					["launch_B_Titan_F",          2 ],
					["arifle_MX_F",				  2 ],
					["arifle_MX_SW_F",			  1 ],
					["arifle_MXC_F",              3 ],
					["30Rnd_65x39_caseless_mag",  12],
					["16Rnd_9x21_Mag",			  4 ],
					["30Rnd_45ACP_Mag_SMG_01",	  8 ],
					["20Rnd_762x51_Mag",		  6 ],
					["100Rnd_65x39_caseless_mag", 4 ],
					["NLAW_F",					  4 ],
					["Titan_AA",				  2 ],
					["1Rnd_HE_Grenade_shell",	  8 ],
					["Chemlight_green",			  8 ],
					["HandGrenade",				  10],
					["SmokeShell",				  4 ],
					["SmokeShellGreen",			  6 ],
					["acc_flashlight",			  2 ],
					["H_HelmetB_sand",			  3 ],
					["G_Tactical_Clear",          4 ],
					["optic_Aco",				  2 ],
					["hgun_P07_F",				  3 ],
					["H_HelmetB_grass",           2 ],
					["B_HMG_01_weapon_F",         5 ],
					["B_AssaultPack_mcamo_AA",    5 ],
					["Medikit",					  2 ],
					["ToolKit",                   1 ],
					["MineDetector",              2 ],
					["bipod_01_F_blk",			  1 ]
				]
			]
		]
	]
 ];
 
 D_FRACTION_CIV_CFG = [
	[
		'CUP_C_SAHRANI', 'CUP Civilian', [
			[
			'mens', [
					'C_man_polo_1_F',
					'C_man_polo_2_F',
					'C_man_polo_3_F',
					'C_man_polo_4_F',
					'C_man_polo_5_F',
					'C_man_polo_6_F',
					'C_man_1_1_F',
					'C_man_1_2_F',
					'C_man_1_3_F']
			],
			[
			'cars', [
					'C_Van_01_box_F',
					'C_Van_01_transport_F',
					'C_SUV_01_F',
					'C_Offroad_01_F',
					'C_Truck_02_fuel_F',
					'C_Truck_02_box_F',
					'C_Truck_02_transport_F',
					'C_Truck_02_covered_F',
					'CUP_C_Skoda_White_CIV',
					'CUP_C_Skoda_Blue_CIV',
					'CUP_C_Dutsan_Tubeframe',
					'CUP_C_Dutsan_Covered',
					'CUP_C_Tractor_CIV',
					'CUP_C_Volha_Blue_TKCIV',
					'CUP_C_V3S_Open_TKC',
					'CUP_C_V3S_Covered_TKC']
			],
			[
			'boats', [
					'C_Boat_Civil_01_F',
					'C_Rubberboat',
					'C_Boat_Civil_01_rescue_F',
					'CUP_C_Fishing_Boat_Chernarus']
			]
		]
	],
	[
		'CIV_F', '', [
			[
			'mens', [
					'C_man_p_beggar_F',
					'C_man_p_beggar_F_afro',
					'C_man_polo_1_F',
					'C_man_polo_2_F',
					'C_man_polo_3_F',
					'C_man_polo_4_F',
					'C_man_polo_5_F',
					'C_man_polo_6_F',
					'C_man_polo_1_F_afro',
					'C_man_polo_2_F_afro',
					'C_man_polo_3_F_afro',
					'C_man_polo_4_F_afro',
					'C_man_polo_5_F_afro',
					'C_man_polo_6_F_afro',
					'C_man_shorts_1_F',
					'C_man_p_fugitive_F',
					'C_man_p_fugitive_F_afro',
					'C_man_p_shorts_1_F',
					'C_man_p_shorts_1_F_afro',
					'C_man_funter_1_F',
					'C_man_shorts_2_F',
					'C_man_shorts_1_F_afro',
					'C_man_shorts_2_F_afro',
					'C_man_shorts_3_F_afro',
					'C_man_shorts_4_F_afro',
					'C_man_shorts_3_F',
					'C_man_shorts_4_F',
					'C_man_w_worker_F',
					'C_man_1_1_F',
					'C_man_1_2_F',
					'C_man_1_3_F']
			],
			[
			'cars', [
					'C_Van_01_box_F',
					'C_Van_01_fuel_F',
					'C_Van_01_transport_F',
					'C_SUV_01_F',
					'C_Offroad_01_F',
					'C_Hatchback_01_F',
					'C_Hatchback_01_sport_F',
					'C_Offroad_01_F',
					'C_Offroad_01_repair_F',
					'C_Truck_02_fuel_F',
					'C_Truck_02_box_F',
					'C_Truck_02_transport_F',
					'C_Truck_02_covered_F']
			],
			[
			'boats', [
					'C_Boat_Civil_01_F',
					'C_Boat_Civil_01_police_F',
					'C_Rubberboat',
					'C_Boat_Civil_01_rescue_F']
			],
			['rebel_weapons',       [
						"arifle_TRG20_F",
						"arifle_TRG21_F",
						"arifle_Mk20_F",
						"arifle_Mk20C_F",
						"arifle_Mk20_GL_F",
						"hgun_PDW2000_F"
					]
			],
			['rebel_armor',       [
						"G_Carryall_Ammo",
						"V_TacVest_blk",
						"V_BandollierB_blk",
						"V_Press_F",
						"V_Chestrig_oli",
						"V_TacVest_brn"
					]
			],
			['rebel_backpack',       [
						"B_FieldPack_oucamo",
						"B_FieldPack_oli",
						"B_Carryall_khk",
						"B_FieldPack_cbr",
						"B_Kitbag_tan",
						"B_Kitbag_cbr"
					]
			],
			['stash_base_items', 	[
					["arifle_TRG20_F",			  5 ],
					["arifle_TRG21_F",            2 ],
					["arifle_Mk20_F",             2 ],
					["hgun_ACPC2_F",              4 ],
					["9Rnd_45ACP_Mag",            9 ],
					["G_Carryall_Ammo",			  5 ],
					["H_Booniehat_khk",			  1 ],
					["30Rnd_556x45_Stanag",       24],
					["V_Chestrig_oli",			  5 ],
					["LMG_Mk200_F",         	  1 ],
					["200Rnd_65x39_cased_Box",	  10],
					["launch_MRAWS_olive_rail_F", 2 ],
					["MRAWS_HEAT_F",			  6 ],
					["H_Bandanna_khk",            2 ],
					["1Rnd_HE_Grenade_shell",	  3 ],
					["V_TacVest_blk",	          3 ],
					["Chemlight_green",			  10],
					["bipod_03_F_blk",			  3 ],
					["HandGrenade",				  6 ],
					["MiniGrenade",               4 ],
					["SmokeShell",				  10],
					["SmokeShellGreen",			  10],
					["acc_flashlight",			  2 ],
					["I_HMG_01_support_F",        5 ],
					["Medikit",                   2 ],
					["H_Cap_oli",                 3 ],
					["optic_ACO_grn",             1 ],
					["MineDetector",              2 ],
					["ToolKit",                   1 ],
					["bipod_01_F_blk",			  1 ]
				]
			],
			['stash_ship_items', 	[
					["arifle_Mk20C_F",			  5 ],
					["hgun_PDW2000_F",            2 ],
					["arifle_Mk20_GL_F",          2 ],
					["hgun_ACPC2_F",              4 ],
					["9Rnd_45ACP_Mag",            9 ],
					["30Rnd_9x21_Yellow_Mag",     10],
					["G_Carryall_Ammo",			  5 ],
					["Titan_AA",                  4 ],
					["V_Chestrig_oli",			  1 ],
					["30Rnd_556x45_Stanag",       18],
					["V_PlateCarrierIA2_dgtl",	  5 ],
					["LMG_Mk200_F",         	  1 ],
					["200Rnd_65x39_cased_Box",	  10],
					["launch_MRAWS_olive_rail_F", 2 ],
					["MRAWS_HEAT_F",			  6 ],
					["V_PlateCarrierIAGL_dgtl",   2 ],
					["1Rnd_HE_Grenade_shell",	  20],
					["H_HelmetIA_net",	          3 ],
					["Chemlight_green",			  20],
					["bipod_03_F_blk",			  3 ],
					["HandGrenade",				  6 ],
					["MiniGrenade",               4 ],
					["SmokeShell",				  10],
					["SmokeShellGreen",			  10],
					["acc_flashlight",			  2 ],
					["Medikit",                   2 ],
					["H_HelmetIA",                3 ],
					["optic_ACO_grn",             5 ],
					["I_Fieldpack_oli_AA",        5 ],
					["MineDetector",              2 ],
					["ToolKit",                   1 ],
					["NVGoggles_INDEP",           7 ],
					["bipod_01_F_blk",			  1 ],
					["V_RebreatherIA",			  4 ],
					["I_Assault_Diver",			  4 ],
					["G_I_Diving",				  4 ]
				]
			]
		]
	]
 ];
 
 D_FRACTION_EAST_CFG = [
	[
		'CUP_O_SLA', 'Sahrani Liberation Army', [
			[
			'patrol', [
					'CUP_O_sla_Soldier',
					'CUP_O_SLA_Soldier_Backpack',
					'CUP_O_sla_Soldier_GL',
					'CUP_O_sla_Soldier_AR',
					'CUP_O_sla_Medic',
					'CUP_O_sla_Soldier_LAT']
			],
			[
			'garrison', [
					'CUP_O_sla_Soldier',
					'CUP_O_SLA_Soldier_Backpack',
					'CUP_O_sla_Soldier_GL',
					'CUP_O_sla_Soldier_AR',
					'CUP_O_sla_Medic',
					'CUP_O_sla_Soldier_AT',
					'CUP_O_sla_Sniper',
					'CUP_O_sla_Soldier_MG',
					'CUP_O_sla_Engineer',
					'CUP_O_sla_Soldier_AMG',
					'CUP_O_sla_Soldier_LAT']
			],
			[
			'cars', [
					'CUP_O_UAZ_AGS30_SLA',
					'CUP_O_UAZ_MG_SLA']
			],
			[
			'light', [
					'CUP_O_BMP2_SLA',
					'CUP_O_BRDM2_SLA',
					'CUP_O_BTR60_SLA']
			],
			[
			'heavy', [
					'CUP_O_T55_SLA',
					'CUP_O_T72_SLA']
			],
			[
			'transport', [
					'CUP_O_Ural_SLA',
					'CUP_O_Ural_Open_SLA']
			],
			[
			'heli', [
					'O_Heli_Light_02_unarmed_F']
			],
			[
			'stash_base_items', [
				["launch_RPG32_F",				 4 ],
				["arifle_Katiba_F",				 6 ],
				["LMG_Zafir_F",					 5 ],
				["16Rnd_9x21_Mag",				 25],
				["30Rnd_65x39_caseless_green",	 15],
				["10Rnd_762x54_Mag",			 15],
				["150Rnd_762x54_Box",			 8 ],
				["1Rnd_HE_Grenade_shell",		 10],
				["Chemlight_red",				 10],
				["RPG32_F",						 5 ],
				["RPG32_HE_F",					 5 ],
				["Laserbatteries",				 4 ],
				["HandGrenade",					 10],
				["SmokeShell",					 10],
				["SmokeShellRed",				 10],
				["30Rnd_9x21_Mag_SMG_02",		 16],
				["Laserdesignator_02",			 2 ],
				["acc_flashlight",				 4 ],
				["bipod_02_F_blk",				 4 ],
				["B_FieldPack_ocamo",			 10]]
			]
		]
	],
	[
		'OPF_F', 'CSAT', [
			[
			'patrol', [
					'O_Soldier_F',
					'O_Soldier_lite_F',
					'O_Soldier_SL_F',
					'O_Soldier_TL_F',
					'O_Soldier_GMG_F',
					'O_Soldier_HMG_F',
					'O_Soldier_AMG_F',
					'O_Soldier_GL_F',
					'O_Soldier_AR_F',
					'O_Soldier_A_F',
					'O_Soldier_AAR_F',
					'O_medic_F']
			],
			[
			'garrison', [
					'O_Soldier_F',
					'O_Soldier_lite_F',
					'O_Soldier_SL_F',
					'O_Soldier_TL_F',
					'O_Soldier_GMG_F',
					'O_Soldier_HMG_F',
					'O_Soldier_AMG_F',
					'O_Soldier_GL_F',
					'O_Soldier_AR_F',
					'O_Soldier_A_F',
					'O_Soldier_AAR_F',
					'O_Soldier_AAA_F',
					'O_Soldier_AAT_F',
					'O_emgineer_F',
					'O_soldier_exp_F',
					'O_soldier_M_F',
					'O_Soldier_AA_F',
					'O_Soldier_AT_F',
					'O_soldier_UAV_F',
					'O_Soldier_LAT_F',
					'O_officer_F',
					'O_medic_F']
			],
			['Team Leader', 'O_Soldier_TL_F'],
			['Corpsman', 	'O_medic_F'],
			['Grenadier', 	'O_Soldier_GL_F'],
			['Rifleman', 	'O_Soldier_F'],
			['Squad Leader','O_Soldier_SL_F'],
			['Autorifleman','O_Soldier_AR_F'],
			['Sniper', 		'O_sniper_F'],
			['Spotter', 	'O_spotter_F'],
			[
			'cars', [
					'O_MRAP_02_F',
					'O_MRAP_02_gmg_F',
					'O_MRAP_02_hmg_F']
			],
			[
			'light', [
					'O_APC_Wheeled_02_rcws_v2_F',
					'O_APC_Tracked_02_cannon_F']
			],
			[
			'heavy', [
					'O_MBT_02_cannon_F']
			],
			[
			'antiair', [
					'O_APC_Tracked_02_AA_F']
			],
			[
			'transport', [
					'O_Truck_03_transport_F',
					'O_Truck_03_covered_F',
					'O_Truck_02_transport_F',
					'O_Truck_02_covered_F']
			],
			[
			'transport_ammo', [
					'O_Truck_02_ammo_F',
					'O_Truck_03_ammo_F']
			],
			[
			'transport_repair', [
					'O_Truck_02_box_F',
					'O_Truck_03_repair_F']
			],
			[
			'transport_fuel', [
					'O_Truck_02_fuel_F',
					'O_Truck_03_fuel_F']
			],
			[
			'transport_medic', [
					'O_Truck_02_medical_F',
					'O_Truck_03_medical_F']
			],
			[
			'heli', [
					'O_Heli_Light_02_unarmed_F']
			],
			[
			'stash_base_items', [
				["launch_RPG32_F",				 4 ],
				["arifle_Katiba_F",				 6 ],
				["LMG_Zafir_F",					 5 ],
				["16Rnd_9x21_Mag",				 25],
				["30Rnd_65x39_caseless_green",	 15],
				["10Rnd_762x54_Mag",			 15],
				["150Rnd_762x54_Box",			 8 ],
				["1Rnd_HE_Grenade_shell",		 10],
				["Chemlight_red",				 10],
				["RPG32_F",						 5 ],
				["RPG32_HE_F",					 5 ],
				["Laserbatteries",				 4 ],
				["HandGrenade",					 10],
				["SmokeShell",					 10],
				["SmokeShellRed",				 10],
				["30Rnd_9x21_Mag_SMG_02",		 16],
				["Laserdesignator_02",			 2 ],
				["acc_flashlight",				 4 ],
				["bipod_02_F_blk",				 4 ],
				["B_FieldPack_ocamo",			 10]]
			]
		]
	]
 ];
 
 D_FRACTION_INDEP_CFG = [
	[
		'CUP_I_NAPA', 'National Party of Chernarus', [
			[
			'patrol', [
					'CUP_I_GUE_Soldier_AKS74',
					'CUP_I_GUE_Soldier_AKM',
					'CUP_I_GUE_Soldier_AKSU',
					'CUP_I_GUE_Soldier_MG',
					'CUP_I_GUE_Soldier_AR',
					'CUP_I_GUE_Saboteur',
					'CUP_I_GUE_Medic',
					'CUP_I_GUE_Crew']
			],
			[
			'garrison', [
					'CUP_I_GUE_Soldier_AKS74',
					'CUP_I_GUE_Soldier_AKM',
					'CUP_I_GUE_Soldier_AKSU',
					'CUP_I_GUE_Soldier_MG',
					'CUP_I_GUE_Soldier_AR',
					'CUP_I_GUE_Soldier_AT',
					'CUP_I_GUE_Soldier_AA',
					'CUP_I_GUE_Soldier_GL',
					'CUP_I_GUE_Saboteur',
					'CUP_I_GUE_Medic',
					'CUP_I_GUE_Officer',
					'CUP_I_GUE_Crew']
			],
			[
			'cars', [
					'CUP_I_Datsun_PK',
					'CUP_I_Datsun_PK_Random']
			],
			[
			'light', [
					'CUP_I_Ural_ZU23_NAPA',
					'CUP_I_BMP2_NAPA',
					'CUP_I_BRDM2_NAPA']
			],
			[
			'heavy', [
					'CUP_I_T34_NAPA',
					'CUP_I_T55_NAPA']
			],
			[
			'transport', [
					'CUP_V3S_Open_NAPA']
			]
		]
	],
	[
		'CUP_I_TK_GUE', 'Takistani Locals', [
			[
			'patrol', [
					'CUP_I_TK_GUE_Soldier',
					'CUP_I_TK_GUE_Soldier_AK_47S',
					'CUP_I_TK_GUE_Guerilla_Enfield',
					'CUP_I_TK_GUE_Guerilla_Medic',
					'CUP_I_TK_GUE_Soldier_M16A2',
					'CUP_I_TK_GUE_Soldier_AR',
					'CUP_I_TK_GUE_Soldier_MG']
			],
			[
			'garrison', [
					'CUP_I_TK_GUE_Soldier',
					'CUP_I_TK_GUE_Soldier_AK_74S',
					'CUP_I_TK_GUE_Guerilla_Enfield',
					'CUP_I_TK_GUE_Guerilla_Medic',
					'CUP_I_TK_GUE_Soldier_M16A2',
					'CUP_I_TK_GUE_Soldier_AR',
					'CUP_I_TK_GUE_Soldier_AT',
					'CUP_I_TK_GUE_Soldier_AA',
					'CUP_I_TK_GUE_Soldier_MG',
					'CUP_I_TK_GUE_Soldier_TL',
					'CUP_I_TK_GUE_Soldier_LAT',
					'CUP_I_TK_GUE_Sniper']
			],
			[
			'cars', [
					'CUP_I_Datsun_PK_TK',
					'CUP_I_Datsun_PK_TK_Random']
			],
			[
			'light', [
					'CUP_I_BRDM2_TK_Gue',
					'CUP_I_BMP1_TK_GUE',
					'CUP_I_BRDM2_NAPA']
			],
			[
			'heavy', [
					'CUP_I_T34_TK_GUE',
					'CUP_I_T55_TK_GUE']
			],
			[
			'transport', [
					'CUP_V3S_Open_TKG',
					'CUP_V3S_Covered_TKG']
			]
		]
	],
	[
		'CUP_I_RACS', 'Royal Army Corps of Sahrani', [
			[
			'patrol', [
					'CUP_I_RACS_Soldier_Light_Mech',
					'CUP_I_RACS_Soldier_Mech',
					'CUP_I_RACS_Medic_Mech',
					'CUP_I_RACS_MMG_Mech']
			],
			[
			'garrison', [
					'CUP_I_RACS_Soldier_Light_Mech',
					'CUP_I_RACS_Soldier_AMG_Mech',
					'CUP_I_RACS_Soldier_Mech',
					'CUP_I_RACS_Soldier_Light_Mech',
					'CUP_I_RACS_Soldier_MAT_Mech',
					'CUP_I_RACS_Soldier_Light_Mech',
					'CUP_I_RACS_Medic_Mech',
					'CUP_I_RACS_MMG_Mech',
					'CUP_I_RACS_AR_Mech',
					'CUP_I_RACS_Soldier_Light_Mech',
					'CUP_I_RACS_M_Mech',
					'CUP_I_RACS_Soldier_Light_Mech',
					'CUP_I_RACS_SL_Mech']
			],
			[
			'cars', [
					'CUP_I_LR_MG_RACS']
			],
			[
			'light', [
					'CUP_I_M163_RACS',
					'CUP_I_LAV25_RACS',
					'CUP_I_LAV25M240_RACS',
					'CUP_I_M113_RACS',
					'CUP_I_M113_RACS_URB']
			],
			[
			'heavy', [
					'CUP_I_M60A3_RACS',
					'CUP_I_T72_RACS']
			],
			[
			'transport', [
					'CUP_I_AAV_RACS',
					'CUP_I_M113_RACS',
					'CUP_I_M113_RACS_URB']
			]
		]
	],
	[
		'IND_F', 'AAF', [
			[
			'patrol', [
					'I_soldier_F',
					'I_support_MG_F',
					'I_Soldier_lite_F',
					'I_medic_F']
			],
			[
			'garrison', [
					'I_soldier_F',
					'I_Soldier_LAT_F',
					'I_Soldier_AT_F',
					'I_Soldier_AA_F',
					'I_Soldier_GL_F',
					'I_Soldier_TL_F',
					'I_Soldier_M_F',
					'I_Soldier_AR_F',
					'I_support_MG_F',
					'I_Soldier_lite_F',
					'I_medic_F']
			],
			[
			'cars', [
					'I_MRAP_03_gmg_F',
					'I_MRAP_03_hmg_F',
					'CUP_I_LR_MG_AAF',
					'CUP_I_LR_SF_GMG_AAF',
					'CUP_I_LR_SF_HMG_AAF']
			],
			[
			'light', [
					'CUP_I_M163_AAF',
					'CUP_I_M113_AAF',
					'CUP_I_APC_tracked_30_cannon_F',
					'I_APC_Wheeled_03_cannon_F']
			],
			[
			'heavy', [
					'CUP_I_ZSU23_AAF',
					'CUP_LT_01_AT_F',
					'CUP_LT_01_cannon_F',
					'I_MBT_03_cannon_F']
			],
			[
			'transport', [
					'I_Truck_02_transport_F',
					'I_Truck_02_covered_F']
			],
			[
			'transport_ammo', [
					'I_Truck_02_ammo_F']
			],
			[
			'transport_repair', [
					'I_Truck_02_box_F']
			],
			[
			'transport_fuel', [
					'I_Truck_02_fuel_F']
			],
			[
			'transport_medic', [
					'I_Truck_02_medical_F']
			],
			['leader', 'I_Story_Colonel_F'],
			[
			'heli', [
					'I_Heli_light_03_dynamicLoadout_F']
			]
		]
	]
]
