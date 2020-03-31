
_this setVariable ["fuel_capacity", 0];
[_this, true, [0, 2, 0.5], 10] call ace_dragging_fnc_setCarryable;

_insertChildren = {
    params ["_target", "_player", "_params"];
    private _actions = [];
    {
        private _childStatement = {
			params ["_target", "_player", "_params"];
			[_target, _params] execVM "refuel_action.sqf";
		};
		_displayName = getText (configFile >>  "CfgVehicles" >> (typeOf _x) >> "displayName");
		_displayIcon = getText (configfile >> "CfgVehicles" >> (typeOf _x) >> "icon");
		_vehicle = _x;
        private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _target]; 
    } forEach (nearestObjects [_player, ["Car", "Tank", "Truck"], 10]);
    _actions
};

_action = [
	"bb_interact_refuel",
	"Заправити",
    "addons\ace\ui\icon_refuel_interact.paa", //"\ace_refuel\ui\icon_refuel_interact.paa",ace_medical.pbo\ui\icons\medical_cross.paa
	{},
	{true},
	_insertChildren,
	[],
	"",
	5,
	[true, false, false, true, false],
	{}
] call ace_interact_menu_fnc_createAction;

[_this, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_insertChildren = {
    params ["_target", "_player", "_params"];
    private _actions = [];
    {
        private _childStatement = {
			params ["_target", "_player", "_params"];
			[_target, _params] execVM "defuel_action.sqf";
		};
		_displayName = getText (configFile >>  "CfgVehicles" >> (typeOf _x) >> "displayName");
		_displayIcon = getText (configfile >> "CfgVehicles" >> (typeOf _x) >> "icon");
		_vehicle = _x;
        private _action = [_displayName, _displayName, _displayIcon, _childStatement, {true}, {}, _vehicle] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _target]; 
    } forEach (nearestObjects [_player, ["Car", "Tank", "Truck"], 10]);
    _actions
};

_action = [
	"bb_interact_defuel",
	"Злити пальне",
    "addons\ace\ui\icon_refuel_interact.paa", //"\ace_refuel\ui\icon_refuel_interact.paa",ace_medical.pbo\ui\icons\medical_cross.paa
	{},
	{true},
	_insertChildren,
	[],
	"",
	5,
	[true, false, false, true, false],
	{}
] call ace_interact_menu_fnc_createAction;

[_this, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;