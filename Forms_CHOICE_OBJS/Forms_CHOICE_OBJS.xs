/*   Forms_CHOICE_OBJS.xs - An extension to PERL to access XForms functions.
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

MODULE = Forms_CHOICE_OBJS		PACKAGE = Forms_CHOICE_OBJS

void
fl_clear_choice(object)
	FLObject *	object

void
fl_addto_choice(object,text)
	FLObject *	object
	char *		text

void
fl_replace_choice(object,place,text)
	FLObject *	object
	int		place
	char *		text

void
fl_delete_choice(object,place)
	FLObject *	object
	int		place

void
fl_set_choice(object,place)
	FLObject *	object
	int		place

void
fl_set_choice_text(object,text)
	FLObject *	object
	char *		text

int
fl_get_choice(object)
	FLObject *	object

int
fl_get_choice_maxitems(object)
	FLObject *	object

const char *
fl_get_choice_text(object)
	FLObject *	object

void
fl_set_choice_fontsize(object,value)
	FLObject *	object
	int		value

void
fl_set_choice_fontstyle(object,value)
	FLObject *	object
	int		value

void
fl_set_choice_align(object,value)
	FLObject *	object
	int		value

void
fl_set_choice_item_mode(object,val1,val2)
	FLObject *	object
	int		val1
	unsigned	val2

void
fl_set_choice_item_shortcut(object,place,shortcut)
	FLObject *	object
	int		place
	char *		shortcut

void
fl_clear_menu(object)
	FLObject *	object

void
fl_set_menu(object,string)
	FLObject *	object
	char *		string

void
fl_addto_menu(object,string)
	FLObject *	object
	char *		string

void
fl_replace_menu_item(object,place,string)
	FLObject *	object
	int		place
	char *		string

void
fl_delete_menu_item(object,place)
	FLObject *	object
	int		place

void
fl_set_menu_item_shortcut(object,place,string)
	FLObject *	object
	int		place
	char *		string

void
fl_set_menu_item_mode(object,place,value)
	FLObject *	object
	int		place
	unsigned	value

void
fl_show_menu_symbol(object,place)
	FLObject *	object
	int		place

void
fl_set_menu_popup(object,place)
	FLObject *	object
	int		place

int
fl_get_menu(object)
	FLObject *	object

int
fl_get_menu_maxitems(object)
	FLObject *	object

int
fl_get_menu_item_mode(object,item)
	FLObject *	object
	int		item

const char *
fl_get_menu_text(object)
	FLObject *	object

int
fl_newpup(win)
	Window		win

int
fl_defpup(win,string)
	Window		win
	const char *	string

int
fl_addtopup(int1,string)
	int		int1
	const char *	string

int
fl_setpup_mode(int1,int2,us1)
	int		int1
	int		int2
	unsigned	us1

void
fl_freepup(int1)
	int		int1

int
fl_dopup(int1)
	int		int1

void
fl_setpup_shortcut(int1,int2,string)
	int		int1
	int		int2
	const char *	string

void
fl_setpup_position(int1,int2)
	int		int1
	int		int2

void
fl_setpup_selection(int1,int2)
	int		int1
	int		int2

void
fl_setpup_fontsize(int1)
	int		int1

void
fl_setpup_fontstyle(int1)
	int		int1

void
fl_setpup_shadow(int1,int2)
	int		int1
	int		int2

void
fl_setpup_softedge(int1,int2)
	int		int1
	int		int2

void
fl_setpup_color(col1,col2)
	unsigned long	col1
	unsigned long	col2

void
fl_setpup_title(int1,string)
	int		int1
	const char *	string

void
fl_setpup_bw(int1,int2)
	int		int1
	int		int2

void
fl_setpup_pad(int1,int2,int3)
	int		int1
	int		int2
	int		int3

Cursor
fl_setpup_cursor(int1,int2)
	int		int1
	int		int2

Cursor
fl_setpup_default_cursor(int1)
	int		int1

int
fl_setpup_maxpup(int1)
	int		int1

unsigned
fl_getpup_mode(int1,int2)
	int		int1
	int		int2

const char *
fl_getpup_text(int1,int2)
	int		int1
	int		int2

void
fl_showpup(int1)
	int		int1

void
fl_hidepup(int1)
	int		int1

void
fl_setpup_submenu(int1,int2,int3)
	int		int1
	int		int2
	int		int3

FLObject *
fl_create_choice(type,x,y,width,height,label)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_create_choice(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of choice failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL


FLObject *
fl_add_choice(type,x,y,width,height,label)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_add_choice(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of choice failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_create_menu(type,x,y,width,height,label)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_create_menu(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of menu failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_add_menu(type,x,y,width,height,label)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_add_menu(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of menu failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

