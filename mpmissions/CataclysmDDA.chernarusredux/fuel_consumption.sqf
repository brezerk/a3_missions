
_lvls = [];
_lvls pushBack (0.00066314157*1.00619);
_lvls pushBack ((0.0016314157+0.00014159)/(pi*2));
_lvls pushBack ((0.0026314157+0.00025159)/(pi*2));
_lvls pushBack ((0.0036314157+0.00026159)/(pi*2));

systemChat format ["start! %1", _lvls];

while {true} do {
	_veh = vehicle player;

	if ((_veh != player) && (player == driver _veh) && (isEngineOn _veh)) then {
		_veh setFuel ((fuel _veh) - (_lvls select 0));

		if (speed _veh > 10 && speed _veh < 91) then {
			_veh setFuel ((fuel _veh) - (_lvls select 1));
		};
		if (speed _veh > 90 && speed _veh < 130) then {
			_veh setFuel ((fuel _veh) - (_lvls select 2));
		};
		if (speed _veh > 130) then {
			_veh setFuel ((fuel _veh) - (_lvls select 3));
		};
		systemChat "consumoing!";
	};
    sleep 1;
};