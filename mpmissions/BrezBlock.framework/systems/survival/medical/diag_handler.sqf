/***************************************************************************
 *   Copyright (C) 2008-2019 by Oleksii S. Malakhov <brezerk@gmail.com>    *
 *                                                                         *
 *   This program is free software: you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation, either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 ***************************************************************************/
  
_clientID = _this select 0;

//systemChat "i was called!";

_response = "";

if (bb_srv_dmg_chem > 0) then {
	_response = " Має симптоми хімічного отруєння.";
};

if (bb_srv_dmg_rad > 0) then {
	_response = _response + " Має симптоми радіаційного ураження.";
};

if (bb_srv_dmg_bac > 0) then {
	_response = _response + " Має симптоми респираторної хвороби.";
};


if (_response == "") then {
	_response = "виглядає Здоровим.";
};

_response = format ["%1: %2", name player, _response];

[_response] remoteExec["BrezBlock_fnc_callback_diag", _clientID];
