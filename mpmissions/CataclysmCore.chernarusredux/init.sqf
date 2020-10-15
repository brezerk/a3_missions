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
 
 

 /*
 waitUntil {!isNil "D_HOSPITAL_LCS"};
 
 systemChat str D_HOSPITAL_LCS;
 
 {
	private _marker = createMarker [(format ["mrk_hospital_%1", _forEachIndex]), _x];
	_marker setMarkerType "flag_UN";
 } forEach D_HOSPITAL_LCS;
*/


east_base_built = 0;
west_base_built = 0;

//resistance setFriend [civilian, 0];
//civilian setFriend [resistance, 0];

if (isServer) then {

	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		tf_give_personal_radio_to_regular_soldier = true;
		publicVariable "tf_give_personal_radio_to_regular_soldier";
		
		tf_no_auto_long_range_radio = true;
		publicVariable "tf_no_auto_long_range_radio";

		tf_same_sw_frequencies_for_side = true;
		publicVariable "tf_same_sw_frequencies_for_side";
		
		private _settingsSwWest = false call TFAR_fnc_generateSwSettings;
		_settingsSwWest set [2, ["311","312","313","314","315","316","317","318"]];
		tf_freq_west = _settingsSwWest;
		publicVariable "tf_freq_west";
		
		private _settingsSwEast = false call TFAR_fnc_generateSwSettings;
		_settingsSwEast set [2, ["101","110","117","134","195","131","171","188"]];
		tf_freq_east = _settingsSwEast;
		publicVariable "tf_freq_east";
	};
	
	[west, 35] call BIS_fnc_respawnTickets;
	[east, 35] call BIS_fnc_respawnTickets;
	[independent, 16] call BIS_fnc_respawnTickets;
	
	publicVariable "base_built"; 
	
	waitUntil { time > 5 };
	
	
	//start west
	box_west_01 addItemCargo ["ACE_MRE_ChickenTikkaMasala", 25];
	box_west_01 addItemCargo ["ACE_Canteen", 25];
	box_west_01 addItemCargo ["ACE_EntrenchingTool", 5];
	box_west_01 addItemCargo ["CL_FuelHose", 2];
	box_west_01 addItemCargo ["ChemicalDetector_01_watch_F", 15];
	box_west_01 addItemCargo ["CL_Axe", 3];
	box_west_01 addMagazineCargo ["CL_Matches", 5];
	box_west_01 addItemCargo ["CL_GasMask_03", 15];
	box_west_01 addItemCargo ["ToolKit", 1];
	box_west_01 addItemCargo ["ACE_DefusalKit", 2];
	box_west_01 addWeaponCargo ["ACE_VMH3", 2];
	box_west_01 addWeaponCargo ["ACE_Flashlight_Maglite_ML300L", 25];
	box_west_01 addItemCargo ["ACE_MapTools", 5];
	box_west_01 addItemCargo ["ACE_fieldDressing", 25];
	box_west_01 addItemCargo ["ACE_tourniquet", 10];
	box_west_01 addItemCargo ["ACE_bloodIV_500", 10];
	box_west_01 addItemCargo ["ACE_morphine", 10];
	box_west_01 addItemCargo ["ACE_adenosine", 10];
	box_west_01 addItemCargo ["ACE_personalAidKit", 5];
	box_west_01 addItemCargo ["CL_AntiradinBag", 15];
	box_west_01 addItemCargo ["CL_Antidote", 15];
	box_west_01 addMagazineCargo ["CL_Matches", 5];
	box_west_01 addMagazineCargo ["CL_Antibiotic", 5];
	box_west_01 addMagazineCargo ["CL_PainKillers", 7];
	box_west_01 addMagazineCargo ["CUP_8Rnd_9x18_Makarov_M", 15];
	box_west_01 addMagazineCargo ["CL_Rounds_CUP_B_9x18_Ball", 100];
	box_west_01 addItemCargo ["CUP_HandGrenade_RGD5", 8];
	box_west_01 addItemCargo ["SmokeShell", 25];
	box_west_01 addItemCargo ["SmokeShellRed", 10];
	box_west_01 addItemCargo ["SmokeShellYellow", 10];
	
	//extra
	box_west_01 addItemCargo ["ACE_EntrenchingTool", 4];
	box_west_01 addItemCargo ["ChemicalDetector_01_watch_F", 8];
	box_west_01 addItemCargo ["CL_GasMask_03", 10];
	box_west_01 addWeaponCargo ["Binocular", 10];
	box_west_01 addItemCargo ["ACE_fieldDressing", 25];
	box_west_01 addItemCargo ["ACE_tourniquet", 5];
	box_west_01 addItemCargo ["ACE_bloodIV_500", 5];
	box_west_01 addItemCargo ["CL_AntiradinBag", 10];
	box_west_01 addItemCargo ["CL_Antidote", 20];
	box_west_01 addItemCargo ["APERSTripMine_Wire_Mag", 3];
	box_west_01 addWeaponCargo ["CUP_arifle_L85A2", 15];
	box_west_01 addMagazineCargo ["CUP_20Rnd_556x45_Stanag", 40];
	box_west_01 addMagazineCargo ["CL_Rounds_B_556x45_Ball_Tracer_Red", 172];

	//start east
	box_east_01 addItemCargo ["ACE_MRE_ChickenTikkaMasala", 25];
	box_east_01 addItemCargo ["ACE_Canteen", 25];
	box_east_01 addItemCargo ["ACE_EntrenchingTool", 5];
	box_east_01 addItemCargo ["CL_FuelHose", 2];
	box_east_01 addItemCargo ["ChemicalDetector_01_watch_F", 15];
	box_east_01 addItemCargo ["CL_Axe", 3];
	box_east_01 addMagazineCargo ["CL_Matches", 5];
	box_east_01 addItemCargo ["CL_GasMask_03", 15];
	box_east_01 addItemCargo ["ToolKit", 1];
	box_east_01 addItemCargo ["ACE_DefusalKit", 2];
	box_east_01 addWeaponCargo ["ACE_VMH3", 2];
	box_east_01 addWeaponCargo ["ACE_Flashlight_Maglite_ML300L", 25];
	box_east_01 addItemCargo ["ACE_MapTools", 5];
	box_east_01 addItemCargo ["ACE_fieldDressing", 25];
	box_east_01 addItemCargo ["ACE_tourniquet", 10];
	box_east_01 addItemCargo ["ACE_bloodIV_500", 10];
	box_east_01 addItemCargo ["ACE_morphine", 10];
	box_east_01 addItemCargo ["ACE_adenosine", 10];
	box_east_01 addItemCargo ["ACE_personalAidKit", 5];
	box_east_01 addItemCargo ["CL_AntiradinBag", 15];
	box_east_01 addItemCargo ["CL_Antidote", 15];
	box_east_01 addMagazineCargo ["CL_Matches", 5];
	box_east_01 addMagazineCargo ["CL_Antibiotic", 5];
	box_east_01 addMagazineCargo ["CL_PainKillers", 7];
	box_east_01 addMagazineCargo ["CUP_8Rnd_9x18_Makarov_M", 15];
	box_east_01 addMagazineCargo ["CL_Rounds_CUP_B_9x18_Ball", 100];
	box_east_01 addItemCargo ["CUP_HandGrenade_RGD5", 8];
	box_east_01 addItemCargo ["SmokeShell", 25];
	box_east_01 addItemCargo ["SmokeShellRed", 10];
	box_east_01 addItemCargo ["SmokeShellYellow", 10];
	
	//extra
	box_east_01 addItemCargo ["ACE_fieldDressing", 41];
	box_east_01 addItemCargo ["FRITH_ruin_vestia_lite_ltr", 20];
	box_east_01 addWeaponCargo ["CUP_arifle_AKS74_Early", 20];
	box_east_01 addMagazineCargo ["CUP_20Rnd_545x39_AKSU_M", 60];
	box_east_01 addMagazineCargo ["CL_Rounds_CUP_B_545x39_Ball", 240];
	
	setTimeMultiplier 6;
	
	bb_threat_chem_areas pushBack [obj_target_x25, D_THREAT_CHEM_LOCAL, 140, 0.0003];
	publicVariable "bb_threat_chem_areas";
	
//	[civilian, 50] call BIS_fnc_respawnTickets;
//	[independent, 50] call BIS_fnc_respawnTickets;
};
