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
		'CUP_B_USMC', 'USMC', [
			[
			'transport', ['B_T_VTOL_01_infantry_F']
			],
			[
			'heli', ['CUP_B_MH6J_USA']
			],
			[
			'boats', ['CUP_B_RHIB2Turret_USMC', 'CUP_B_RHIB_USMC']
			],
			['transport_wreck', 'Land_UWreck_MV22_F'],
			['transport_z_offset', 4.7],
			['base_hgun', ["CUP_hgun_Colt1911", "CUP_7Rnd_45ACP_1911"]],
			['Team Leader', 'CUP_B_USMC_Soldier_TL'],
			['Corpsman', 	'CUP_B_USMC_Medic'],
			['Grenadier', 	'CUP_B_USMC_Soldier_GL'],
			['Rifleman', 	'CUP_B_USMC_Soldier_LAT'],
			['Squad Leader','CUP_B_USMC_Soldier_SL'],
			['Autorifleman','CUP_B_USMC_Soldier_AR'],
			['SpecOps Sniper', 		'CUP_B_USMC_Sniper_M107'],
			['SpecOps Spotter', 	'CUP_B_USMC_Spotter'],
			['SpecOps Team Leader', 'CUP_B_USMC_Spotter'],
			['SpecOps Saboteur', 	'CUP_B_USMC_Spotter'],
			['SpecOps Paramedic', 	'CUP_B_USMC_Spotter'],
			['Recon Team Leader',   'CUP_B_FR_Soldier_TL'],
			['Recon Paramedic', 	'CUP_B_FR_Medic'],
			['Recon Marksman', 	    'CUP_B_FR_Soldier_Marksman'],
			['Recon Scout', 	    'CUP_B_FR_Saboteur'],
			['rescue_Team Leader',  'CUP_B_FR_Commander'],
			['rescue_Corpsman', 	'CUP_B_FR_Medic'],
			['rescue_Grenadier', 	'CUP_B_FR_Soldier_Assault_GL'],
			['rescue_Rifleman', 	'CUP_B_FR_Soldier_Assault'],
			['rescue_Squad Leader', 'CUP_B_FR_Soldier_TL'],
			['rescue_Autorifleman', 'CUP_B_FR_Soldier_AR'],
			['rescue_Recon Team Leader',    'CUP_B_FR_Soldier_TL'],
			['rescue_Recon Paramedic',   	'CUP_B_FR_Medic'],
			['rescue_Recon Marksman', 	    'CUP_B_FR_Soldier_Marksman'],
			['rescue_Recon Scout', 	        'CUP_B_FR_Saboteur'],
			['rescue_SpecOps Sniper', 		'CUP_B_FR_Soldier_Marksman'],
			['rescue_SpecOps Spotter', 		'CUP_B_FR_Saboteur'],
			['rescue_SpecOps Team Leader',  'CUP_B_FR_Saboteur'],
			['rescue_SpecOps Saboteur', 	'CUP_B_FR_Saboteur'],
			['rescue_SpecOps Paramedic', 	'CUP_B_FR_Saboteur'],
			['stash_base_items', 	[
					["CUP_launch_Mk153Mod0",	  2 ],
					["CUP_arifle_M16A4_Base",	  2 ],
					["CUP_arifle_M4A1_black",	  2 ],
					["Laserdesignator",		      1 ],
					["CUP_30Rnd_556x45_Stanag",   24],
					["CUP_15Rnd_9x19_M9",		  16],
					["CUP_7Rnd_45ACP_1911",	      16],
					["CUP_SMAW_Spotting",		  2 ],
					["CUP_10Rnd_127x99_M107",	  10],
					["CUP_200Rnd_TE4_Green_Tracer_556x45_M249", 20],
					["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M", 20],
					["CUP_1Rnd_HEDP_M203",	      30],
					["Chemlight_green",			  20],
					["Laserbatteries",			  3 ],
					["CUP_20Rnd_762x51_DMR",      20],
					["CUP_HandGrenade_M67",		  20],
					["SmokeShell",				  10],
					["SmokeShellGreen",			  10],
					["CUP_acc_ANPEQ_2",			  2 ],
					["CUP_H_USMC_LWH_ESS_LR_WDL", 10 ],
					["CUP_G_Oakleys_Clr",         10 ],
					["CUP_bipod_Harris_1A2_L",	  4 ]
				]
			],
			['stash_safe_items', 	[
					["CUP_launch_Mk153Mod0",	  2 ],
					["CUP_arifle_M16A4_Base",	  2 ],
					["CUP_arifle_M4A1_black",     2 ],
					["CUP_hgun_Colt1911",         4 ],
					["CUP_30Rnd_556x45_Stanag",   12],
					["CUP_SMAW_Spotting",	      2 ],
					["CUP_7Rnd_45ACP_1911",  	  8 ],
					["CUP_10Rnd_127x99_M107",     6 ],
					["CUP_200Rnd_TE4_Green_Tracer_556x45_M249", 5],
					["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M", 4],
					["CUP_20Rnd_762x51_DMR",      7 ],
					["CUP_SMAW_HEAA_M",			  4 ],
					["CUP_SMAW_HEDP_M",           4 ],
					["CUP_1Rnd_HEDP_M203",   	  8 ],
					["Chemlight_green",			  8 ],
					["CUP_HandGrenade_M67",		  10],
					["SmokeShell",				  4 ],
					["SmokeShellGreen",			  6 ],
					["CUP_acc_ANPEQ_2",			  2 ],
					["CUP_B_USMC_AssaultPack",    3 ],
					["CUP_H_USMC_LWH_ESS_LR_WDL", 10 ],
					["CUP_G_Oakleys_Clr",         10 ],
					["CUP_bipod_Harris_1A2_L",	  4 ]
				]
			],
			['stash_crash_items', 	[
					["CUP_launch_Mk153Mod0",	  2 ],
					["CUP_launch_Javelin",        2 ],
					["CUP_arifle_M16A4_Base",	  2 ],
					["CUP_arifle_M16A4_GL",		  2 ],
					["CUP_arifle_M4A1_black",     3 ],
					["CUP_lmg_M249",              1 ],
					["CUP_hgun_Colt1911",         4 ],
					["CUP_SMAW_Spotting",         2 ],
					["CUP_30Rnd_556x45_Stanag",   24],
					["CUP_15Rnd_9x19_M9",		  16],
					["CUP_7Rnd_45ACP_1911",	      16],
					["CUP_10Rnd_127x99_M107",	  10],
					["CUP_200Rnd_TE4_Green_Tracer_556x45_M249", 4],
					["CUP_SMAW_HEAA_M",			  4 ],
					["CUP_SMAW_HEDP_M",           4 ],
					["CUP_launch_FIM92Stinger",	  2 ],
					["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M", 3],
					["CUP_20Rnd_762x51_DMR",      4 ],
					["Laserdesignator",		      1 ],
					["CUP_optic_LeupoldMk4_25x50_LRT", 1],
					["CUP_1Rnd_HEDP_M203",	      8 ],
					["Chemlight_green",			  8 ],
					["CUP_HandGrenade_M67",  	  10],
					["SmokeShell",				  4 ],
					["SmokeShellGreen",			  6 ],
					["CUP_acc_ANPEQ_2",			  2 ],
					["CUP_H_USMC_LWH_ESS_LR_WDL", 10 ],
					["CUP_G_Oakleys_Clr",         10 ],
					["CUP_optic_ACOG",	          2 ],
					["CUP_hgun_M9",				  3 ],
					["CUP_H_USMC_Headset_HelmetWDL", 2 ],
					["B_Kitbag_tan",              5 ],
					["CUP_B_USMC_AssaultPack",    5 ],
					["Medikit",					  2 ],
					["ToolKit",                   1 ],
					["CUP_bipod_Harris_1A2_L",	  4 ]
				]
			],
			['prison_items', 	[
					["CUP_hgun_Colt1911",         4 ],
					["CUP_7Rnd_45ACP_1911",	      6 ],
					["Chemlight_green",			  8 ],
					["CUP_HandGrenade_M67",  	  2 ],
					["SmokeShell",				  2 ],
					["SmokeShellGreen",			  2 ],
					["Medikit",					  10],
					["ToolKit",                   1 ]
				]
			]
		]
	],
	[
		'BLU_F', 'NATO', [
			[
			'transport', ['B_T_VTOL_01_infantry_F']  
			],
			[
			'heli', ['B_Heli_Light_01_F']
			],
			[
			'boats', ['B_Boat_Armed_01_minigun_F']
			],
			['transport_wreck', 'Land_UWreck_MV22_F'],
			['transport_z_offset', 4.7],
			['base_hgun', ["hgun_P07_F", "16Rnd_9x21_Mag"]],
			['Team Leader', 'B_Soldier_TL_F'],
			['Corpsman', 	'B_medic_F'],
			['Grenadier', 	'B_Soldier_GL_F'],
			['Rifleman', 	'B_Soldier_LAT_F'],
			['Squad Leader','B_Soldier_SL_F'],
			['Autorifleman','B_Soldier_AR_F'],
			['SpecOps Sniper', 		'B_sniper_F'],
			['SpecOps Spotter', 	'B_spotter_F'],
			['SpecOps Team Leader', 'B_spotter_F'],
			['SpecOps Saboteur', 	'B_spotter_F'],
			['SpecOps Paramedic', 	'B_spotter_F'],
			['Recon Team Leader',   'B_recon_TL_F'],
			['Recon Paramedic', 	'B_recon_medic_F'],
			['Recon Marksman', 	    'B_recon_M_F'],
			['Recon Scout', 	    'B_recon_LAT_F'],
			['rescue_Team Leader',  'B_recon_TL_F'],
			['rescue_Corpsman', 	'B_recon_medic_F'],
			['rescue_Grenadier', 	'B_recon_JTAC_F'],
			['rescue_Rifleman', 	'B_recon_F'],
			['rescue_Squad Leader', 'B_recon_TL_F'],
			['rescue_Autorifleman', 'B_recon_LAT_F'],
			['rescue_Recon Team Leader',    'B_recon_TL_F'],
			['rescue_Recon Paramedic',   	'B_recon_medic_F'],
			['rescue_Recon Marksman', 	    'B_recon_M_F'],
			['rescue_Recon Scout', 	        'B_recon_LAT_F'],
			['rescue_SpecOps Sniper', 		'B_sniper_F'],
			['rescue_SpecOps Spotter', 		'B_spotter_F'],
			['rescue_SpecOps Team Leader',  'B_spotter_F'],
			['rescue_SpecOps Saboteur', 	'B_spotter_F'],
			['rescue_SpecOps Paramedic', 	'B_spotter_F'],
			['stash_base_items', 	[
					["arifle_MX_F",				  2 ],
					["arifle_MX_SW_F",			  2 ],
					["Laserdesignator",			  2 ],
					["30Rnd_65x39_caseless_mag",  30],
					["16Rnd_9x21_Mag",			  20],
					["30Rnd_45ACP_Mag_SMG_01",	  20],
					["20Rnd_762x51_Mag",		  20],
					["7Rnd_408_Mag",			  20],
					["100Rnd_65x39_caseless_mag", 30],
					["1Rnd_HE_Grenade_shell",	  20],
					["Chemlight_green",			  20],
					["Laserbatteries",			  10],
					["HandGrenade",				  30],
					["SmokeShell",				  20],
					["SmokeShellGreen",			  20],
					["acc_flashlight",			  2 ],
					["bipod_01_F_blk",			  2 ]
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
					["B_Kitbag_tan",              5 ],
					["B_AssaultPack_mcamo",       5 ],
					["Medikit",					  2 ],
					["ToolKit",                   1 ],
					["MineDetector",              2 ],
					["bipod_01_F_blk",			  1 ]
				]
			],
			['prison_items', 	[
					["hgun_P07_F",                4 ],
					["16Rnd_9x21_Mag",	          6 ],
					["Chemlight_green",			  8 ],
					["HandGrenade",  	          2 ],
					["SmokeShell",				  2 ],
					["SmokeShellGreen",			  2 ],
					["Medikit",					  10],
					["ToolKit",                   1 ]
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
			'transport', [
					'C_Offroad_01_F',
					'C_Van_01_transport_F',
					'CUP_C_Datsun',
					'C_SUV_01_F',
					'CUP_C_Skoda_Blue_CIV',
					'CUP_C_Dutsan_Tubeframe',
					'CUP_C_Dutsan_Covered',
					'CUP_C_Volha_Blue_TKCIV']
			],
			[
			'transport_medic', [
					'CUP_O_LR_Ambulance_TKA']
			],
			[
			'boats', [
					'C_Boat_Civil_01_F',
					'C_Rubberboat',
					'C_Boat_Civil_01_rescue_F',
					'CUP_C_Fishing_Boat_Chernarus']
			],
			['rebel_weapons',       [
						"CUP_arifle_AK74_Early",
						"CUP_arifle_AK74_GL_Early",
						"CUP_arifle_AK74M",
						"CUP_arifle_AKS74U",
						"arifle_Mk20_GL_F",
						"hgun_PDW2000_F"
					]
			],
			['rebel_armor',       [
						"CUP_V_B_Armatus_Black",
						"CUP_V_B_Ciras_Black",
						"CUP_V_B_Ciras_Olive",
						"V_Press_F",
						"CUP_V_I_Guerilla_Jacket",
						"V_TacVest_brn"
					]
			],
			['rebel_backpack',       [
						"CUP_B_IDF_Backpack",
						"CUP_B_RUS_Backpack",
						"B_Messenger_Black_F",
						"CUP_B_HikingPack_Civ",
						"B_Kitbag_tan",
						"B_Kitbag_cbr"
					]
			],
			['stash_base_items', 	[
					["CUP_arifle_AK74_Early",     5 ],
					["CUP_arifle_AK74_GL_Early",  2 ],
					["CUP_arifle_AK74M",          2 ],
					["CUP_arifle_AKS74U",         2 ],
					["CUP_hgun_Makarov",          4 ],
					["CUP_8Rnd_9x18_Makarov_M",   9 ],
					["G_Carryall_Ammo",			  5 ],
					["H_Booniehat_khk",			  1 ],
					["CUP_30Rnd_545x39_AK74_plum_M",  24],
					["CUP_30Rnd_545x39_AK74M_M",  10],
					["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M", 15],
					["V_Chestrig_oli",			  5 ],
					["CUP_arifle_RPK74_45",       1 ],
					["CUP_launch_RPG18",          5 ],
					["H_Bandanna_khk",            2 ],
					["CUP_1Rnd_HE_GP25_M",	      7 ],
					["V_TacVest_blk",	          3 ],
					["Chemlight_green",			  10],
					["bipod_03_F_blk",			  3 ],
					["CUP_HandGrenade_RGD5",	  6 ],
					["CUP_HandGrenade_RGO",       4 ],
					["SmokeShell",				  10],
					["SmokeShellGreen",			  10],
					["acc_flashlight",			  2 ],
					["I_HMG_01_support_F",        5 ],
					["Medikit",                   2 ],
					["H_Cap_oli",                 3 ],
					["optic_ACO_grn",             1 ],
					["ToolKit",                   1 ],
					["bipod_01_F_blk",			  1 ]
				]
			],
			['stash_ship_items', 	[
					["CUP_arifle_AK101_top_rail", 5 ],
					["CUP_arifle_AK101_GL_top_rail",  2 ],
					["CUP_arifle_AK74M",          2 ],
					["CUP_arifle_AKS74U",         2 ],
					["CUP_hgun_SA61",          4 ],
					["CUP_10Rnd_B_765x17_Ball_M",   9 ],
					["G_Carryall_Ammo",			  5 ],
					["H_Booniehat_khk",			  1 ],
					["CUP_30Rnd_545x39_AK74_plum_M",  24],
					["CUP_30Rnd_556x45_AK",  10],
					["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M", 15],
					["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M", 6],
					["V_Chestrig_oli",			  5 ],
					["CUP_arifle_RPK74M_railed",  1 ],
					["CUP_lmg_PKM",               1 ],
					["CUP_launch_RPG18",          5 ],
					["CUP_PG7V_M",                5 ],
					["CUP_PG7V_M",                5 ],
					["CUP_OG7_M",                 5 ],
					["V_PlateCarrierIAGL_dgtl",   2 ],
					["CUP_1Rnd_HE_GP25_M",	      20],
					["H_HelmetIA_net",	          3 ],
					["Chemlight_green",			  20],
					["bipod_03_F_blk",			  3 ],
					["CUP_HandGrenade_RGD5",	  6 ],
					["CUP_HandGrenade_RGO",       4 ],
					["SmokeShell",				  10],
					["SmokeShellGreen",			  10],
					["acc_flashlight",			  2 ],
					["Medikit",                   2 ],
					["H_HelmetIA",                3 ],
					["optic_ACO_grn",             5 ],
					["I_Fieldpack_oli_AA",        5 ],
					["ToolKit",                   1 ],
					["CUP_NVG_PVS7",              7 ],
					["bipod_01_F_blk",			  1 ],
					["V_RebreatherIA",			  4 ],
					["I_Assault_Diver",			  4 ],
					["G_I_Diving",				  4 ]
				]
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
			'transport', [
					'C_Offroad_01_F',
					'C_Van_01_transport_F',
					'C_SUV_01_F']
			],
			[
			'transport_medic', [
					'C_Van_02_medevac_F',
					'C_IDAP_Van_02_medevac_F']
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
			['Team Leader', 'CUP_O_sla_SpecOps_TL'],
			['Corpsman', 	'CUP_O_sla_Medic'],
			['Grenadier', 	'CUP_O_sla_SpecOps'],
			['Rifleman', 	'CUP_O_sla_SpecOps'],
			['Squad Leader','CUP_O_sla_Officer'],
			['Autorifleman','CUP_O_sla_SpecOps_MG'],
			['Sniper', 		'CUP_O_sla_Sniper'],
			['Spotter', 	'CUP_O_sla_Spotter'],
			['Recon Team Leader',   'CUP_O_sla_SpecOps_TL'],
			['Recon Paramedic',   	'CUP_O_sla_Medic'],
			['Recon Marksman', 	    'CUP_O_sla_SpecOps_MG'],
			['Recon Scout', 	    'CUP_O_sla_SpecOps'],
			['SpecOps Sniper', 		'CUP_O_sla_Sniper'],
			['SpecOps Spotter', 	'CUP_O_sla_Spotter'],
			['SpecOps Team Leader', 'CUP_O_sla_Spotter'],
			['SpecOps Saboteur', 	'CUP_O_sla_Spotter'],
			['SpecOps Paramedic', 	'CUP_O_sla_Spotter'],
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
			'antiair', [
					'CUP_O_ZSU23_SLA']
			],
			[
			'transport', [
					'CUP_O_Ural_SLA',
					'CUP_O_Ural_Open_SLA']
			],
			[
			'transport_ammo', [
					'CUP_O_Ural_Reammo_SLA']
			],
			[
			'transport_repair', [
					'CUP_O_Ural_Repair_SLA']
			],
			[
			'transport_fuel', [
					'CUP_O_Ural_Refuel_SLA']
			],
			[
			'transport_medic', [
					'CUP_O_Ural_Empty_SLA']
			],
			[
			'heli', [
					'CUP_O_UH1H_slick_SLA']
			],
			[
			'stash_base_items', [
				["CUP_launch_RPG18",			 4 ],
				["CUP_arifle_AK74",				 6 ],
				["CUP_launch_RPG7V",		     2 ],
				["Binocular",					 5 ],
				["CUP_30Rnd_545x39_AK_M",		 35],
				["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",15],
				["CUP_8Rnd_9x18_Makarov_M",		 8 ],
				["CUP_1Rnd_HEDP_M203",		     10],
				["Chemlight_red",				 10],
				["CUP_PG7V_M",					 5 ],
				["CUP_OG7_M",					 5 ],
				["RPG32_HE_F",					 5 ],
				["Laserbatteries",				 4 ],
				["CUP_HandGrenade_RGD5",		 10],
				["SmokeShell",					 10],
				["SmokeShellRed",				 10],
				["CUP_H_SLA_Beret",		         20],
				["Laserdesignator_02",			 2 ],
				["acc_flashlight",				 4 ],
				["bipod_02_F_blk",				 4 ],
				["CUP_B_RUS_Backpack",           10]]
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
			['Recon Team Leader',   'O_recon_TL_F'],
			['Recon Paramedic',   	'O_recon_medic_F'],
			['Recon Marksman', 	    'O_recon_M_F'],
			['Recon Scout', 	    'O_recon_F'],
			['SpecOps Sniper', 		'O_sniper_F'],
			['SpecOps Spotter', 	'O_spotter_F'],
			['SpecOps Team Leader', 'O_spotter_F'],
			['SpecOps Saboteur', 	'O_spotter_F'],
			['SpecOps Paramedic', 	'O_spotter_F'],
			[
			'cars', [
					'O_MRAP_02_F'
					]
			],
			[
			'light', [
			        'O_MRAP_02_gmg_F',
					'O_MRAP_02_hmg_F',
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
			],
			[
			'transport_ammo', [
					'CUP_I_V3S_Rearm_TKG']
			],
			[
			'transport_repair', [
					'CUP_I_V3S_Repair_TKG']
			],
			[
			'transport_fuel', [
					'CUP_I_V3S_Refuel_TKG']
			],
			[
			'transport_medic', [
					'I_Truck_02_medical_F']
			],
			['leader', ['CUP_I_GUE_Commander', ['CUP_arifle_AKS', 'CUP_hgun_Glock17']]],
			[
			'heli', [
					'CUP_I_UH1H_slick_TK_GUE']
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
					'CUP_I_V3S_Open_TKG',
					'CUP_I_V3S_Covered_TKG']
			],
			[
			'transport_ammo', [
					'CUP_I_V3S_Rearm_TKG']
			],
			[
			'transport_repair', [
					'CUP_I_V3S_Repair_TKG']
			],
			[
			'transport_fuel', [
					'CUP_I_V3S_Refuel_TKG']
			],
			[
			'transport_medic', [
					'I_Truck_02_medical_F']
			],
			['leader', ['CUP_I_TK_GUE_Commander', ['CUP_arifle_AKS', 'CUP_hgun_Glock17']]],
			[
			'heli', [
					'CUP_I_UH1H_slick_TK_GUE']
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
			],
			[
			'transport_ammo', [
					'I_Truck_02_ammo_F']
			],
			[
			'transport_repair', [
					'I_G_Offroad_01_repair_F']
			],
			[
			'transport_fuel', [
					'I_G_Van_01_fuel_F']
			],
			[
			'transport_medic', [
					'I_Truck_02_medical_F']
			],
			['leader', ['CUP_I_RACS_Officer', ['CUP_arifle_M16A2', 'CUP_hgun_Glock17']]],
			[
			'heli', [
					'CUP_I_UH_60L_FFV_RACS']
			]
		]
	],
	[
		'IND_G_F', 'FIA', [
			[
			'patrol', [
					'I_G_Soldier_F',
					'I_G_Soldier_A_F',
					'I_G_Soldier_AR_F',
					'I_G_Soldier_LAT_F',
					'I_G_Soldier_lite_F',
					'I_G_Soldier_GL_F',
					'I_G_Soldier_SL_F',
					'I_G_Soldier_exp_F',
					'I_G_engineer_F',
					'I_G_medic_F']
			],
			[
			'garrison', [
					'I_G_Soldier_F',
					'I_G_Soldier_A_F',
					'I_G_Soldier_AR_F',
					'I_G_Soldier_LAT_F',
					'I_G_Soldier_lite_F',
					'I_G_Soldier_GL_F',
					'I_G_Soldier_SL_F',
					'I_G_Soldier_TL_F',
					'I_G_Soldier_exp_F',
					'I_G_engineer_F',
					'I_G_medic_F']
			],
			[
			'cars', [
					'I_G_Offroad_01_AT_F',
					'I_G_Offroad_01_armed_F']
			],
			[
			'light', ['I_MRAP_03_gmg_F',
					'I_MRAP_03_hmg_F']
			],
			[
			'heavy', [
					'I_APC_tracked_03_cannon_F',
					'I_APC_Wheeled_03_cannon_F']
			],
			[
			'transport', [
					'I_G_Van_02_transport_F']
			],
			[
			'transport_ammo', [
					'I_Truck_02_ammo_F']
			],
			[
			'transport_repair', [
					'I_G_Offroad_01_repair_F']
			],
			[
			'transport_fuel', [
					'I_G_Van_01_fuel_F']
			],
			[
			'transport_medic', [
					'I_Truck_02_medical_F']
			],
			['leader', ['I_C_Soldier_Camo_F', ['arifle_Mk20_F', 'hgun_ACPC2_F']]],
			[
			'heli', [
					'I_Heli_light_03_unarmed_F']
			]
		]
	],
	[
		'IND_F', 'AAF', [
			[
			'patrol', [
					'I_soldier_F',
					'I_support_MG_F',
					'I_Soldier_LAT_F',
					'I_Soldier_AT_F',
					'I_Soldier_GL_F',
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
					'I_MRAP_03_hmg_F']
			],
			[
			'light', [
					'I_APC_tracked_03_cannon_F',
					'I_APC_Wheeled_03_cannon_F']
			],
			[
			'heavy', [
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
			['leader', ['I_Story_Colonel_F', ['arifle_Mk20_F', 'hgun_ACPC2_F']]],
			[
			'heli', [
					'I_Heli_light_03_dynamicLoadout_F']
			]
		]
	]
]
