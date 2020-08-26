/***************************************************************************************
 * Copyright (C) 2008-2020 by Oleksii S. Malakhov <brezerk@gmail.com>                  *
 *                                                                                     *
 * This program is is licensed under a                                                 *
 * Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. *
 *                                                                                     *
 * You should have received a copy of the license along with this                      *
 * work. If not, see <http://creativecommons.org/licenses/by-nc-nd/4.0/>.              *
 *                                                                                     *
 **************************************************************************************/
 
class NECK
{
	class common
	{
		class Init {file = "addons\BrezBlock.framework\init.sqf";};
		class Logger {file = "addons\BrezBlock.framework\utils\logger.sqf";};
	}
	class persistance
	{
		class PersistanceLoad {file = "addons\BrezBlock.framework\systems\persitance\load.sqf";};
		class PersistanceSave {file = "addons\BrezBlock.framework\systems\persitance\save.sqf";};
	}
}