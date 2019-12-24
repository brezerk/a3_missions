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
	PRIVATE VARIABLE("scalar", "income_money");
	PRIVATE VARIABLE("scalar", "income_ammo");
	PRIVATE VARIABLE("scalar", "income_fuel");
	PRIVATE VARIABLE("scalar", "income_food");
	PRIVATE VARIABLE("scalar", "income_medicine");
	PRIVATE VARIABLE("scalar", "income_resources");
	PRIVATE VARIABLE("scalar", "max_scouts");
	PRIVATE VARIABLE("scalar", "max_roadblocks");
	//Constructor
	PUBLIC FUNCTION("side", "constructor") {
		private _side = createCenter _this;
		MEMBER("side", _side);
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
		MEMBER("income_money",		    0);
		MEMBER("income_ammo",		    0);
		MEMBER("income_fuel",		    0);
		MEMBER("income_food",		    0);
		MEMBER("income_medicine",	    0);
		MEMBER("income_resources",	    0);
		MEMBER("max_scouts",            4);
		MEMBER("max_roadblocks",        4);
	};
	PUBLIC FUNCTION("","pushSideUpdate") {
		private _side = MEMBER("side", nil);
		private _side_counts = [
				MEMBER("money", nil),
				MEMBER("ammo", nil),
				MEMBER("fuel", nil),
				MEMBER("medicine", nil),
				MEMBER("resources", nil),
				MEMBER("scouts", nil)
		];
		switch(_side) do {
			case west: {
				{
					WEST_SIDE_COUNTS = _side_counts;
					(owner _x) publicVariableClient "WEST_SIDE_COUNTS";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case east: {
				{
					EAST_SIDE_COUNTS = _side_counts;
					(owner _x) publicVariableClient "EAST_SIDE_COUNTS";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case resistance: {
				{
					GUER_SIDE_COUNTS = _side_counts;
					(owner _x) publicVariableClient "GUER_SIDE_COUNTS";
				} forEach (playableUnits select {(side _x) == _side});
			};
			default {
				{
					CIV_SIDE_COUNTS = _side_counts;
					(owner _x) publicVariableClient "CIV_SIDE_COUNTS";
				} forEach (playableUnits select {(side _x) == _side});
			};
		};
	};
	PUBLIC FUNCTION("","pushMoneyUpdate") {
		private _side = MEMBER("side", nil); 
		switch(_side) do {
			case west: {
				{
					WEST_MONEY_COUNT = MEMBER("money", nil);
					(owner _x) publicVariableClient "WEST_MONEY_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case east: {
				{
					EAST_MONEY_COUNT = MEMBER("money", nil);
					(owner _x) publicVariableClient "EAST_MONEY_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case resistance: {
				{
					GUER_MONEY_COUNT = MEMBER("money", nil);
					(owner _x) publicVariableClient "GUER_MONEY_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			default {
				{
					CIV_MONEY_COUNT = MEMBER("money", nil);
					(owner _x) publicVariableClient "CIV_MONEY_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
		};
	};
	PUBLIC FUNCTION("","pushAmmoUpdate") {
		private _side = MEMBER("side", nil); 
		switch(_side) do {
			case west: {
				{
					WEST_AMMO_COUNT = MEMBER("ammo", nil);
					(owner _x) publicVariableClient "WEST_AMMO_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case east: {
				{
					EAST_AMMO_COUNT = MEMBER("ammo", nil);
					(owner _x) publicVariableClient "EAST_AMMO_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case resistance: {
				{
					GUER_AMMO_COUNT = MEMBER("ammo", nil);
					(owner _x) publicVariableClient "GUER_AMMO_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			default {
				{
					CIV_AMMO_COUNT = MEMBER("ammo", nil);
					(owner _x) publicVariableClient "CIV_AMMO_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
		};
	};
	PUBLIC FUNCTION("","pushFuelUpdate") {
		private _side = MEMBER("side", nil); 
		switch(_side) do {
			case west: {
				{
					WEST_FUEL_COUNT = MEMBER("fuel", nil);
					(owner _x) publicVariableClient "WEST_FUEL_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case east: {
				{
					EAST_FUEL_COUNT = MEMBER("fuel", nil);
					(owner _x) publicVariableClient "EAST_FUEL_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case resistance: {
				{
					GUER_FUEL_COUNT = MEMBER("fuel", nil);
					(owner _x) publicVariableClient "GUER_FUEL_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			default {
				{
					CIV_FUEL_COUNT = MEMBER("fuel", nil);
					(owner _x) publicVariableClient "CIV_FUEL_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
		};
	};
	PUBLIC FUNCTION("","pushFoodUpdate") {
		private _side = MEMBER("side", nil); 
		switch(_side) do {
			case west: {
				{
					WEST_FOOD_COUNT = MEMBER("food", nil);
					(owner _x) publicVariableClient "WEST_FOOD_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case east: {
				{
					EAST_FOOD_COUNT = MEMBER("food", nil);
					(owner _x) publicVariableClient "EAST_FOOD_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case resistance: {
				{
					GUER_FOOD_COUNT = MEMBER("food", nil);
					(owner _x) publicVariableClient "GUER_FOOD_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			default {
				{
					CIV_FOOD_COUNT = MEMBER("food", nil);
					(owner _x) publicVariableClient "CIV_FOOD_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
		};
	};
	PUBLIC FUNCTION("","pushMedicineUpdate") {
		private _side = MEMBER("side", nil); 
		switch(_side) do {
			case west: {
				{
					WEST_MED_COUNT = MEMBER("medicine", nil);
					(owner _x) publicVariableClient "WEST_MED_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case east: {
				{
					EAST_MED_COUNT = MEMBER("medicine", nil);
					(owner _x) publicVariableClient "EAST_MED_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case resistance: {
				{
					GUER_MED_COUNT = MEMBER("medicine", nil);
					(owner _x) publicVariableClient "GUER_MED_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			default {
				{
					CIV_MED_COUNT = MEMBER("medicine", nil);
					(owner _x) publicVariableClient "CIV_MED_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
		};
	};
	PUBLIC FUNCTION("","pushResourceUpdate") {
		private _side = MEMBER("side", nil); 
		switch(_side) do {
			case west: {
				{
					WEST_RES_COUNT = MEMBER("resources", nil);
					(owner _x) publicVariableClient "WEST_RES_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case east: {
				{
					EAST_RES_COUNT = MEMBER("resources", nil);
					(owner _x) publicVariableClient "EAST_RES_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			case resistance: {
				{
					GUER_RES_COUNT = MEMBER("resources", nil);
					(owner _x) publicVariableClient "GUER_RES_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
			default {
				{
					CIV_RES_COUNT = MEMBER("resources", nil);
					(owner _x) publicVariableClient "CIV_RES_COUNT";
				} forEach (playableUnits select {(side _x) == _side});
			};
		};
	};
	PUBLIC FUNCTION("","getMoney") {
		MEMBER("money", nil);
	};
	PUBLIC FUNCTION("scalar","setMoney") {
		MEMBER("money", _this);
		MEMBER("pushMoneyUpdate", nil);
	};
	PUBLIC FUNCTION("","getAmmo") {
		MEMBER("ammo", nil);
	};
	PUBLIC FUNCTION("scalar","setAmmo") {
		MEMBER("ammo", _this);
		MEMBER("pushAmmoUpdate", nil);
	};
	PUBLIC FUNCTION("","getFuel") {
		MEMBER("fuel", nil);
	};
	PUBLIC FUNCTION("scalar","setFuel") {
		MEMBER("fuel", _this);
		MEMBER("pushFuelUpdate", nil);
	};
	PUBLIC FUNCTION("","getFood") {
		MEMBER("food", nil);
	};
	PUBLIC FUNCTION("scalar","setFood") {
		MEMBER("food", _this);
		MEMBER("pushFoodUpdate", nil);
	};
	PUBLIC FUNCTION("","getMedicine") {
		MEMBER("medicine", nil);
	};
	PUBLIC FUNCTION("scalar","setMedicine") {
		MEMBER("medicine", _this);
		MEMBER("pushMedicineUpdate", nil);
	};
	PUBLIC FUNCTION("","getResources") {
		MEMBER("resources", nil);
	};
	PUBLIC FUNCTION("scalar","setResources") {
		MEMBER("resources", _this);
		MEMBER("pushResourcesUpdate", nil);
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
	PUBLIC FUNCTION("","getIncomeMoney") {
		MEMBER("income_money", nil);
	};
	PUBLIC FUNCTION("","getIncomeAmmo") {
		MEMBER("income_Ammo", nil);
	};
	PUBLIC FUNCTION("","getIncomeFuel") {
		MEMBER("income_fuel", nil);
	};
	PUBLIC FUNCTION("","getIncomeFood") {
		MEMBER("income_food", nil);
	};
	PUBLIC FUNCTION("","getIncomeMedicine") {
		MEMBER("income_medicine", nil);
	};
	PUBLIC FUNCTION("","getIncomeResources") {
		MEMBER("income_resources", nil);
	};
	PUBLIC FUNCTION("scalar","consumeMoney") {
		private _amount = _this;
		private _ret = false;
		if (MEMBER("money", nil) >= _amount) then {
			MEMBER("money", (MEMBER("money", nil) - _amount));
			MEMBER("pushMoneyUpdate", nil);
			_ret = true;
		};
		_ret;
	};
	PUBLIC FUNCTION("scalar","consumeAmmo") {
		private _amount = _this;
		private _ret = false;
		if (MEMBER("ammo", nil) >= _amount) then {
			MEMBER("ammo", (MEMBER("ammo", nil) - _amount));
			MEMBER("pushAmmoUpdate", nil);
			_ret = true;
		};
		_ret;
	};
	PUBLIC FUNCTION("scalar","consumeFuel") {
		private _amount = _this;
		private _ret = false;
		if (MEMBER("fuel", nil) >= _amount) then {
			MEMBER("fuel", (MEMBER("fuel", nil) - _amount));
			MEMBER("pushFuelUpdate", nil);
			_ret = true;
		};
		_ret;
	};
	PUBLIC FUNCTION("scalar","consumeFood") {
		private _amount = _this;
		private _ret = false;
		if (MEMBER("food", nil) >= _amount) then {
			MEMBER("food", (MEMBER("food", nil) - _amount));
			MEMBER("pushFoodUpdate", nil);
			_ret = true;
		};
		_ret;
	};
	PUBLIC FUNCTION("scalar","consumeMedicine") {
		private _amount = _this;
		private _ret = false;
		if (MEMBER("medicine", nil) >= _amount) then {
			MEMBER("medicine", (MEMBER("medicine", nil) - _amount));
			MEMBER("pushMedicineUpdate", nil);
			_ret = true;
		};
		_ret;
	};
	PUBLIC FUNCTION("scalar","consumeResources") {
		private _amount = _this;
		private _ret = false;
		if (MEMBER("resources", nil) >= _amount) then {
			MEMBER("resources", (MEMBER("resources", nil) - _amount));
			MEMBER("pushResourcesUpdate", nil);
			_ret = true;
		};
		_ret;
	};
	PUBLIC FUNCTION("scalar","addMoney") {
		private _amount = _this;
		MEMBER("money", (MEMBER("money", nil) + _amount));
		MEMBER("pushMoneyUpdate", nil);
	};
	PUBLIC FUNCTION("scalar","addAmmo") {
		private _amount = _this;
		MEMBER("ammo", (MEMBER("ammo", nil) + _amount));
		MEMBER("pushAmmoUpdate", nil);
	};
	PUBLIC FUNCTION("scalar","addFuel") {
		private _amount = _this;
		MEMBER("fuel", (MEMBER("fuel", nil) + _amount));
		MEMBER("pushFuelUpdate", nil);
	};
	PUBLIC FUNCTION("scalar","addFood") {
		private _amount = _this;
		MEMBER("food", (MEMBER("food", nil) + _amount));
		MEMBER("pushFoodUpdate", nil);
	};
	PUBLIC FUNCTION("scalar","addMedicine") {
		private _amount = _this;
		MEMBER("medicine", (MEMBER("medicine", nil) + _amount));
		MEMBER("pushMedicineUpdate", nil);
	};
	PUBLIC FUNCTION("scalar","addResources") {
		private _amount = _this;
		MEMBER("resources", (MEMBER("resources", nil) + _amount));
		MEMBER("pushResourcesUpdate", nil);
	};
	PUBLIC FUNCTION("string", "deconstructor") {
		deleteCenter MEMBER("side", nil);
		//FIXME: iterate over all usints and kill them? :)
		DELETE_VARIABLE("side");
		DELETE_VARIABLE("scalar", "money");
		DELETE_VARIABLE("scalar", "ammo");
		DELETE_VARIABLE("scalar", "fuel");
		DELETE_VARIABLE("scalar", "food");
		DELETE_VARIABLE("scalar", "medicine");
		DELETE_VARIABLE("scalar", "resources");
		DELETE_VARIABLE("array",  "scouts");
		DELETE_VARIABLE("array",  "roadblocks");
		DELETE_VARIABLE("array",  "cities");
		DELETE_VARIABLE("array",  "buildings");
		DELETE_VARIABLE("scalar", "income_money");
		DELETE_VARIABLE("scalar", "income_ammo");
		DELETE_VARIABLE("scalar", "income_fuel");
		DELETE_VARIABLE("scalar", "income_food");
		DELETE_VARIABLE("scalar", "income_medicine");
		DELETE_VARIABLE("scalar", "income_resources");
		DELETE_VARIABLE("scalar", "max_scouts");
		DELETE_VARIABLE("scalar", "max_roadblocks");
		hint _this;
	};
ENDCLASS;
