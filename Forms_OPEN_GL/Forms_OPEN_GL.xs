/*   Forms_OPEN_GL.xs - An extension to PERL to access XForms functions.
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
#include <GL/glx.h>
#include <forms.h>
#include "../PerlForms.h"


MODULE = Forms_OPEN_GL		PACKAGE = Forms_OPEN_GL

FLObject *
fl_create_glcanvas(type,x,y,width,height,label)
        int             type
        int             x
        int             y
        int             width
        int             height
        char *          label

FLObject *
fl_add_glcanvas(type,x,y,width,height,label)
        int             type
        int             x
        int             y
        int             width
        int             height
        char *          label

void 
fl_set_glcanvas_defaults(...)
	CODE:
	{
		int 		*defaults;
		int		i;

		if (items < 1)
    			croak("usage: fl_set_glcanvas_defaults(defaults...)");
		
		/*
 		 * Allocate storage and fill it.
		 */
		defaults = (int *)calloc(items+1, sizeof(int));
		for (i = 0; i < items; i++) {
		    defaults[i] = SvIV(ST(i));
		}
		defaults[items] = 0;
		fl_set_glcanvas_defaults(defaults);

		/* Ok, we're done, lose the area */
		free((void*)defaults);
	}

void 
fl_get_glcanvas_defaults()
	PPCODE:
	{
		int 		defaults[32];	  /* FIXME: bogus constant */
		int		i;

		fl_get_glcanvas_defaults(defaults);

		/* push all defaults on the stack */
		for(i = 0; defaults[i] != 0; i++) {
		}

		EXTEND(sp, i);

		for(i = 0; defaults[i] != 0; i++) {
		    XPUSHs(sv_2mortal(newSViv(defaults[i])));
		}
	}

void 
fl_set_glcanvas_attributes(object,...)
	FLObject *	object
	CODE:
	{
		int 		*defaults;
		int		i;

		if (items < 2)
    			croak("usage: fl_set_glcanvas_attributes(object,defaults...)");
		/*
 		 * Allocate storage and fill it.
		 */
		defaults = (int *)calloc(items, sizeof(int));
		for (i = 1; i < items; i++) {
		    defaults[i-1] = SvIV(ST(i));
		}
		defaults[items-1] = 0;
		fl_set_glcanvas_attributes(object, defaults);

		/* Ok, we're done, lose the area */
		free((void*)defaults);
	}

void 
fl_get_glcanvas_attributes(object)
	FLObject *	object
	PPCODE:
	{
		int 		defaults[32];	  /* FIXME: bogus constant */
		int		i;

		fl_get_glcanvas_attributes(object, defaults);

		for(i = 0; defaults[i] != 0; i++) {
		}

		EXTEND(sp, i);

		/* push all defaults on the stack */
		for(i = 0; defaults[i] != 0; i++) {
		    XPUSHs(sv_2mortal(newSViv(defaults[i])));
		}
	}

void
fl_set_glcanvas_direct(object, flag)
	FLObject *	object
	int		flag

XVisualInfo *
fl_get_glcanvas_xvisualinfo(object)
	FLObject *	object

GLXContext
fl_get_glcanvas_context(object)
	FLObject *	object

void 
fl_glwincreate(int1,int2)
	int		int1
	int		int2
	PPCODE:
	{
		Window 		win;
		GLXContext	glxc;
		int		int3;
		win = fl_glwincreate(&int3, &glxc, int1, int2);
		EXTEND(sp, 3);
		PUSHs(sv_2mortal(newSViv(win)));
		PUSHs(sv_2mortal(newSViv(int3)));
		PUSHs(sv_2mortal(newSViv((IV)glxc)));
	}

void 
fl_glwinopen(int1,int2)
	int		int1
	int		int2
	PPCODE:
	{
		Window 		win;
		GLXContext	glxc;
		int		int3;
		win = fl_glwinopen(&int3, &glxc, int1, int2);
		EXTEND(sp, 3);
		PUSHs(sv_2mortal(newSViv(win)));
		PUSHs(sv_2mortal(newSViv(int3)));
		PUSHs(sv_2mortal(newSViv((IV)glxc)));
	}

