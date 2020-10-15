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
 
 /*
Briefing script
*/

player createDiaryRecord ["Diary", [ localize "Завдання",  localize "STR_Comms_Desc"]];
player createDiaryRecord ["Diary", ["-------------", ""]];
player createDiaryRecord ["Diary", [ "Розвідка", "Додаткові данні вашої розвідки:<br /><br />
* Центральна дорога в місто охороняться;<br />
* Добре укріплене поселення знаходиться в центрі міста;<br />
* Промислова частина міста дуже сильно зараженf;<br />
* Точної інформації щодо місцезнаходження об'єкту Х-25 - немає;<br />
<br /><br />
Додаткові данні від культу:<br />
* об'єкт Х-25 хімічно активний, використовуйте хімічні детектори для його локації;<br />
* об'єкт Х-25 хімічно небезпечний, використовуйте протигази для його транспортування;<br />
* об'єкт Х-25 хімічно небезпечний, використовуйте авто для його транспортування;<br />"]];
player createDiaryRecord ["Diary", ["-------------", ""]];
player createDiaryRecord ["Diary", [ "Ситуація",  "Група ренегатів відокремилась від Культу, і забравши цінний об'єкт Х-25 затаїлась у руїнах міста <marker name = 'wp_poi_brat'>Братів</marker>.<br />
Ваше завдання: Зібрати групу, прочесати місцевість міста Братів, знайти об'єкт Х-25 та доставити його контактній групі в <marker name = 'poi_lug'>Новий луг</marker>.<br />
<img image='data\x25.paa' width='256' height='256'/>
<br />
Розвідка доповідає про кілька укріплених поселень в північній частині міста. Місцевість сильно заражена радіаційними і хімічними речовинами. Руїни старих заводів приваблюють місцевих сталкерів."]];


