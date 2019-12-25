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
 
player createDiaryRecord ["Diary", [localize "BRIEFING_01_TITLE", localize "BRIEFING_01_DESC"]];
player createDiaryRecord ["Diary", ["-------------", ""]];
player createDiaryRecord ["Diary", [localize "BRIEFING_00_TITLE", localize "BRIEFING_00_DESC"]];
player createDiaryRecord ["Diary", ["-------------", ""]];
player createDiaryRecord ["Diary", [localize "BRIEFING_07_TITLE", localize "BRIEFING_07_DESC"]];

waitUntil {
		sleep 3;
		mission_requested;
};

private _west = getText (configFile >> "CfgFactionClasses" >> D_FRACTION_WEST >> "displayName");

player createDiaryRecord ["Diary", ["-------------", ""]];

#include "..\briefing.sqf";

player createDiaryRecord ["Diary", ["-------------", ""]];
player createDiaryRecord ["Diary", [localize "BRIEFING_04_TITLE",  format [localize "BRIEFING_04_DESC", _west]]]; 
player createDiaryRecord ["Diary", [localize "BRIEFING_05_TITLE", localize "BRIEFING_05_DESC"]];
player createDiaryRecord ["Diary", ["-------------", ""]];
player createDiaryRecord ["Diary", [localize "BRIEFING_11_TITLE", format [localize "BRIEFING_11_DESC", _west, D_FRACTION_CIV]]];
player createDiaryRecord ["Diary", [localize "BRIEFING_10_TITLE", format [localize "BRIEFING_10_DESC", D_FRACTION_INDEP]]];
player createDiaryRecord ["Diary", [localize "BRIEFING_09_TITLE", format [localize "BRIEFING_09_DESC", _west, D_FRACTION_EAST]]];
player createDiaryRecord ["Diary", [format [localize "BRIEFING_08_TITLE", _west], format [localize "BRIEFING_08_DESC", _west, _west, _west, _west, D_FRACTION_WEST]]];
player createDiaryRecord ["Diary", [format [localize "BRIEFING_06_TITLE", _west], format [localize "BRIEFING_06_DESC", _west, _west, D_FRACTION_WEST]]];
