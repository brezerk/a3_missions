
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
			
player forceAddUniform "CUP_U_B_FR_DirAction";
player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 3 do {player addItemToUniform "ACE_CableTie";};
for "_i" from 1 to 5 do {player addItemToUniform "ACE_morphine";};
for "_i" from 1 to 15 do {player addItemToUniform "ACE_fieldDressing";};

player addVest "CUP_V_B_RRV_DA1";
for "_i" from 1 to 2 do {player addItemToVest "CUP_7Rnd_45ACP_1911";};
for "_i" from 1 to 3 do {player addItemToVest "CUP_30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {player addItemToVest "CUP_HandGrenade_M67";};
for "_i" from 1 to 2 do {player addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {player addItemToVest "Chemlight_red";};
for "_i" from 1 to 3 do {player addItemToVest "SmokeShellRed";};

player addItemToVest "ACE_Canteen";
			
player addBackpack "B_Parachute";
			
player addWeapon "CUP_hgun_Colt1911";

//ACEX
player addHeadgear "CUP_H_FR_ECH";	
player addGoggles "CUP_G_Oakleys_Clr";
			
player linkItem "ItemMap";
player linkItem "ItemWatch";
			
player setSpeaker "NoVoice";

player action ["openParachute", player];
