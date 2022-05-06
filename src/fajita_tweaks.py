'''
 Copyright (C) 2022  Ivo Xavier

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 fajitatweaks is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''
import pyotherside
import os
import sys

class Tweaks():

  def moduleState():
    return 'Python Module Imported'

  def doubleTap(option):
    os.system('echo %s > /proc/touchpanel/double_tap_enable' % option)
    return option

tweaks = Tweaks()