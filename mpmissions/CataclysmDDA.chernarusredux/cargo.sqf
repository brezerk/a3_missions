
_this setVariable ["loaded", false];
_this setVariable ["place", -1];

_insertChildren = {
    params ["_target", "_player", "_params"];
    private _actions = [];
    {
        private _childStatement = {
			params ["_target", "_player", "_params"];
			[_target, _params] execVM "cargo_actions.sqf";
		};
		_displayName = getText (configFile >>  "CfgVehicles" >> (typeOf _x) >> "displayName");
		_displayIcon = getText (configfile >> "CfgVehicles" >> (typeOf _x) >> "icon");
		_vehicle = _x;
        private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _target]; 
    } forEach (nearestObjects [_player, ["CUP_C_V3S_Open_TKC"], 10]);
    _actions
};

_action = [
	"bb_interact_cargo_load",
	"Завантажити",
    "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa", //"\ace_refuel\ui\icon_refuel_interact.paa",ace_medical.pbo\ui\icons\medical_cross.paa
	{},
	{(!(_target getVariable['loaded', false]) && (isNull attachedTo _target))},
	_insertChildren,
	[],
	"",
	5,
	[false, false, false, true, false],
	{}
] call ace_interact_menu_fnc_createAction;

[_this, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = [
	"bb_interact_cargo_unload",
	"Розвантажити",
    "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa", //"\ace_refuel\ui\icon_refuel_interact.paa",ace_medical.pbo\ui\icons\medical_cross.paa
	{
		params ["_target", "_player", "_params"];
		[_target, _params] execVM "cargo_unload.sqf";
	},
	{(_target getVariable['loaded', false])},
	{},
	[],
	"",
	5,
	[false, false, false, false, false],
	{}
] call ace_interact_menu_fnc_createAction;

[_this, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;


/*
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
	"",
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
];*/

//systemChat format["f%1", (count attachedObjects player)];

//_this addAction ["", {params ["_target"]; [_target] call Fn_UnLoadSupply;}];
//_this addAction ["Нести", {params ["_target"]; [_target] call Fn_DragSupply;}];
//_this addAction ["Покласти", {params ["_target"]; [_target] call Fn_DropSupply;}];