

if (!isServer) exitWith {};

resistance setFriend [civilian, 0];
civilian setFriend [resistance, 0];


/*

{
	private _side = side _x;
	private _role = typeOf _x;
	if (_side == independent) then {
		//_role = _role splitString "@" select 0;
		_x call compile preprocessFileLineNumbers (format ["gear\%1_%2.sqf", _side, _role]);
	};
	//_x addRating -9000;
} count (allUnits - switchableUnits - allCurators - playableUnits);

*/