/*   Forms_CANVAS.xs - An extension to PERL to access XForms functions.
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
process_mcp_init(object)
FLObject *      object;
{
	/*
	 * Generic canvas init callback
	 */

	SV *		object_callback_ptr =
		(get_object_data(object))->od_mcpinit;

	if (object_callback_ptr == NULL)
		croak("Canvas initialize routine not set");
	return call_perl_callback(object_callback_ptr,
				  TRUE,
				  "O",
				  object);
}

int
process_mcp_act(object)
FLObject *      object;
{
	/*
	 * Generic canvas activate
	 */

	SV *		object_callback_ptr =
		(get_object_data(object))->od_mcpact;

	if (object_callback_ptr == NULL)
		croak("Canvas activate routine not set");
	return call_perl_callback(object_callback_ptr,
				  TRUE,
				  "O",
				  object);
}

int
process_mcp_clean(object)
FLObject *      object;
{
	/*
	 * Generic canvas cleanup callback
	 */

	SV *		object_callback_ptr =
		(get_object_data(object))->od_mcpclean;

	if (object_callback_ptr == NULL)
		croak("Canvas cleanup routine not set");
	return call_perl_callback(object_callback_ptr,
				  TRUE,
				  "O",
				  object);
}

int
process_canvas_event(object,window,int1,int2,event,parm)
FLObject *     object;
Window          window;
int             int1;
int             int2;
XEvent *        event;
void *          parm;
{
	SV **   canv_event_cbs =
		(get_object_data(object))->od_cevents;
	SV *		object_callback_ptr;

	if (canv_event_cbs == NULL)
		croak("Free object handler routine not set");
	if ((object_callback_ptr = canv_event_cbs[event->type]) == NULL)
		croak("Free object handler routine not set");
	return call_perl_callback(object_callback_ptr,
				  TRUE,
				  "Oiiiep",
				  object,window,int1,int2,event,parm);
}

MODULE = Forms_CANVAS		PACKAGE = Forms_CANVAS

FLObject *
fl_create_generic_canvas(type,i1,x,y,width,height,label)
	int		type
	int		i1
	int		x
	int		y
	int		width
	int		height
	char *		label

void
fl_set_canvas_decoration(object,int1)
	FLObject *	object
	int		int1

void
fl_set_canvas_colormap(object,colormap)
	FLObject *	object
	Colormap	colormap

void
fl_set_canvas_visual(object,visual)
	FLObject *	object
	Visual *	visual

void
fl_set_canvas_depth(object,int1)
	FLObject *	object
	int		int1

int
fl_get_canvas_depth(object)
	FLObject *	object

void
fl_set_canvas_attributes(object,int1,winattr)
	FLObject *		object
	unsigned		int1
	XSetWindowAttributes *	winattr

void
fl_add_canvas_handler(object,event,callback,parm)
	FLObject *	object
	int		event
	SV *		callback
	void *		parm
	CODE:
	{
		object_data *obdat =
			get_object_data(object);
		SV **   canv_event_cbs = obdat->od_cevents;

		if (!canv_event_cbs) {
			canv_event_cbs =
				(SV **)calloc(LASTEvent, sizeof(SV *));
			obdat->od_cevents = canv_event_cbs;
		}
		return_save_sv(&(ST(0)),
			       &(canv_event_cbs[event]),
			       callback);
		fl_add_canvas_handler(object, event,
				      (callback == NULL ? NULL :
				      process_canvas_event),
				      parm);
	}

Window
fl_get_canvas_id(object)
	FLObject *	object

Colormap
fl_get_canvas_colormap(object)
	FLObject *	object

void
fl_remove_canvas_handler(object,event)
	FLObject *	object
	int		event
	CODE:
	{
		object_data *   ob_data = get_object_data(object);

		if (ob_data &&
		    ob_data->od_cevents &&
		    ob_data->od_cevents[event]) {
			fl_remove_canvas_handler(object, event,
				      process_canvas_event);
			ob_data->od_cevents[event] = NULL;
		}
	}

void
fl_hide_canvas(object)
	FLObject *	object

void
fl_canvas_yield_to_shortcut(object,int1)
	FLObject *	object
	int		int1

void
fl_modify_canvas_prop(object,init_cb,act_cb,clean_cb)
	FLObject *	object
	SV *		init_cb
	SV *		act_cb
	SV *		clean_cb
	CODE:
	{
		object_data *obdat = get_object_data(object);

		SAVESV(obdat->od_mcpinit, init_cb);
		SAVESV(obdat->od_mcpact, act_cb);
		SAVESV(obdat->od_mcpclean, clean_cb);
		fl_modify_canvas_prop(object,
				      (init_cb == NULL ? NULL :
				      process_mcp_init),
				      (act_cb == NULL ? NULL :
				      process_mcp_act),
				      (clean_cb == NULL ? NULL :
				      process_mcp_clean));
	}


FLObject *
fl_create_canvas(type,x,y,width,height,label)
	int		type
	int		x
	int             y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_create_canvas(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of canvas failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_add_canvas(type,x,y,width,height,label)
	int		type
	int		x
	int             y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_add_canvas(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of canvas failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL


