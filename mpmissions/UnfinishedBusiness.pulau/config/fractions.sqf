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
		'CUP_B_USMC', 'CUP Civilian', []
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
			['Team Leader', 'B_Soldier_TL_F'],
			['Corpsman', 	'B_medic_F'],
			['Grenadier', 	'B_Soldier_GL_F'],
			['Rifleman', 	'B_Soldier_F'],
			['Squad Leader','B_Soldier_SL_F'],
			['Autorifleman','B_Soldier_AR_F'],
			['Sniper', 		'B_sniper_F'],
			['Spotter', 	'B_spotter_F']
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
		'CIV_F', 'CUP Civilian', [
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
						'C_Truck_02_covered_F']
				],
				[
				'boats', [
						'C_Boat_Civil_01_F',
						'C_Rubberboat',
						'C_Boat_Civil_01_rescue_F']
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
			]
		]
	],
	[
		'OPF_F', 'CSAT', [
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
			]
		]
	]
]