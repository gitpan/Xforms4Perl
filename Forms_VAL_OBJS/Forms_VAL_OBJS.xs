/*   Forms_VAL_OBJS.xs - An extension to PERL to access XForms functions.
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

const char *
process_counter_filter(object, parm1, parm2)
FLObject *	object;
double          parm1;
int             parm2;
{

	/*
	 * Generic counter filter process
	 */

	SV *    object_callback_ptr =
		(get_object_data(object))->od_count_filter;

	if (object_callback_ptr == NULL)
		croak("Counter filter routine not set");
	call_perl_callback(object_callback_ptr,
			  FALSE,
			  "Odi",
			  object, parm1, parm2);

}

const char *
process_slider_filter(object, parm1, parm2)
FLObject *	object;
double          parm1;
int             parm2;
{

	/*
	 * Generic counter filter process
	 */

	SV *    object_callback_ptr =
		(get_object_data(object))->od_slider_filter;

	if (object_callback_ptr == NULL)
		croak("Slider filter routine not set");
	call_perl_callback(object_callback_ptr,
			  FALSE,
			  "Odi",
			  object, parm1, parm2);

}

MODULE = Forms_VAL_OBJS		PACKAGE = Forms_VAL_OBJS

void
fl_set_counter_value(object,value)
	FLObject *	object
	double		value

void
fl_set_counter_bounds(object,value1,value2)
	FLObject *	object
	double		value1
	double		value2

void
fl_set_counter_step(object,value1,value2)
	FLObject *	object
	double		value1
	double		value2

void
fl_set_counter_precision(object,value)
	FLObject *	object
	int		value

double
fl_get_counter_value(object)
	FLObject *	object

void
fl_set_counter_return(object,value)
	FLObject *	object
	int		value

void
fl_set_counter_filter(object,callback)
	FLObject *	object
	SV *		callback
	CODE:
	{
		return_save_sv(&(ST(0)),
			       &(get_object_data(object)->od_count_filter),
			       callback);
		fl_set_counter_filter(object,
			(callback == NULL ? NULL : process_counter_filter));
	}

void
fl_set_dial_value(object,value)
	FLObject *	object
	double		value

double
fl_get_dial_value(object)
	FLObject *	object

void
fl_set_dial_bounds(object,value1,value2)
	FLObject *	object
	double		value1
	double		value2

void
fl_get_dial_bounds(object)
	FLObject *	object
	PPCODE:
	{
		double		value1, value2;

		fl_get_dial_bounds(object, &value1, &value2);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSViv(value1)));
		PUSHs(sv_2mortal(newSViv(value2)));
	}

void
fl_set_dial_step(object,value)
	FLObject *	object
	double		value

void
fl_set_dial_return(object,value)
	FLObject *	object
	int		value

void
fl_set_dial_angles(object,value1,value2)
	FLObject *	object
	double		value1
	double		value2

void
fl_set_dial_cross(object,value)
	FLObject *	object
	int		value


void
fl_set_positioner_xvalue(object,val)
	FLObject *	object
	double		val

double
fl_get_positioner_xvalue(object)
	FLObject *	object

void
fl_set_positioner_xbounds(object,val1,val2)
	FLObject *	object
	double		val1
	double		val2

void
fl_get_positioner_xbounds(object)
	FLObject *	object
	PPCODE:
	{
		double		value1, value2;

		fl_get_positioner_xbounds(object, &value1, &value2);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
	}

void
fl_set_positioner_xstep(object,val)
	FLObject *	object
	double		val

void
fl_set_positioner_yvalue(object,val)
	FLObject *	object
	double		val

double
fl_get_positioner_yvalue(object)
	FLObject *	object

void
fl_set_positioner_ybounds(object,val1,val2)
	FLObject *	object
	double		val1
	double		val2

void
fl_get_positioner_ybounds(object)
	FLObject *	object
	PPCODE:
	{
		double		value1, value2;

		fl_get_positioner_ybounds(object, &value1, &value2);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
	}

void
fl_set_positioner_ystep(object,val)
	FLObject *	object
	double		val

void
fl_set_positioner_return(object,val)
	FLObject *	object
	int		val

void
fl_set_slider_value(object,val)
	FLObject *	object
	double		val

double
fl_get_slider_value(object)
	FLObject *	object

void
fl_set_slider_bounds(object,val1,val2)
	FLObject *	object
	double		val1
	double		val2

void
fl_get_slider_bounds(object)
	FLObject *	object
	PPCODE:
	{
		double		value1, value2;

		fl_get_slider_bounds(object, &value1, &value2);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
	}

void
fl_set_slider_step(object,val)
	FLObject *	object
	double		val

void
fl_set_slider_size(object,val)
	FLObject *	object
	double		val

void
fl_set_slider_return(object,val)
	FLObject *	object
	int		val

void
fl_set_slider_precision(object,val)
	FLObject *	object
	int		val

void
fl_set_slider_filter(object,callback)
	FLObject *	object
	SV *	    callback
	CODE:
	{
		return_save_sv(&(ST(0)),
			       &(get_object_data(object)->od_slider_filter),
			       callback);
		fl_set_counter_filter(object,
			(callback == NULL ? NULL : process_slider_filter));
	}

FLObject *
fl_add_counter(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_add_counter(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of counter failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_create_counter(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_create_counter(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of counter failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_add_dial(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_add_dial(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of dial failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_create_dial(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_create_dial(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of dial failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_add_positioner(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_add_positioner(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of positioner failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_create_positioner(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_create_positioner(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of positioner failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_add_slider(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_add_slider(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of slider failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_create_slider(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_create_slider(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of slider failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_create_valslider(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_create_valslider(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of valslider failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_add_valslider(type,x,y,width,height,label)
	int             type
	int             x
	int             y
	int             width
	int             height
	char *		label
	CODE:
	{
		RETVAL = fl_add_valslider(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of valslider failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

