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

// Available locations for play
// This mps to different set of wp_<location>_ markers.
// For example, Plau has two different islands, while Stratis or Tanoa has only one location
D_LOCATIONS = ['Gurun', 'Monyet'];

// Real time vs fast time
// true: Real time is more realistic weather conditions change slowly (ideal for persistent game)
// false: fast time give more different weather conditions (ideal for non persistent game) 
D_CODE43_REAL_WEATHER_REALTIME = true;

// Debug only
D_DEBUG = false;

D_PRISONS = ["Land_Slum_03_F", "Land_Shed_05", "Land_Shed_07", "Land_House_Small_03_F", "Land_House_Small_01_F"];

D_RESPAWN_DELAY = 60;
