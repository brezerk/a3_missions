// by ALIAS

if (!isServer) exitWith {};
params ["_gren"];

while {alive _gren} do 
{
	_ck_hiv = (position _gren) nearEntities ["C_Soldier_VR_F",7];
	if (count _ck_hiv >0) then {{if (!isNil{_x getVariable "isHive"}) then {_x setDamage 1; [[_x],"AL_swarmer\al_hive_dead_SFX.sqf"] remoteExec ["execVM"]}} foreach _ck_hiv};
	sleep 2;
}