#    Xforms.pm - An extension to PERL to access XForms functions.
#    Copyright (C) 1996-1997  Martin Bartlett
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
#
# NOTE ON 'INC =>' AND 'LIBS =>'
#
#       If the forms.h is not in your default include directory path
#       then add '-I/your/path' to 'INC =>'
#
#       Similarly for X11/lib - if its not in your default lib path
#       then add '-L/your/path' at the start of 'LIBS =>'
#
#	OPENGL:
#		If you have OpenGL and want that functionality compiled into
#		the extension then you must do the following:
#			
#			1) Change the DEFINE hash to be like so:
#				DEFINE => '-DXFOPENGL',
#			2) Add the name of the OpenGL library to the list
#			   of libraries under LIBS
#
WriteMakefile(
       DEFINE => '',
       INC => '',
       LIBS => [ '-L/usr/X11/lib -lforms -lX11 -lXpm -lm' ],
       NAME => 'Xforms',
       VERSION => '0.5'
);
