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

 
D_HOSPITAL_LCS = [
	[8636.66,13431.1,-4.14808],
	[10481.5,2358.45,-4.05859],
	[11386.4,13957.7,-4.20499],
	[3803.84,8924.72,0.00271606],
	[12742.6,9593.55,9.53674e-007],
	[4620.18,2444,0.18921]
];

D_FRACTION_INDEP_CFG = [
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
			]
		]
	],
	[
		'CL_I_CR_Bandits', 'Cataclysm Bandits', [
			['garrison', [
					'CL_I_CR_Bandits_Soldier_F',
					'CL_I_CR_Bandits_Soldier_Light_F',
					'CL_I_CR_Bandits_Soldier_AT_F',
					'CL_I_CR_Bandits_Medic_F',
					'CL_I_CR_Bandits_Hunter_F']
			],
			['patrol', [
					'CL_I_CR_Bandits_Soldier_F',
					'CL_I_CR_Bandits_Soldier_Light_F',
					'CL_I_CR_Bandits_Medic_F']
			],
			['light', [
					'CUP_I_Datsun_PK',
					'CUP_I_Datsun_PK_Random']
			],
			['stash_WEAPON', [
				[
					'CUP_LocalBasicAmmunitionBox'
				],
				[
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
				]
			],
			['stash_SUPPLY', [
				[
					'CUP_LocalBasicAmmunitionBox'
				],
				[
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
				]
			]
		]
	]
];

D_FRACTION_WEST_CFG = [
	[
		'BLU_F', 'NATO', [
			[
			'garrison', [
					'B_Soldier_LAT_F',
					'B_Soldier_SL_F',
					'B_Soldier_AR_F',
					'B_Soldier_GL_F',
					'B_sniper_F']
			],
			[
			'patrol', [
					'B_Soldier_LAT_F',
					'B_Soldier_GL_F',
					'B_medic_F']
			],
			[
			'transport', ['B_T_VTOL_01_infantry_F']  
			],
			[
			'heli', ['B_Heli_Light_01_F']
			],
			[
			'boats', ['B_Boat_Armed_01_minigun_F']
			],
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
			]
		]
	]
];
D_FRACTION_EAST_CFG = [
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
			'transport', [
					'O_Truck_03_transport_F',
					'O_Truck_03_covered_F',
					'O_Truck_02_transport_F',
					'O_Truck_02_covered_F']
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

D_FRACTION_CIV_CFG = [
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
			]
		]
	]
];