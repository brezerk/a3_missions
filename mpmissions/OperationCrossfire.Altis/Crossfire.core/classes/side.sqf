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

CLASS("SideInfo")
	PRIVATE VARIABLE("side",   "side");
	PRIVATE VARIABLE("scalar", "money");
	PRIVATE VARIABLE("scalar", "ammo");
	PRIVATE VARIABLE("scalar", "fuel");
	PRIVATE VARIABLE("scalar", "food");
	PRIVATE VARIABLE("scalar", "medicine");
	PRIVATE VARIABLE("scalar", "resources");
	PRIVATE VARIABLE("array",  "scouts");
	PRIVATE VARIABLE("array",  "roadblocks");
	PRIVATE VARIABLE("array",  "cities");
	PRIVATE VARIABLE("array" , "buildings");
	//Constructor
	PUBLIC FUNCTION("side", "constructor") {
		MEMBER("side", _this);
		MEMBER("money",			     1000);
		MEMBER("ammo",          	  100);
		MEMBER("fuel",                100);
		MEMBER("food",                100);
		MEMBER("medicine",             50);
		MEMBER("resources",            50);
		MEMBER("scouts",               []);
		MEMBER("roadblocks",           []);
		MEMBER("cities",               []);
		MEMBER("buildings",            []);
	};
	PUBLIC FUNCTION("","getMoney") {
		MEMBER("money", nil);
	};
	PUBLIC FUNCTION("","getAmmo") {
		MEMBER("ammo", nil);
	};
	PUBLIC FUNCTION("","getFuel") {
		MEMBER("fuel", nil);
	};
	PUBLIC FUNCTION("","getFood") {
		MEMBER("food", nil);
	};
	PUBLIC FUNCTION("","getMedicine") {
		MEMBER("medicine", nil);
	};
	PUBLIC FUNCTION("","getResources") {
		MEMBER("resources", nil);
	};
	PUBLIC FUNCTION("","getScouts") {
		MEMBER("scouts", nil);
	};
	PUBLIC FUNCTION("","getRoadblocks") {
		MEMBER("roadblocks", nil);
	};
	PUBLIC FUNCTION("","getCities") {
		MEMBER("cities", nil);
	};
	PUBLIC FUNCTION("","getBuildings") {
		MEMBER("buildings", nil);
	};
	PUBLIC FUNCTION("scalar","consumeMoney") {
		private _amount = _this;
		private _ret = false;
		if (MEMBER("money", nil) >= _amount) then {
			MEMBER("money", (MEMBER("money", nil) - _amount));
			_ret = true;
		};
		_ret;
	};
	PUBLIC FUNCTION("scalar","consumeAmmo") {
		private _amount = _this;
		private _ret = false;
		if (MEMBER("ammo", nil) >= _amount) then {
			MEMBER("ammo", (MEMBER("ammo", nil) - _amount));
			_ret = true;
		};
		_ret;
	};
	PUBLIC FUNCTION("string", "deconstructor") {
		DELETE_VARIABLE("side");
		DELETE_VARIABLE("scalar" , "money");
		DELETE_VARIABLE("scalar", "ammo");
		DELETE_VARIABLE("scalar", "fuel");
		DELETE_VARIABLE("scalar", "food");
		DELETE_VARIABLE("scalar", "medicine");
		DELETE_VARIABLE("scalar", "resources");
		DELETE_VARIABLE("array", "scouts");
		DELETE_VARIABLE("array", "roadblocks");
		DELETE_VARIABLE("array", "cities");
		DELETE_VARIABLE("array", "buildings");
		hint _this;
	};
ENDCLASS;