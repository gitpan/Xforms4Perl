/*   Forms_DRAW.xs - An extension to PERL to access XForms functions.
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

int
process_free_handle(object,int1,int2,x,y,event)
FLObject *      object;
int             int1;
int             int2;
int             x;
int             y;
void *          event;
{
	/*
	 * Generic free object handler
	 */

	SV *		object_callback_ptr =
		(get_object_data(object))->od_freehandler;
	if (object_callback_ptr == NULL)
		croak("Free object handler routine not set");
	return call_perl_callback(object_callback_ptr,
				  TRUE,
				  "Oiiiiie",
				  object,int1,int2,x,y,event);
}

MODULE = Forms_DRAW		PACKAGE = Forms_DRAW

void
fl_rectangle(type,x,y,xl,yl,color)
	int		type
	int		x
	int		y
	int		xl
	int		yl
	unsigned long	color

void
fl_rectbound(x,y,xl,yl,color)
	int		x
	int		y
	int		xl
	int		yl
	unsigned long	color

void
fl_roundrectangle(type,x,y,xl,yl,color)
	int		type
	int		x
	int		y
	int		xl
	int		yl
	unsigned long	color

void
fl_polygon(type,...)
	int		type
	CODE:
	{
		XPoint  *polypts, *savepts ;
		int		i = 1, color, numpts = 0;

		if (items < 4 || items % 2 != 0)
			croak("usage: fl_polygon(type,x,y,...,color)");
		numpts = (items - 2) / 2;

		polypts = (XPoint *)calloc(numpts, sizeof(XPoint));
		savepts = polypts;
		while (i<items-1) {
			polypts->x = SvIV(ST(i));
			i++;
			polypts->y = SvIV(ST(i));
			i++;
			polypts++;
		}

		color = SvIV(ST(i));

		fl_polygon(type,savepts,numpts,color);
		free((void *)savepts);
	}


void
fl_lines(...)
	CODE:
	{
		XPoint  *linepts, *savepts ;
		int		i = 0, color, numpts = 0;

		if (items < 3 || (items-1)%2 != 0)
			croak("usage: fl_lines(x,y,...,color)");
		numpts = (items - 1) / 2;

		linepts = (XPoint *)calloc(numpts, sizeof(XPoint));
		savepts = linepts;
		while (i<items-1) {
			linepts->x = SvIV(ST(i));
			i++;
			linepts->y = SvIV(ST(i));
			i++;
			linepts++;
		}

		color = SvIV(ST(i));

		fl_lines(savepts,numpts,color);

		free((void*)savepts);
	}

void
fl_line(x,y,w,h,c)
	FL_Coord	x
	FL_Coord	y
	FL_Coord	w
	FL_Coord	h
	FL_COLOR	c

void
fl_oval(s,x,y,w,h,c)
	int		s
	int		x
	int		y
	int		w
	int		h
	unsigned long	c

void
fl_ovalbound(x,y,w,h,c)
	int		x
	int		y
	int		w
	int		h
	unsigned long	c

void
fl_pieslice(i1,i2,i3,i4,i5,i6,i7,c)
	int		i1
	int		i2
	int		i3
	int		i4
	int		i5
	int		i6
	int		i7
	unsigned long	c

void
fl_add_vertex(i1,i2)
	int		i1
	int		i2

void
fl_add_float_vertex(f1,f2)
	float		f1
	float		f2

void
fl_reset_vertex()

void
fl_endline()

void
fl_endpolygon()

void
fl_endclosedline()

void
fl_drw_frame(i1,i2,i3,i4,i5,i6,i7)
	int		i1
	int		i2
	int		i3
	int		i4
	int		i5
	int		i6
	int		i7

void
fl_drw_checkbox(i1,i2,i3,i4,i5,i6,i7)
	int		i1
	int		i2
	int		i3
	int		i4
	int		i5
	int		i6
	int		i7

void
fl_drw_text(int1,x,y,xl,yl,c,int2,int3,string)
	int		int1
	FL_Coord	x
	FL_Coord	y
	FL_Coord	xl
	FL_Coord	yl
	FL_COLOR	c
	int		int2
	int		int3
	char *		string

void
fl_draw_text(int1,x,y,xl,yl,c,int2,int3,string)
	int		int1
	FL_Coord	x
	FL_Coord	y
	FL_Coord	xl
	FL_Coord	yl
	FL_COLOR	c
	int		int2
	int		int3
	char *		string

void
fl_drw_text_beside(int1,x,y,xl,yl,c,int2,int3,string)
	int		int1
	FL_Coord	x
	FL_Coord	y
	FL_Coord	xl
	FL_Coord	yl
	FL_COLOR	c
	int		int2
	int		int3
	char *		string

void
fl_drw_text_cursor(int1,x,y,xl,yl,int2,int3,int4,string,int5,int6)
	int		int1
	FL_Coord	x
	FL_Coord	y
	FL_Coord	xl
	FL_Coord	yl
	int		int2
	int		int3
	int		int4
	char *		string
	int		int5
	int		int6

void
fl_drw_box(int1,x,y,xl,yl,c,int2)
	int		int1
	FL_Coord	x
	FL_Coord	y
	FL_Coord	xl
	FL_Coord	yl
	FL_COLOR        c
	int		int2

FLObject *
fl_create_free(type,x,y,width,height,label,callback)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	SV *		callback
	CODE:
	{
		object_data *obdat;

		RETVAL = fl_create_free(type,x,y,
				       width,height,label,
				       (callback == NULL ? NULL :
				       process_free_handle));
		obdat = get_object_data(RETVAL);
		SAVESV(obdat->od_freehandler, callback);
	}
	OUTPUT:
	RETVAL

FLObject *
fl_add_free(type,x,y,width,height,label,callback)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	SV *		callback
	CODE:
	{
		object_data *obdat;

		RETVAL = fl_add_free(type,x,y,
				       width,height,label,
				       (callback == NULL ? NULL :
				       process_free_handle));
		obdat = get_object_data(RETVAL);
		SAVESV(obdat->od_freehandler, callback);
	}
	OUTPUT:
	RETVAL

void
fl_linestyle(i)
	int		i

void
fl_linewidth(i)
	int		i
