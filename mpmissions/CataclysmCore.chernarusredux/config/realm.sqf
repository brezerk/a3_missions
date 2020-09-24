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

D_INDEP_FLAG = "";

D_EAST_FLAG = "a3\data_f_exp\flags\flag_viper_co.paa";
D_WEST_FLAG = "a3\data_f_enoch\flags\flag_eaf_co.paa";
D_CIV_FLAG = "a3\data_f\flags\flag_fia_co.paa";


D_PERSISTANCE_OBJECTS = [
]; 
 
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
			],
			[
			'stash_base_items', [
				["CL_AssaultPack_01",			 4 ],
				["ACE_fieldDressing",		     7 ],
				["ACE_tourniquet",				 5 ],
				["CUP_10Rnd_762x39_SKS_M",		 12],
				["CUP_20Rnd_762x51_FNFAL_M",	 7 ],
				["CUP_5x_22_LR_17_HMR_M",	     15],
				["rvg_respirator_5",			 2 ],
				["1Rnd_HE_Grenade_shell",		 10],
				["Chemlight_red",				 10],
				["FRITH_ruin_vestia_lite_grn",	 3 ],
				["ACE_EntrenchingTool",	    	 2 ],
				["SmokeShell",					 3 ],
				["SmokeShellRed",				 5 ],
				["CUP_sgun_CZ584",	         	 3 ],
				["CUP_1Rnd_B_CZ584_74Pellets",	 7 ],
				["acc_flashlight",				 4 ],
				["CUP_1Rnd_B_CZ584_74Slug",		 13 ],
				["rvg_messengerbag_1",			 10]]
			],
			[
			'stash_random_items_common', [
				["ACE_EntrenchingTool",			 4 ],
				["rvg_flare",		    		 6 ],
				["CUP_10Rnd_762x39_SKS_M",		 11],
				["CUP_5x_22_LR_17_HMR_M",		 12],
				["SmokeShell",              	 5 ],
				["ACE_CableTie",		    	 7 ],
				["Chemlight_green",				 7 ],
				["Chemlight_red",				 3 ],
				["Chemlight_blue",				 6 ],
				["ACE_Clacker",					 5 ],
				["acc_flashlight",				 4 ],
				["CL_Axe",				         2 ],
				["CL_Meat_Raw",				     6 ],
				["ACE_SpraypaintBlue",	         2 ],
				["ACE_WaterBottle",				 6 ],
				["ACE_WaterBottle_Half",		 8 ],
				["ACE_WaterBottle_Empty",		 2 ],
				["ACE_bodyBag",				     7 ],
				["ACE_Flashlight_MX991",	     3 ],
				["ACE_Flashlight_KSF1",			 1 ],
				["CL_Meat",				         7 ],
				["CL_Matches",				     4 ],
				["ACE_DefusalKit",				 2 ],
				["ACE_rope12",				     1 ],
				["ACE_wirecutter",				 1 ],
				["ACE_Can_Spirit",				 4 ],
				["ACE_Can_Franta",				 3 ],
				["ACE_MapTools",				 1 ],
				["ACE_MRE_CreamChickenSoup",	 4 ],
				["ACE_MRE_ChickenTikkaMasala",	 2 ],
				["ACE_MRE_SteakVegetables",		 5 ],
				["ACE_MRE_ChickenHerbDumplings", 6 ],
				["ACE_MRE_BeefStew",			 3 ],
				["ACE_MRE_CreamTomatoSoup",		 5 ],
				["ACE_Humanitarian_Ration",		 4 ],
				["Binocular",	         		 3]]
			],
			[
			'stash_random_items_rare', [
				["CUP_PipeBomb_M",				 4 ],
				["CUP_optic_LeupoldMk4",		 1 ],
				["CUP_srifle_CZ550_rail",		 2 ],
				["CUP_launch_RPG18",			 1 ],
				["CL_DeconKit",				     2 ],
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
			],
			[
			'stash_random_items_medical', [
				["ACE_adenosine",				 4 ],
				["CL_AntiradinBag",				 6 ],
				["CL_Antibiotic",				 5 ],
				["CL_PainKillers",				 3 ],
				["ACE_epinephrine",	             6 ],
				["ACE_bloodIV_500",			     5 ],
				["ACE_fieldDressing",			 14],
				["ACE_morphine",	        	 10],
				["CL_Antidote",				     5 ]]
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
					["CL_AssaultPack_01",			 4 ],
					["ACE_fieldDressing",		     7 ],
					["ACE_tourniquet",				 5 ],
					["CUP_10Rnd_762x39_SKS_M",		 12],
					["CUP_20Rnd_762x51_FNFAL_M",	 7 ],
					["CUP_5x_22_LR_17_HMR_M",	     15],
					["rvg_respirator_5",			 2 ],
					["1Rnd_HE_Grenade_shell",		 10],
					["Chemlight_red",				 10],
					["FRITH_ruin_vestia_lite_grn",	 3 ],
					["ACE_EntrenchingTool",	    	 2 ],
					["SmokeShell",					 3 ],
					["SmokeShellRed",				 5 ],
					["CUP_sgun_CZ584",	         	 3 ],
					["CUP_1Rnd_B_CZ584_74Pellets",	 7 ],
					["acc_flashlight",				 4 ],
					["CUP_1Rnd_B_CZ584_74Slug",		 13 ],
					["rvg_messengerbag_1",			 10]
				]
				]
			],
			['stash_SUPPLY', [
				[
					'CUP_LocalBasicAmmunitionBox'
				],
				[
					["CL_AssaultPack_01",			 4 ],
					["ACE_fieldDressing",		     7 ],
					["ACE_tourniquet",				 5 ],
					["CUP_10Rnd_762x39_SKS_M",		 12],
					["CUP_20Rnd_762x51_FNFAL_M",	 7 ],
					["CUP_5x_22_LR_17_HMR_M",	     15],
					["rvg_respirator_5",			 2 ],
					["1Rnd_HE_Grenade_shell",		 10],
					["Chemlight_red",				 10],
					["FRITH_ruin_vestia_lite_grn",	 3 ],
					["ACE_EntrenchingTool",	    	 2 ],
					["SmokeShell",					 3 ],
					["SmokeShellRed",				 5 ],
					["CUP_sgun_CZ584",	         	 3 ],
					["CUP_1Rnd_B_CZ584_74Pellets",	 7 ],
					["acc_flashlight",				 4 ],
					["CUP_1Rnd_B_CZ584_74Slug",		 13],
					["rvg_messengerbag_1",			 10]
				]
				]
			],
			[
			'stash_base_items', [
				["CL_AssaultPack_01",			 4 ],
				["ACE_fieldDressing",		     7 ],
				["ACE_tourniquet",				 5 ],
				["CUP_10Rnd_762x39_SKS_M",		 12],
				["CUP_20Rnd_762x51_FNFAL_M",	 7 ],
				["CUP_5x_22_LR_17_HMR_M",	     15],
				["rvg_respirator_5",			 2 ],
				["1Rnd_HE_Grenade_shell",		 10],
				["Chemlight_red",				 10],
				["FRITH_ruin_vestia_lite_grn",	 3 ],
				["ACE_EntrenchingTool",	    	 2 ],
				["SmokeShell",					 3 ],
				["SmokeShellRed",				 5 ],
				["CUP_sgun_CZ584",	         	 3 ],
				["CUP_1Rnd_B_CZ584_74Pellets",	 7 ],
				["acc_flashlight",				 4 ],
				["CUP_1Rnd_B_CZ584_74Slug",		 13],
				["rvg_messengerbag_1",			 10]]
			],
			[
			'stash_random_items_common', [
				["ACE_EntrenchingTool",			 4 ],
				["rvg_flare",		    		 6 ],
				["CUP_10Rnd_762x39_SKS_M",		 11],
				["CUP_5x_22_LR_17_HMR_M",		 12],
				["SmokeShell",              	 5 ],
				["ACE_CableTie",		    	 7 ],
				["CUP_H_C_Ushanka_01",		     6 ],
				["Chemlight_green",				 7 ],
				["Chemlight_red",				 3 ],
				["Chemlight_blue",				 6 ],
				["ACE_Clacker",					 5 ],
				["acc_flashlight",				 4 ],
				["CL_Axe",				         2 ],
				["CL_Meat_Raw",				     6 ],
				["ACE_SpraypaintBlue",	         2 ],
				["ACE_WaterBottle",				 6 ],
				["CUP_H_PMC_Beanie_Khaki",		 4 ],
				["CUP_H_PMC_Beanie_Khaki",		 4 ],
				["ACE_WaterBottle_Half",		 8 ],
				["ACE_WaterBottle_Empty",		 2 ],
				["CUP_srifle_Mosin_Nagant",		 1 ],
				["CUP_5Rnd_762x54_Mosin_M",		 8 ],
				["ACE_bodyBag",				     7 ],
				["ACE_Flashlight_MX991",	     3 ],
				["ACE_Flashlight_KSF1",			 1 ],
				["CL_Meat",				         7 ],
				["CL_Matches",				     4 ],
				["ACE_DefusalKit",				 2 ],
				["ACE_rope12",				     1 ],
				["ACE_wirecutter",				 1 ],
				["ACE_Can_Spirit",				 4 ],
				["ACE_Can_Franta",				 3 ],
				["ACE_MapTools",				 1 ],
				["CL_Respirator_6",				 4 ],
				["ACE_MRE_CreamChickenSoup",	 4 ],
				["ACE_MRE_ChickenTikkaMasala",	 2 ],
				["ACE_MRE_SteakVegetables",		 5 ],
				["ACE_MRE_ChickenHerbDumplings", 6 ],
				["ACE_MRE_BeefStew",			 3 ],
				["CL_Respirator_2",			     3 ],
				["ACE_MRE_CreamTomatoSoup",		 5 ],
				["CL_TacticalPack_rgr",		     2 ],
				["ACE_Chemlight_UltraHiOrange",	 5 ],
				["ToolKit",                      2 ],
				["ACE_Humanitarian_Ration",		 4 ],
				["rvg_assault",		             4 ],
				["ChemicalDetector_01_watch_F",	 2 ],
				["CUP_H_NAPA_Fedora",		     2 ],
				["Binocular",	         		 3 ]]
			],
			[
			'stash_random_items_rare', [
				["CUP_PipeBomb_M",				 4 ],
				["CUP_arifle_M16A1",			 4 ],
				["CUP_20Rnd_556x45_Stanag",	     13],
				["CUP_sgun_M1014_solidstock",	 3 ],
				["FRITH_ruin_vestia_lite_ltr",	 3 ],
				["CUP_launch_M72A6",	         1 ],
				["CUP_8Rnd_B_Beneli_74Slug",	 14],
				["CUP_8Rnd_B_Beneli_74Pellets",	 19],
				["CUP_HandGrenade_M67",	         4 ],
				["CUP_glaunch_M79",	             1 ],
				["CUP_1Rnd_HE_M203",	         15],
				["CUP_1Rnd_StarFlare_Red_M203",	 5 ],
				["CUP_1Rnd_Smoke_M203",	         3 ],
				["CUP_srifle_M14",				 4 ],
				["10Rnd_Mk14_762x51_Mag",		 10],
				["CUP_hgun_Colt1911",		     2 ],
				["CUP_7Rnd_45ACP_1911",		     2 ],
				["CUP_optic_LeupoldMk4",		 1 ],
				["CUP_srifle_CZ550_rail",		 2 ],
				["CUP_launch_RPG18",			 1 ],
				["CUP_optic_PEM",		     	 1 ],
				["CUP_arifle_AKS",		     	 4 ],
				["CUP_launch_RPG18_Loaded",		 1 ],
				["CUP_RPG18_M",		             3 ],
				["CUP_30Rnd_762x39_AK47_M",		 14],
				["CL_DeconKit",				     2 ],
				["U_FRITH_RUIN_SDR_snip_crow",   2 ],
				["CUP_SKS",				         6 ],
				["CUP_10Rnd_762x39_SKS_M",		 14],
				["CUP_H_RUS_Altyn_khaki",		 4 ],
				["30Rnd_65x39_caseless_green",	 3 ],
				["CUP_arifle_AKS74U",	         3 ],
				["CUP_30Rnd_545x39_AK74_plum_M", 3 ],
				["10Rnd_762x54_Mag",			 7 ],
				["150Rnd_762x54_Box",			 8 ],
				["1Rnd_HE_Grenade_shell",		 7 ],
				["Chemlight_red",				 3 ],
				["acc_flashlight",				 4 ],
				["bipod_02_F_blk",				 4 ],
				["FRITH_ruin_modhat_ltr",		 4 ],
				["FRITH_ruin_vestia_lite_ghm",	 4 ],
				["CUP_arifle_AKS74_GL_Early",	 2 ],
				["CUP_30Rnd_545x39_AK_M",	     8 ],
				["CUP_1Rnd_HE_GP25_M",	         5 ],
				["CUP_hgun_Makarov",	         2 ],
				["CUP_8Rnd_9x18_Makarov_M",	     7 ],
				["CUP_arifle_SAIGA_MK03_Wood",	 3 ],
				["CUP_10Rnd_762x39_SaigaMk03_M", 9 ],
				["Mask_M40",                     2 ],
				["CL_GasMask_03",                2 ],
				["FRITH_ruin_vestiaGL_grnmtp",	 3 ],
				["rvg_assault",	                 3 ],
				["B_FieldPack_ocamo",			 3 ]]
			],
			[
			'stash_random_items_medical', [
				["ACE_adenosine",				 4 ],
				["CL_AntiradinBag",				 6 ],
				["CL_Antibiotic",				 5 ],
				["CL_PainKillers",				 3 ],
				["ACE_epinephrine",	             6 ],
				["ACE_bloodIV_500",			     5 ],
				["ACE_fieldDressing",			 14],
				["ACE_morphine",	        	 10],
				["CL_Antidote",				     5 ]]
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