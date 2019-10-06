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
 
 if (isServer) then {
	params ["_center", "_distance", "_chance"];
	
	{
		if ((random 100) <= _chance) then {
			private _building = _x;
			for "_i" from 1 to random(3) do {
				private _positions = _building buildingPos -1;
				if (count _positions > 0) then {
					private _pos = selectRandom (_positions);
					if (!isNil "_pos") then {
						private _class = selectRandom D_HOUSE_ITEMS;
						private _itemBox = "GroundWeaponHolder" createVehicle [0,0,0];
						_itemBox setPos _pos;
						
						private _type = _class call BIS_fnc_itemType;
						switch (_type select 0) do {
							case 'Weapon': { 
								_itemBox addWeaponCargoGlobal [_class, 1];
								private _magazines = getArray (configFile >> "CfgWeapons" >> _class >> "magazines");
								_itemBox addMagazineCargoGlobal [(selectRandom _magazines), (random 5)];
							};
							case 'Item': { _itemBox addItemCargoGlobal [_class, 1]; };
							case 'Equipment': { 
								if ((_type select 1) == "Backpack") then {
									_itemBox addBackpackCargoGlobal [_class, 1];	
								} else {
									_itemBox addItemCargoGlobal [_class, 1];									
								};
							};
							default { systemChat format ["Error: can't get item type: %1", _class]; };
						};						
					};
				};
			};
		};
	} count ((_center nearObjects ["House" , _distance]) + (_center nearObjects ["Building" , _distance]));
};