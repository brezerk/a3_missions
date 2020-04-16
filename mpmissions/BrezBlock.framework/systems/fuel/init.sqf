
_lvls = [];
_lvls pushBack (0.0000193141);
_lvls pushBack (0.0001931415);
_lvls pushBack (0.0002931415);
_lvls pushBack (0.0003931415);

//_lvls pushBack (0.00066314157*1.00619);
//_lvls pushBack ((0.0016314157+0.00014159)/(pi*2));
//_lvls pushBack ((0.0026314157+0.00025159)/(pi*2));
//_lvls pushBack ((0.0036314157+0.00026159)/(pi*2));

//systemChat format ["start! %1", _lvls];

while {true} do {
	_veh = vehicle player;
	if ((_veh != player) && (player == driver _veh) && (isEngineOn _veh)) then {
		_mass = getMass _veh;
		_amount_f = 0;
		_speed = speed _veh;
		if (_speed <= 10) then {
			_amount_f = (_lvls select 0) + (_mass / 100000000);
		} else {
			if (_speed > 10 && _speed < 91) then {
				_amount_f = (_lvls select 1) + (_mass / 100000000);
			} else {
				if (_speed > 90 && _speed < 130) then {
					_amount_f = (_lvls select 2) + (_mass / 100000000);
				} else {
					if (_speed > 130) then {
						_amount_f = (_lvls select 3) + (_mass / 100000000);
					};
				};
			};
		};
		[_veh, ((fuel _veh) - _amount_f)] remoteExec ['setFuel', _veh];
		//systemChat format ["consumoing! %1", _amount_f];
	};
    sleep 1;
};
