/*   Forms_WIN.xs - An extension to PERL to access XForms functions.
#    Copyright (C) 1996  Martin Bartlett
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
*/

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <forms.h>
#include "../PerlForms.h"

MODULE = Forms_WIN		PACKAGE = Forms_WIN

void
fl_get_winsize(win)
	Window		win
	PPCODE:
	{
		FL_Coord        xl, yl;

		fl_get_winsize(win, &xl, &yl);
		XPUSHs(sv_2mortal(newSViv(xl)));
		XPUSHs(sv_2mortal(newSViv(yl)));
	}

void
fl_get_winorigin(win)
	Window		win
	PPCODE:
	{
		FL_Coord        x, y;

		fl_get_winsize(win, &x, &y);
		XPUSHs(sv_2mortal(newSViv(x)));
		XPUSHs(sv_2mortal(newSViv(y)));
	}

void
fl_get_wingeometry(win)
	Window		win
	PPCODE:
	{
		FL_Coord        x, y, xl, yl;

		fl_get_wingeometry(win, &x, &y, &xl, &yl);
		XPUSHs(sv_2mortal(newSViv(x)));
		XPUSHs(sv_2mortal(newSViv(y)));
		XPUSHs(sv_2mortal(newSViv(xl)));
		XPUSHs(sv_2mortal(newSViv(yl)));
	}

void
fl_get_win_mouse(inwin)
	Window		inwin
	PPCODE:
	{
		Window		win;
		FL_Coord        x, y;
		unsigned int    i1;

		win = fl_get_win_mouse(inwin, &x, &y, &i1);
		XPUSHs(sv_2mortal(newSViv(win)));
		XPUSHs(sv_2mortal(newSViv(x)));
		XPUSHs(sv_2mortal(newSViv(y)));
		XPUSHs(sv_2mortal(newSViv(i1)));
	}

FLForm *
fl_win_to_form(win)
	Window		win

Window
fl_wincreate(string)
	const char *	string

Window
fl_winshow(win)
	Window		win

Window
fl_winopen(string)
	const char *	string

void
fl_winhide(win)
	Window		win

void
fl_winclose(win)
	Window		win

void
fl_winset(win)
	Window		win

Window
fl_winget()

void
fl_winresize(win,xl,yl)
	Window		win
	int		xl
	int		yl

void
fl_winmove(win,x,y)
	Window		win
	int		x
	int		y

void
fl_winbackground(win,ul)
	Window		win
	unsigned long	ul

void
fl_winstepunit(win,x,y)
	Window		win
	int		x
	int		y

int
fl_winisvalid(win)
	Window		win

void
fl_wintitle(win,string)
	Window		win
	const char *	string

void
fl_winposition(x,y)
	int		x
	int		y

void
fl_winminsize(win,xl,yl)
	Window		win
	int		xl
	int		yl

void
fl_winmaxsize(win,xl,yl)
	Window		win
	int		xl
	int		yl

void
fl_reset_winiconstraints(win)
	Window		win

void
fl_winaspect(win,xl,yl)
	Window		win
	int		xl
	int		yl

void
fl_winsize(xl,yl)
	int		xl
	int		yl

void
fl_initial_winsize(xl,yl)
	int		xl
	int		yl

void
fl_initial_winstate(i)
	int		i

void
fl_wingeometry(x,y,xl,yl)
	int		x
	int		y
	int		xl
	int		yl

void
fl_winreshape(win,x,y,xl,yl)
	Window		win
	FL_Coord	x
	FL_Coord 	y
	FL_Coord 	xl
	FL_Coord 	yl

void
fl_initial_wingeometry(x,y,xl,yl)
	int		x
	int		y
	int		xl
	int		yl

GC
fl_create_GC()
	CODE:
	{
		RETVAL = XCreateGC(fl_get_display(),
				   fl_default_window(),0,0);
	}
	OUTPUT:
	RETVAL

void
fl_set_foreground(gc,color)
	GC		gc
	FL_COLOR	color

void
fl_set_background(gc,color)
	GC		gc
	FL_COLOR	color

void
fl_fill_rectangle(win,gc,x,y,xl,yl)
	Window		win
	GC		gc
	int		x
	int		y
	int		xl
	int		yl
	CODE:
	{
		XFillRectangle(fl_get_display(),
			       win, gc, x, y, xl, yl);
	}

void
fl_noborder()

void
fl_transient()


void
fl_set_gc_clipping(gc1,x,y,xl,yl)
        GC              gc1
        int             x
        int             y
        int             xl
        int             yl

void
fl_unset_gc_clipping(gc1)
        GC              gc1


