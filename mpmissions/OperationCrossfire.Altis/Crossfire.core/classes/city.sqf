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

CLASS("CityInfo")
	PRIVATE VARIABLE("string","cityName");
	PRIVATE VARIABLE("array" , "cityPos");
	PRIVATE VARIABLE("scalar", "citySize");
	PRIVATE VARIABLE("side", "citySide");
	PRIVATE VARIABLE("string", "cityMarker");
	PRIVATE VARIABLE("scalar", "influenceWest");
	PRIVATE VARIABLE("scalar", "influenceEast");
	PRIVATE VARIABLE("scalar", "influenceGuer");
	PRIVATE VARIABLE("scalar", "demandSupplyProvision");
	PRIVATE VARIABLE("scalar", "demandSupplyGoods");
	PRIVATE VARIABLE("scalar", "demandSupplyMed");
	PRIVATE VARIABLE("scalar", "cityPopulation");
	PRIVATE VARIABLE("array" , "cityBuildings");
	//Constructor
	PUBLIC FUNCTION("array", "constructor") {
		MEMBER("cityName", 				(_this select 0));
		MEMBER("cityPos", 				(_this select 1));
		private _size = 100;
		private _size_x = ((_this select 2) select 0);
		private _size_y = ((_this select 2) select 1);
		if ((_size_x > 100) && (_size_x > _size_y)) then {
			_size = _size_x;
		};
		if ((_size_y > 100) && (_size_y > _size_x)) then {
			_size = _size_y;
		};
		MEMBER("citySize", 				_size);
		MEMBER("citySide", 				civilian);
		MEMBER("influenceWest",			0);
		MEMBER("influenceEast", 		0);
		MEMBER("influenceGuer", 		0);
		MEMBER("demandSupplyProvision", 0);
		MEMBER("demandSupplyGoods",     0);
		MEMBER("demandSupplyMed",       0);
		MEMBER("cityPopulation",        0);
		MEMBER("cityBuildings",         []);
		private _marker = createMarker [format ["mrk_city_%1", (_this select 0)], (_this select 1)];
		_marker setMarkerType "u_installation";
		_marker setMarkerColor "ColorWhite";
		_marker setMarkerAlpha 1;
		MEMBER("cityMarker", _marker);
	};
	PUBLIC FUNCTION("","getSide") {
		MEMBER("citySide", nil);
	};
	PUBLIC FUNCTION("side","setSide") {
		MEMBER("citySide",_this);
		private _marker = MEMBER("cityMarker", nil);
		switch(_this) do {
			case west: {
				MEMBER("influenceWest", 100);
				MEMBER("influenceEast", -25);
				MEMBER("influenceGuer", -25);
				_marker setMarkerColor "ColorWEST";
			};
			case east: {
				MEMBER("influenceWest", -25);
				MEMBER("influenceEast", 100);
				MEMBER("influenceGuer", -25);
				_marker setMarkerColor "ColorEAST";
			};
			case resistance: {
				MEMBER("influenceWest", -25);
				MEMBER("influenceEast", -25);
				MEMBER("influenceGuer", 100);
				_marker setMarkerColor "ColorGUER";
			};
			default {
				MEMBER("influenceWest", -25);
				MEMBER("influenceEast", -25);
				MEMBER("influenceGuer", 0);
				_marker setMarkerColor "ColorWhite";
			};
		};
	};
	PUBLIC FUNCTION("string", "deconstructor") {
		DELETE_VARIABLE("cityName");
		DELETE_VARIABLE("array" , "cityPos");
		DELETE_VARIABLE("scalar", "citySize");
		DELETE_VARIABLE("object", "citySide");
		DELETE_VARIABLE("object", "cityMarker");
		DELETE_VARIABLE("scalar", "influenceWest");
		DELETE_VARIABLE("scalar", "influenceEast");
		DELETE_VARIABLE("scalar", "influenceGuer");
		DELETE_VARIABLE("scalar", "demandSupplyProvision");
		DELETE_VARIABLE("scalar", "demandSupplyGoods");
		DELETE_VARIABLE("scalar", "demandSupplyMed");
		DELETE_VARIABLE("scalar", "cityPopulation");
		DELETE_VARIABLE("array" , "cityBuildings");
		hint _this;
	};
ENDCLASS;