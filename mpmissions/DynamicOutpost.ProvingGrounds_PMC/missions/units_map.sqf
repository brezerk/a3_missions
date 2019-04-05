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

/*
Units map
*/

//$ grep type= rus_p_light_04.sqe | sed s/.*type=//g | sed 's/\;/, /g' | tr -d "\n\r"
unitsSpawnMap = [
	["rus_tank_01", [["rhs_t72bb_tv", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_arifleman", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner", "rhs_vdv_grenadier", "rhs_vdv_marksman", "rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner_assistant"], []]],
	["rus_tank_02", [["rhs_t72bd_tv", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_arifleman", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner", "rhs_vdv_grenadier", "rhs_vdv_marksman", "rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner_assistant"], []]],
	["rus_tank_03", [["rhs_t72bd_tv", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_arifleman", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner", "rhs_vdv_grenadier", "rhs_vdv_marksman", "rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner_assistant"], []]],
	["rus_zu_01", [["rhs_zsu234_aa", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_arifleman", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner", "rhs_vdv_grenadier", "rhs_vdv_marksman", "rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner_assistant"], []]],
	["rus_p_light_01", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_marksman", "rhs_vdv_LAT"], []]],
	["rus_p_light_02", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_marksman"], []]],
	["rus_p_light_03", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_LAT", "rhs_vdv_grenadier"], []]],
	["rus_p_light_04", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_LAT"], []]],
	["rus_p_light_05", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant"], []]],
	["rus_p_light_06", [["rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner_assistant", "rhs_vdv_grenadier", "rhs_vdv_marksman"], []]],
	["rus_p_med_01", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner_assistant", "rhs_vdv_grenadier", "rhs_vdv_marksman"], []]],
	["rus_p_med_02", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_marksman", "rhs_vdv_LAT", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_LAT"], []]],
	["rus_p_med_03", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_marksman", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_LAT", "rhs_vdv_grenadier"], []]],
	["rus_p_heavy_01", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_marksman", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_LAT", "rhs_vdv_grenadier", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant"], []]],
	["rus_p_heavy_02", [["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_marksman", "rhs_vdv_LAT", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_machinegunner_assistant", "rhs_vdv_LAT", "rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner_assistant", "rhs_vdv_grenadier", "rhs_vdv_marksman"], []]],
	["rus_p_spotter_01", [["rhs_vdv_recon_officer_armored", "rhs_vdv_recon_rifleman_scout_akm", "rhs_vdv_recon_rifleman_scout_akm"], []]],
	["rus_spec_01", [["rhs_msv_efreitor", "rhs_msv_rifleman", "rhs_msv_rifleman"], []]],
	["rus_spec_02", [["rhs_vdv_marksman", "rhs_vdv_marksman", "rhs_vdv_marksman", "rhs_vdv_marksman_asval", "rhs_vdv_marksman_asval", "rhs_vdv_medic", "rhs_vdv_junior_sergeant"], []]],
	["rus_spec_03", [["rhs_vdv_recon_sergeant", "rhs_vdv_recon_arifleman_scout", "rhs_vdv_recon_grenadier_scout", "rhs_vdv_recon_rifleman_scout", "rhs_vdv_recon_rifleman_scout", "rhs_vdv_recon_medic"], []]],
	["rus_spec_04", [["rhs_vdv_recon_sergeant", "rhs_vdv_recon_marksman_asval", "rhs_vdv_recon_marksman_asval", "rhs_vdv_recon_marksman_vss", "rhs_vdv_recon_marksman_vss"], []]],
	["rus_mech_light_01", [["rhs_btr70_vdv"], ["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner_assistant", "rhs_vdv_grenadier", "rhs_vdv_marksman"]]],
	["rus_mech_light_02", [["rhs_btr80_vdv"], ["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_marksman", "rhs_vdv_LAT", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_LAT"]]],
	["rus_mech_light_03", [["rhs_btr60_vdv"], ["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_marksman", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_LAT", "rhs_vdv_grenadier"]]],
	["rus_mech_light_04", [["rhs_tigr_vv"], ["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_machinegunner", "rhs_vdv_at", "rhs_vdv_strelok_rpg_assist", "rhs_msv_driver_armored", "rhs_vdv_arifleman", "rhs_vdv_arifleman"]]],
	["rus_mech_light_05", [["rhs_tigr_sts_vv"], ["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_machinegunner", "rhs_vdv_at", "rhs_vdv_strelok_rpg_assist", "rhs_msv_driver_armored", "rhs_msv_grenadier", "rhs_vdv_arifleman"]]],
	["rus_mech_light_06", [["RHS_Ural_Zu23_VDV_01"], ["rhs_vdv_junior_sergeant", "rhs_vdv_rifleman", "rhs_vdv_rifleman", "rhs_vdv_sergeant"]]],
	["rus_mech_light_07", [["rhs_gaz66_zu23_vdv"], ["rhs_vdv_rifleman", "rhs_vdv_sergeant"]]],
	["rus_mech_med_01", [["rhs_bmd2m"], ["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_junior_sergeant", "rhs_vdv_machinegunner", "rhs_vdv_machinegunner_assistant", "rhs_vdv_grenadier", "rhs_vdv_marksman"]]],
	["rus_mech_med_02", [["rhs_bmd4_vdv"], ["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_marksman", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_LAT", "rhs_vdv_grenadier"]]],
	["rus_mech_med_03", [["rhs_bmp1p_vdv"], ["rhs_vdv_sergeant", "rhs_vdv_junior_sergeant", "rhs_vdv_grenadier", "rhs_vdv_machinegunner", "rhs_vdv_at", "rhs_vdv_strelok_rpg_assist", "rhs_vdv_rifleman", "rhs_vdv_rifleman", "rhs_vdv_rifleman"]]],
	["rus_mech_med_04", [["rhs_bmp2_vdv"], ["rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_arifleman", "rhs_vdv_marksman", "rhs_vdv_sergeant", "rhs_vdv_efreitor", "rhs_vdv_arifleman", "rhs_vdv_LAT", "rhs_vdv_grenadier"]]],
	["rus_heli_01", [["RHS_Ka52_vvsc", "RHS_Ka52_vvsc", "RHS_Ka52_vvsc"], []]],
	["rus_heli_02", [["rhs_mi28n_vvsc", "rhs_mi28n_vvsc", "rhs_mi28n_vvsc"], []]],
	["rus_heli_03", [["RHS_Mi8MTV3_heavy_vvsc", "RHS_Mi8MTV3_heavy_vvsc", "RHS_Mi8MTV3_heavy_vvsc"], []]],
	["nov_p_light_01", [["LOP_US_Infantry_TL", "LOP_US_Infantry_SL", "LOP_US_Infantry_Corpsman", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_AT", "LOP_US_Infantry_AT_Asst", "LOP_US_Infantry_GL", "LOP_US_Infantry_MG"], []]],
	["nov_p_light_02", [["LOP_US_Infantry_TL", "LOP_US_Infantry_SL", "LOP_US_Infantry_Corpsman", "LOP_US_Infantry_AT", "LOP_US_Infantry_AT_Asst", "LOP_US_Infantry_MG", "LOP_US_Infantry_MG_Asst", "LOP_US_Infantry_GL_2"], []]],
	["nov_p_light_03", [["LOP_US_Infantry_TL", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_AT", "LOP_US_Infantry_SL", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3"], []]],
	["nov_p_light_04", [["LOP_US_Infantry_SL", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_SL", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_MG_2", "LOP_US_Infantry_GL"], []]],
	["nov_p_med_01", [["LOP_US_Infantry_TL", "LOP_US_Infantry_SL", "LOP_US_Infantry_Corpsman", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_AT", "LOP_US_Infantry_AT_Asst", "LOP_US_Infantry_GL", "LOP_US_Infantry_MG", "LOP_US_Infantry_TL", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_AT"], []]],
	["nov_p_med_02", [["LOP_US_Infantry_SL", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_TL", "LOP_US_Infantry_SL", "LOP_US_Infantry_Corpsman", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_AT", "LOP_US_Infantry_AT_Asst", "LOP_US_Infantry_GL", "LOP_US_Infantry_MG"], []]],
	["nov_p_med_03", [["LOP_US_Infantry_TL", "LOP_US_Infantry_SL", "LOP_US_Infantry_Corpsman", "LOP_US_Infantry_AT", "LOP_US_Infantry_AT_Asst", "LOP_US_Infantry_MG", "LOP_US_Infantry_MG_Asst", "LOP_US_Infantry_GL_2", "LOP_US_Infantry_SL", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_MG_2", "LOP_US_Infantry_GL"], []]],
	["nov_p_heavy_01", [["LOP_US_Infantry_TL", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_AT", "LOP_US_Infantry_SL", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_TL", "LOP_US_Infantry_SL", "LOP_US_Infantry_Corpsman", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_AT", "LOP_US_Infantry_AT_Asst", "LOP_US_Infantry_GL", "LOP_US_Infantry_MG", "LOP_US_Infantry_SL", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_MG_2", "LOP_US_Infantry_GL", "LOP_US_Infantry_TL", "LOP_US_Infantry_SL", "LOP_US_Infantry_Corpsman", "LOP_US_Infantry_AT", "LOP_US_Infantry_AT_Asst", "LOP_US_Infantry_MG", "LOP_US_Infantry_MG_Asst", "LOP_US_Infantry_GL_2"], []]],
	["nov_mech_heavy_01", [["LOP_US_T72BA", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_AT", "LOP_US_Infantry_MG", "LOP_US_Infantry_GL", "LOP_US_Infantry_TL"], []]],
	["nov_mech_heavy_02", [["LOP_US_T72BB", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_AT", "LOP_US_Infantry_MG", "LOP_US_Infantry_GL", "LOP_US_Infantry_TL"], []]],
	["nov_mech_med_01", [["LOP_US_BMP1"], ["LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_AT", "LOP_US_Infantry_MG", "LOP_US_Infantry_GL", "LOP_US_Infantry_TL"]]],
	["nov_mech_med_02", [["LOP_US_BMP2"], ["LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_AT", "LOP_US_Infantry_MG", "LOP_US_Infantry_GL", "LOP_US_Infantry_TL"]]],
	["nov_mech_light_01", [["LOP_US_BTR60"], ["LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_AT", "LOP_US_Infantry_MG", "LOP_US_Infantry_GL", "LOP_US_Infantry_TL"]]],
	["nov_mech_light_02", [["LOP_US_BTR70"], ["LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_Rifleman_3", "LOP_US_Infantry_Rifleman", "LOP_US_Infantry_Rifleman_4", "LOP_US_Infantry_Rifleman_2", "LOP_US_Infantry_AT", "LOP_US_Infantry_MG", "LOP_US_Infantry_GL", "LOP_US_Infantry_TL"]]]
];