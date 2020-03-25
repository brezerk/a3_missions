
_this setVariable ["loaded", false];
_this setVariable ["dragged", false];
_this setVariable ["place", -1];

[_this, 0, ["ACE_MainActions", "ACTION"]] call ace_interact_menu_fnc_removeActionFromObject;

_this addAction [
	"Завантажити",
	{
		params ["_target"];
		[_target] execVM "cargo_actions.sqf";
	},
	[],
	1.5,
	true,
	true,
	"",
	"(!(_target getVariable['loaded', false]) && (isNull attachedTo _target))",
	5,
	false,
	"",
	""
];
_this addAction [
	"Розвантажити",
	{
		params ["_target"];
		[_target] execVM "cargo_unload.sqf";
	},
	[],
	1.5,
	true,
	true,
	"",
	"(_target getVariable['loaded', false])",
	5,
	false,
	"",
	""
];
_this addAction [
	"Покласти",
	{
		params ["_target"];
		detach _target;
		_target enableSimulation true;
		_target allowDamage true;
	},
	[],
	1.5,
	true,
	true,
	"",
	"(!(_target getVariable['loaded', false]) && (!isNull attachedTo _target))",
	5,
	false,
	"",
	""
];
_this addAction [
	"Нести",
	{
		params ["_target"];
		_target enableSimulation false;
		_target allowDamage false;
		_target attachTo [player, [0, 1.9, 1.0]];
	},
	[],
	1.5,
	true,
	true,
	"",
	"(!(_target getVariable['loaded', false]) && (isNull attachedTo _target))",
	5,
	false,
	"",
	""
];

systemChat format["f%1", (count attachedObjects player)]

//_this addAction ["", {params ["_target"]; [_target] call Fn_UnLoadSupply;}];
//_this addAction ["Нести", {params ["_target"]; [_target] call Fn_DragSupply;}];
//_this addAction ["Покласти", {params ["_target"]; [_target] call Fn_DropSupply;}];