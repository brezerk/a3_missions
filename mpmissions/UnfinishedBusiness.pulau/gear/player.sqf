
comment "Exported from Arsenal by brezerk";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local player) exitWith {};

//remove everything
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
			
player forceAddUniform "rhs_uniform_FROG01_wd";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 3 do {player addItemToUniform "ACE_CableTie";};
for "_i" from 1 to 5 do {player addItemToUniform "ACE_morphine";};
for "_i" from 1 to 15 do {player addItemToUniform "ACE_fieldDressing";};

player addVest "rhsusf_spc_teamleader";
for "_i" from 1 to 2 do {player addItemToVest "rhsusf_mag_7x45acp_MHP";};
for "_i" from 1 to 3 do {player addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 2 do {player addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {player addItemToVest "Chemlight_red";};
for "_i" from 1 to 3 do {player addItemToVest "SmokeShellRed";};

player addItemToVest "ACE_Canteen";
			
player addBackpack "B_Parachute";
			
player addWeapon "rhsusf_weap_m1911a1";

//ACEX
player addHeadgear "rhsusf_lwh_helmet_marpatwd";	
player addGoggles "rhs_googles_clear";
			
player linkItem "ItemMap";
player linkItem "ItemWatch";
			
player setSpeaker "NoVoice";

player action ["openParachute", player];
