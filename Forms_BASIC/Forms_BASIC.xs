/*   Forms_BASIC.xs - An extension to PERL to access XForms functions.
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

/*
 * Create/Add arrays
 */

typedef FL_OBJECT * (*CreateFunc)(int,FL_Coord,FL_Coord,
				     FL_Coord,FL_Coord,const char *);

static CreateFunc	create_funcs[] = {

		NULL,
		fl_create_button,
		fl_create_lightbutton,
		fl_create_roundbutton,
		fl_create_checkbutton,
		fl_create_bitmapbutton,
		fl_create_pixmapbutton,
		fl_create_bitmap,
		fl_create_pixmap,
		fl_create_box,
		fl_create_text,
		fl_create_menu,
		fl_create_chart,
		fl_create_choice,
		fl_create_counter,
		fl_create_slider,
		fl_create_valslider,
		fl_create_input,
		fl_create_browser,
		fl_create_dial,
		fl_create_timer,
		fl_create_clock,
		fl_create_positioner,
		NULL,
		fl_create_xyplot,
		NULL,
		fl_create_canvas,
		fl_create_frame,
		NULL
/*		fl_create_mesacanvas*/
};

static CreateFunc	add_funcs[] = {

		NULL,
		fl_add_button,
		fl_add_lightbutton,
		fl_add_roundbutton,
		fl_add_checkbutton,
		fl_add_bitmapbutton,
		fl_add_pixmapbutton,
		fl_add_bitmap,
		fl_add_pixmap,
		fl_add_box,
		fl_add_text,
		fl_add_menu,
		fl_add_chart,
		fl_add_choice,
		fl_add_counter,
		fl_add_slider,
		fl_add_valslider,
		fl_add_input,
		fl_add_browser,
		fl_add_dial,
		fl_add_timer,
		fl_add_clock,
		fl_add_positioner,
		NULL,
		fl_add_xyplot,
		NULL,
		fl_add_canvas,
		fl_add_frame,
		NULL,
/*		fl_add_mesacanvas*/
};

/******************************************************************************
 ******************************************************************************
 ******************************************************************************

  	T H E    C A L L B A C K    M E C H A N I S M

 The structures, fields and functions defined below are the guts of the
 callback mechanism. Basically a perl subroutine can be registered as a 
 callback routine in exactly the same way as in a C program that uses the
 XForms library. In order to make this possible, various different schemes
 are utilized so that most of the callbacks that can be registered with
 the XForms library are available to perl programs. The basic idea is tha
 the SV pointer of the perl subroutine is saved in an appropriate place
 and a generic C subroutine is registered with the XForms library. When this
 routine is called-back, it finds the SV pointer of the appropriate perl
 subroutine and invokes it.
 
 ******************************************************************************
 ******************************************************************************
 *****************************************************************************/


/*
 * Application atclose callback
 */
static SV *		application_atclose_ptr = NULL;

/*
 * Anchor for io callback routines
 */
static io_data *	io_cb = NULL;

/*
 * These routines are registered with the XForms library as the real callbacks
 * when the perl program requires a callback. They find the pointer to the
 * perl subroutine and call it via a generic perl-subroutine-invoker that does
 * all the specific gunge of setting up the perl stack, calling the subroutine
 * and returning a value (only an int return value is allowed if any is
 * required).
 */

static int
process_form_raw_callback(form,parm)
FLForm * 	form;
void *		parm;
{
	/*
	 * Raw callback processor
         */

	SV *	form_callback_ptr =
		(get_form_data(form))->fd_rawcallback;

	if (form_callback_ptr == NULL)
		croak("Form raw callack routine not set");
	return call_perl_callback(form_callback_ptr, 
				  TRUE, 
				  "Fp", 
				  form, parm);
}    

static int
process_atclose(form,parm)
FLForm * 	form;
void *		parm;
{
	/*
	 * Generic at-close callback 
         */

	if (application_atclose_ptr == NULL)
		croak("Application atclose routine not set");
	return call_perl_callback(application_atclose_ptr, 
				  TRUE, 
				  "Fp", 
				  form, parm);
}    

static int
process_form_atclose(form,parm)
FLForm * 	form;
void *		parm;
{
	/*
	 * Generic form at-close callback
         */

	SV *	form_callback_ptr =
		(get_form_data(form))->fd_atclose;

	if (form_callback_ptr == NULL)
		croak("Form atclose routine not set");
	return call_perl_callback(form_callback_ptr, 
				  TRUE, 
				  "Fp", 
				  form, parm);
}    

static void
process_object_callback(object, parm)
FLObject * 	object;
long		parm;
{

	/*
	 * Generic object callback
         */

	SV *	object_callback_ptr =
		(get_object_data(object))->od_callback;

	if (object_callback_ptr == NULL)
		croak("Object callback routine not set");
	call_perl_callback(object_callback_ptr, 
			  FALSE, 
			  "Op", 
			  object, parm);

}    

static int
process_input_filter(object, parm1, parm2, parm3)
FLObject * 	object;
const char *	parm1;
const char *	parm2;
int		parm3;
{

	/*
	 * Generic counter filter process
         */

	SV *	object_callback_ptr =
		(get_object_data(object))->od_input_filter;

	if (object_callback_ptr == NULL)
		croak("Input filter routine not set");
	call_perl_callback(object_callback_ptr, 
			  TRUE, 
			  "Ossi", 
			  object, parm1, parm2, parm3);

}    

static void
process_brdbl_callback(object, parm)
FLObject * 	object;
long		parm;
{

	/*
	 * Generic browser double-click callback
         */

	SV *	object_callback_ptr =
		(get_object_data(object))->od_brdbl_callback;

	if (object_callback_ptr == NULL)
		croak("Browser double-click callback routine not set");
	call_perl_callback(object_callback_ptr, 
			  FALSE, 
			  "Op", 
			  object, parm);

}    

static void
process_form_callback(object,parm)
FLObject * 	object;
void *		parm;
{

	/*
	 * Generic form callback
         */

	SV *	form_callback_ptr =
		(get_form_data(object->form))->fd_callback;

	if (form_callback_ptr == NULL)
		croak("Form callback routine not set");
	call_perl_callback(form_callback_ptr, 
			  FALSE, 
			  "Op", 
			  object, parm);
}    

static void
process_form_atactivate(form,parm)
FLForm * 	form;
void *		parm;
{

	/*
	 * Generic form at-activate callback
         */

	SV *	form_callback_ptr =
		(get_form_data(form))->fd_atactivate;

	if (form_callback_ptr == NULL)
		croak("Form atactivate routine not set");
	call_perl_callback(form_callback_ptr, 
			  FALSE, 
			  "Fp", 
			  form, parm);
}    

static void
process_form_atdeactivate(form,parm)
FLForm * 	form;
void *		parm;
{

	/*
	 * Generic form at-deactivate callback
         */

	SV *	form_callback_ptr =
		(get_form_data(form))->fd_atdeactivate;

	if (form_callback_ptr == NULL)
		croak("Form atdeactivate routine not set");
	call_perl_callback(form_callback_ptr, 
			  FALSE, 
			  "Fp", 
			  form, parm);
}    

static int
process_make_handle(object,int1,x,y,int4,parm)
FLObject * 	object;
int		int1;
FL_Coord	x;
FL_Coord	y;
int		int4;
void *		parm;
{

	/*
	 * Generic make object handle
         */

	SV *	object_callback_ptr =
		(get_object_data(object))->od_makehandler;

	if (object_callback_ptr == NULL)
		croak("Make Object Handler routine not set");
	return call_perl_callback(object_callback_ptr, 
				  TRUE, 
				  "Oiiiip", 
				  object,int1,x,y,int4, parm);
}    

static int
process_object_prehandler(object,int1,x,y,int4,parm)
FLObject * 	object;
int		int1;
FL_Coord	x;
FL_Coord	y;
int		int4;
void *		parm;
{

	/*
	 * Generic object pre-handle
         */

	SV *	object_callback_ptr =
		(get_object_data(object))->od_prehandler;

	if (object_callback_ptr == NULL)
		croak("Object Pre-Handler routine not set");
	return call_perl_callback(object_callback_ptr, 
				  TRUE, 
				  "Oiiiip", 
				  object,int1,x,y,int4, parm);
}    

static int
process_object_posthandler(object,int1,x,y,int4,parm)
FLObject * 	object;
int		int1;
FL_Coord	x;
FL_Coord	y;
int		int4;
void *		parm;
{

	/*
	 * Generic object post-handle
         */

	SV *	object_callback_ptr =
		(get_object_data(object))->od_posthandler;

	if (object_callback_ptr == NULL)
		croak("Object Post-Handler routine not set");
	return call_perl_callback(object_callback_ptr, 
				  TRUE, 
				  "Oiiiip", 
				  object,int1,x,y,int4, parm);
}    

static void
process_io_event_callback(fd,parm)
int  		fd;
void *		parm;
{
	/*
	 *  IO event calback
         */

	io_data	*this = (io_data *)parm;
	call_perl_callback(this->callback, 
			   FALSE, 
			   "ip", 
			   fd,this->parm);
}    

/*
 * The rest is XSUB code to implement the interface between PERL and XForms
 */


MODULE = Forms_BASIC		PACKAGE = Forms_BASIC

void 
fl_add_io_callback(fd,condition,callback,parm)
	int		fd 
	unsigned	condition 
	SV *		callback 
	void *		parm
	CODE:
	{
		io_data	*this,	**prev = &io_cb;

		/*
		 * Now see if this fd/condition pair has a callback
		 * already set.
		 */
		while ((this = *prev) && 
		(this->fd != fd || this->condition != condition ))
			prev = &(this->next_data);

		if (!this) {
			/* 
			 * No callback was found, get a new io_data
			 * area and chain the end of the list for
			 * the current event
			 */
			this = *prev =
				(io_data *)calloc(1, sizeof(io_data));
		}
		/*
		 * Now save the callback pointer and call the
		 * XForm library function, using the io_data pointer
		 * as the parm
		 */
		this->callback = callback;
		this->fd = fd; 
		this->condition = condition; 
		this->parm = parm; 

		fl_add_io_callback(fd, condition, 
				   process_io_event_callback,
				   this);
	}

void 
fl_remove_io_callback(fd,condition)
	int		fd 
	unsigned	condition 
	CODE:
	{
		io_data	*this,	**prev = &io_cb;

		/*
		 * Now see if this fd/condition pair has a callback set
		 */
		while ((this = *prev) && 
		(this->fd != fd || this->condition != condition ))
			prev = &(this->next_data);

		if (this) {
			/* 
			 * A callback was found, remove from the chain,
			 * and free the data area 
			 */
			*prev = this->next_data;
			free(this);
		}
		/*
		 * Now call the XForm library function
		 */
		fl_remove_io_callback(fd, condition, 
				      process_io_event_callback);
	}

FLForm *
fl_bgn_form(box_type,width,height)
	int		box_type
	int		width
	int		height

void
fl_end_form()

FLObject *
fl_do_forms()

FLObject *
fl_check_forms()

FLObject *
fl_do_only_forms()

FLObject *
fl_check_only_forms()

void
fl_freeze_form(form)
	FLForm *	form

void
fl_set_focus_object(form,object)
	FLForm *	form
	FLObject *	object

void
fl_set_form_atclose(form,callback,ptr)
	FLForm *	form
	SV *		callback
	IV 		ptr
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_form_data(form)->fd_atclose), 
			       callback);
		fl_set_form_atclose(form, 
			(callback == NULL ? NULL : process_form_atclose),
			(void *)ptr);
	}

void
fl_set_atclose(callback,ptr)
	SV *		callback
	IV 		ptr
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(application_atclose_ptr), 
			       callback);
		fl_set_atclose((callback == NULL ? NULL : process_atclose),
			      (void *)ptr);
	} 

void
fl_set_form_atactivate(form,callback,ptr)
	FLForm *	form
	SV *		callback
	IV 		ptr
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_form_data(form)->fd_atactivate), 
			       callback);
		fl_set_form_atactivate(form, 
			(callback == NULL ? NULL : process_form_atactivate),
			(void *)ptr);
	} 

void
fl_set_form_atdeactivate(form,callback,ptr)
	FLForm *	form
	SV *		callback
	IV 		ptr
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_form_data(form)->fd_atdeactivate), 
			       callback);
		fl_set_form_atdeactivate(form, 
			(callback == NULL ? NULL : process_form_atdeactivate),
			(void *)ptr);
	} 

void
fl_unfreeze_form(form)
	FLForm *	form

void
fl_deactivate_form(form)
	FLForm *	form

void
fl_activate_form(form)
	FLForm *	form

void
fl_deactivate_all_forms()

void
fl_activate_all_forms()

void
fl_freeze_all_forms()

void
fl_unfreeze_all_forms()

void
fl_scale_form(form,xfact,yfact)
	FLForm *	form
	double		xfact
	double		yfact

void
fl_set_form_position(form,x,y)
	FLForm *	form
	int		x
	int		y

void
fl_set_form_title(form,title)
	FLForm *	form
	const char *	title

void
fl_set_form_property(form,property)
	FLForm *	form
	unsigned	property

void
fl_set_app_nomainform(i)
	int		i

void
fl_set_app_mainform(form)
	FLForm *	form

void
fl_raise_form(form)
	FLForm *	form

void
fl_lower_form(form)
	FLForm *	form

FLForm *
fl_get_app_mainform()

void
fl_set_form_callback(form,callback,ptr)
	FLForm *	form
	SV *		callback
	IV 		ptr
	CODE:
	{
		form_data *fmdat = get_form_data(form);

		SAVESV(fmdat->fd_callback, callback);
		fl_set_form_callback(form, 
			(callback == NULL ? NULL : process_form_callback),
			(void *)ptr);
	} 

void
fl_set_form_size(form,width,height)
	FLForm *	form
	int		width
	int		height

void
fl_set_form_hotspot(form,x,y)
	FLForm *	form
	int		x
	int		y

void
fl_set_form_hotobject(form,object)
	FLForm *	form
	FLObject *	object

void
fl_set_form_minsize(form,width,height)
	FLForm *	form
	int		width
	int		height

void
fl_set_form_maxsize(form,width,height)
	FLForm *	form
	int		width
	int		height

void
fl_set_form_event_cmask(form,mask)
	FLForm *	form
	unsigned long	mask

unsigned long
fl_get_form_event_cmask(form)
	FLForm *	form

void
fl_set_form_geometry(form,x,y,width,height)
	FLForm *	form
	int		x
	int		y
	int		width
	int		height

long
fl_show_form(form,placement,border,formname)
	FLForm *	form
	int		placement
	int		border
	char *		formname

void
fl_hide_form(form)
	FLForm *	form

void
fl_free_form(form)
	FLForm *	form

void
fl_redraw_form(form)
	FLForm *	form

void
fl_set_form_dblbuffer(form,dbl)
	FLForm *	form
	int		dbl

long
fl_prepare_form_window(form,placement,border,formname)
	FLForm *	form
	int		placement
	int		border
	char *		formname

void
fl_show_form_window(form)
	FLForm *	form

void
fl_register_raw_callback(form,mask,callback)
	FLForm *	form
	unsigned long	mask
	SV *		callback
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_form_data(form)->fd_rawcallback), 
			       callback);
		fl_register_raw_callback(form, mask,
			(callback == NULL ? NULL : process_form_raw_callback));
	} 

int
fl_mode_capable(mode,warn)
	int		mode
	int		warn

FLObject *
fl_bgn_group()
	CODE:
	{
		RETVAL = fl_bgn_group();	
		RETVAL->u_vdata = NULL;
	}

FLObject *
fl_end_group()
	CODE:
	{
		RETVAL = fl_end_group();	
		RETVAL->u_vdata = NULL;
	}

void
fl_set_object_boxtype(object,boxtype)
	FLObject *	object
	int		boxtype

void
fl_set_object_automatic(object,bw)
	FLObject *	object
	int		bw

void
fl_set_object_bw(object,bw)
	FLObject *	object
	int		bw

void
fl_set_object_resize(object,how)
	FLObject *	object
	unsigned 	how

void
fl_set_object_gravity(object,nwgrav,segrav)
	FLObject *	object
	unsigned 	nwgrav
	unsigned 	segrav

void
fl_set_object_lsize(object,lsize)
	FLObject *	object
	int		lsize

void
fl_set_object_lstyle(object,lstyle)
	FLObject *	object
	int		lstyle

void
fl_set_object_lcol(object,color)
	FLObject *	object
	unsigned long	color

void
fl_set_object_return(object,dnd)
	FLObject *	object
	int		dnd

void
fl_set_object_lalign(object,align)
	FLObject *	object
	int		align

void
fl_set_object_shortcut(object,shortcut,show)
	FLObject *	object
	char *		shortcut
	int		show

void
fl_set_object_shortcutkey(object,show)
	FLObject *	object
	unsigned int	show

void
fl_set_object_dblbuffer(object,dbl)
	FLObject *	object
	int		dbl

void
fl_set_object_color(object,color1,color2)
	FLObject *	object
	unsigned long	color1
	unsigned long	color2

void
fl_fit_object_label(object,x,y)
	FLObject *	object
	FL_Coord	x
	FL_Coord	y

void
fl_set_object_label(object,label)
	FLObject *	object
	char *		label

void
fl_set_object_position(object,x,y)
	FLObject *	object
	int		x
	int		y

void
fl_set_object_size(object,x,y)
	FLObject *	object
	int		x
	int		y

void
fl_set_object_geometry(object,x,y,xl,yl)
	FLObject *	object
	int		x
	int		y
	int		xl
	int		yl

void
fl_get_object_geometry(object)
	FLObject *	object
	PPCODE:
	{
		int x, y, xl, yl;

		fl_get_object_geometry(object, &x, &y, &xl, &yl);
		EXTEND(sp, 4);
		PUSHs(sv_2mortal(newSViv(x)));
		PUSHs(sv_2mortal(newSViv(y)));
		PUSHs(sv_2mortal(newSViv(xl)));
		PUSHs(sv_2mortal(newSViv(yl)));
	}

void
fl_get_object_position(object)
	FLObject *	object
	PPCODE:
	{
		int x, y;

		fl_get_object_position(object, &x, &y);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSViv(x)));
		PUSHs(sv_2mortal(newSViv(y)));
	}

void
fl_compute_object_geometry(object)
	FLObject *	object
	PPCODE:
	{
		int x, y, xl, yl;

		fl_get_object_geometry(object, &x, &y, &xl, &yl);
		EXTEND(sp, 4);
		PUSHs(sv_2mortal(newSViv(x)));
		PUSHs(sv_2mortal(newSViv(y)));
		PUSHs(sv_2mortal(newSViv(xl)));
		PUSHs(sv_2mortal(newSViv(yl)));
	}

void 
fl_call_object_callback(object)
	FLObject *	object

void
fl_set_object_callback(object,callback,parm)
	FLObject *	object
	SV *		callback
	long		parm
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_object_data(object)->od_callback), 
			       callback);
		fl_set_object_callback(object, 
			(callback == NULL ? NULL : process_object_callback), 
			parm);
	} 

void
fl_set_object_prehandler(object,callback)
	FLObject *	object
	SV *		callback
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_object_data(object)->od_prehandler), 
			       callback);
		fl_set_object_prehandler(object, 
			(callback == NULL ? NULL : process_object_prehandler));
	} 

void
fl_set_object_posthandler(object,callback)
	FLObject *	object
	SV *		callback
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_object_data(object)->od_posthandler), 
			       callback);
		fl_set_object_posthandler(object, 
			(callback == NULL ? NULL : process_object_posthandler));
	} 

void
fl_redraw_object(object)
	FLObject *	object

void
fl_scale_object(object,xscale,yscale)
	FLObject *	object
	double		xscale
	double		yscale

void
fl_show_object(object)
	FLObject *	object

void
fl_hide_object(object)
	FLObject *	object

void
fl_free_object(object)
	FLObject *	object

void
fl_delete_object(object)
	FLObject *	object

void
fl_trigger_object(object)
	FLObject *	object

void
fl_activate_object(object)
	FLObject *	object

void
fl_deactivate_object(object)
	FLObject *	object

void
fl_set_font_name(num,string)
	int		num
	char *		string

void
fl_set_font(val1,val2)
	int		val1
	int		val2

int
fl_get_char_width(val1,val2)
	int		val1
	int		val2

void 
fl_get_char_height(style,size)
	int		style
	int		size
	PPCODE:
	{
		int	result, ascend, descend;
	
		result = fl_get_char_height(style,size,&ascend,&descend);

		EXTEND(sp, 3);
		PUSHs(sv_2mortal(newSViv(result)));
		PUSHs(sv_2mortal(newSViv(ascend)));
		PUSHs(sv_2mortal(newSViv(descend)));
	}

void
fl_get_string_height(style,size,string,length)
	int		style
	int		size
	const char *	string
	int		length
	PPCODE:
	{
		int	result, ascend, descend;
	
		result = fl_get_string_height(	style,
						size,
						string,
						length,
						&ascend,
						&descend);

		EXTEND(sp, 3);
		PUSHs(sv_2mortal(newSViv(result)));
		PUSHs(sv_2mortal(newSViv(ascend)));
		PUSHs(sv_2mortal(newSViv(descend)));
	}

int 
fl_get_string_width(style,size,string,length)
        int             style
        int             size
        const char *    string
        int             length

int 
fl_get_string_widthTAB(style,size,string,length)
        int             style
        int             size
        const char *    string
        int             length


void 
fl_get_string_dimension(style,size,string,length)
        int             style
        int             size
        const char *    string
        int             length
        PPCODE:
        {
                int     ascend, descend;

                fl_get_string_dimension(style,
                                        size,
                                        string,
                                        length,
                                        &ascend,
                                        &descend);

                EXTEND(sp, 3);
                PUSHs(sv_2mortal(newSViv(ascend)));
                PUSHs(sv_2mortal(newSViv(descend)));
        }

void 
fl_get_align_xy(int1,int2,int3,int4,int5,int6,int7,int8,int9)
        int             int1
        int             int2
        int             int3
        int             int4
        int             int5
        int             int6
        int             int7
        int             int8
        int             int9
        PPCODE:
        {
                int     int10, int11;

                fl_get_align_xy(int1, int2, int3, int4, int5,
				int6, int7, int8, int9, 
				&int10, &int11);

                EXTEND(sp, 2);
                PUSHs(sv_2mortal(newSViv(int10)));
                PUSHs(sv_2mortal(newSViv(int11)));
        }


unsigned long 
fl_mapcolor(c,r,g,b)
	FL_COLOR	c
	int		r
	int		g
	int		b

unsigned long 
fl_mapcolorname(c,s)
	FL_COLOR	c
	const char *	s

void
fl_getmcolor(c)
	FL_COLOR	c
	PPCODE:
	{
		int 	r, g, b;
		unsigned long	result;

		fl_getmcolor(c,&r,&g,&b); 

                EXTEND(sp, 4);
                PUSHs(sv_2mortal(newSViv(result)));
                PUSHs(sv_2mortal(newSViv(r)));
                PUSHs(sv_2mortal(newSViv(g)));
                PUSHs(sv_2mortal(newSViv(b)));
        }

void 
fl_free_colors(...)
	CODE:
	{
		FL_COLOR 	*colors;
		int	i = 1, color, numpts = 0;

		if (items < 1)
    			croak("usage: fl_free_colors(color,(color,....))");
		
		colors = (FL_COLOR *)calloc(items, sizeof(FL_COLOR));
		for (i=0; i<items; i++)
			colors[i] = SvIV(ST(i));

		fl_free_colors(colors, items);
		free((void *)colors);
	}

void 
fl_free_pixels(...)
	CODE:
	{
		unsigned long 	*pixels;
		int	i = 1;

		if (items < 1)
    			croak("usage: fl_free_pixels(pixel,(pixel,....))");
		
		pixels = (unsigned long *)calloc(items, sizeof(unsigned long));
		for (i=0; i<items; i++)
			pixels[i] = SvIV(ST(i));

		fl_free_pixels(pixels, items);
		free((void *)pixels);
	}

void 
fl_set_color_leak(i)
	int		i

unsigned long 
fl_get_pixel(c)
	FL_COLOR	c

void 
fl_get_icm_color(c)
	FL_COLOR	c
	PPCODE:
	{
		int 	r, g, b;

		fl_get_icm_color(c,&r,&g,&b); 

                EXTEND(sp, 3);
                PUSHs(sv_2mortal(newSViv(r)));
                PUSHs(sv_2mortal(newSViv(g)));
                PUSHs(sv_2mortal(newSViv(b)));
        }

void 
fl_set_icm_color(c,i1,i2,i3)
	FL_COLOR	c 
	int		i1
	int		i2
	int		i3

void 
fl_color(c)
	FL_COLOR	c

void 
fl_bk_color(c)
        FL_COLOR        c

void 
fl_textcolor(c)
        FL_COLOR        c

void 
fl_bk_textcolor(c)
        FL_COLOR        c

void 
fl_set_gamma(d1,d2,d3)
	double		d1
	double		d2
	double		d3

void 
fl_show_errors(i)
	int		i

FLForm *
fl_current_form()
	CODE:
	{
		RETVAL = fl_current_form; 
	}

Display *
fl_display()
	CODE:
	{
		RETVAL = fl_display;
	}
	OUTPUT:
	RETVAL

int
fl_vmode()
	CODE:
	{
		RETVAL = fl_vmode;
	}
	OUTPUT:
	RETVAL

int
fl_screen()
	CODE:
	{
		RETVAL = fl_screen;
	}
	OUTPUT:
	RETVAL

Window
fl_default_window()

void
fl_add_object(form,object)
	FLForm *	form
	FLObject *	object

void
fl_addto_form(form)
	FLForm *	form

FLObject *
fl_make_object(type,int2,x,y,width,height,label,handle)
	int		type
	int		int2
	int		x
	int		y
	int		width
	int		height
	const char *	label
	SV *		handle
	CODE:
	{
		object_data *obdat;

		RETVAL = fl_make_object(type,int2,x,y,width,
					height,label,
					(handle == NULL ? NULL : 
					process_make_handle));
		RETVAL->u_vdata = NULL;
		obdat = get_object_data(RETVAL);
		SAVESV(obdat->od_makehandler, handle);
	} 
	OUTPUT:
	RETVAL

void
fl_set_coordunit(unit)
	int		unit

int
fl_get_coordunit()

void
fl_set_border_width(width)
	int		width

int
fl_get_border_width()

void
fl_get_mouse()
	PPCODE:
	{
		Window		win;
		FL_Coord	x, y;
		unsigned int	i1;

		win = fl_get_mouse(&x, &y, &i1);
		EXTEND(sp, 4);
		PUSHs(sv_2mortal(newSViv(win)));
		PUSHs(sv_2mortal(newSViv(x)));
		PUSHs(sv_2mortal(newSViv(y)));
		PUSHs(sv_2mortal(newSViv(i1)));
	}

void
fl_set_mouse(x,y)
	int		x
	int		y

void
fl_get_form_mouse(form)
	FLForm *	form
	PPCODE:
	{
		Window		win;
		FL_Coord	x, y;
		unsigned int	i1;

		win = fl_get_form_mouse(form, &x, &y, &i1);
		EXTEND(sp, 4);
		PUSHs(sv_2mortal(newSViv(win)));
		PUSHs(sv_2mortal(newSViv(x)));
		PUSHs(sv_2mortal(newSViv(y)));
		PUSHs(sv_2mortal(newSViv(i1)));
	}

void
fl_finish()

void 
fl_set_graphics_mode(int1,int2)
	int		int1
	int		int2

Display *
fl_initialize(appclass)
	char *		appclass;
	CODE: 
	{

		/*
		 * fl_initialize can process the command line
		 * options and alter them. Therefore we need to
		 * reuild the argc and argv variables in c form.
		 * This is done by taking the $0 scalar and
		 * adding the contents of @ARGV such that we
		 * have the char** format expected by fl_initialize
		 */

		int	num_args, size_args, i;
		I32	num_argv;
		AV*	perl_argv = perl_get_av("ARGV", FALSE);
		SV*	temp_sv, *perl_argv_0 = perl_get_sv("0", FALSE);
		char*   argv_mem, **fl_argv, **temp_argv;

		/*
		 * Get the number of ARGV array members
		 * and the length of the $0 scalar
		 */

		num_argv = av_len(perl_argv);
		size_args = strlen(SvPV(perl_argv_0,na)) + 1;

		/*
		 * Add the total size of ARGV array members
		 */

		for (num_args = 0; num_args <= num_argv; ++num_args ) {
			size_args += strlen(SvPV(*av_fetch(perl_argv, num_args, 0),na)) + 1; 
		}

		/*
		 * Get some storage of that size
		 */

		fl_argv = temp_argv = 
			calloc(1, size_args+(++num_args*sizeof(temp_argv)));

		/*
		 * Make the top bit the char * and the rest 
		 * contains the argv strings themselves
		 */

		(char **) argv_mem = fl_argv + num_args;
		
		fl_argv[0] = argv_mem;
		argv_mem += strlen(strcpy(argv_mem,SvPV(perl_argv_0,na))) + 1;

		for (i = 0; i <= num_argv; ++i ) {
			fl_argv[i+1] = argv_mem;
			argv_mem += strlen(strcpy(argv_mem,
				  SvPV(*av_fetch(perl_argv, i, 0),na))) + 1; 
		}

		/*
		 * NOW call fl_initialize, saving current argc
		 */

		num_argv = num_args;
		RETVAL = fl_initialize(&num_args, fl_argv, appclass, 0, 0);

		if (num_args < num_argv) {
			/*
			 * An ARGV variable was changed so clear the
			 * ARGV array and rebuild it
			 */

			av_clear(perl_argv);

			for (i = 1; i < num_args; ++i) {
				av_push(perl_argv, newSVpv(fl_argv[i], 0));
			}
		}
		
		free(fl_argv);
	}
	OUTPUT:
	RETVAL

void 
fl_set_tabstop(intp)
	char *		intp

int 
fl_get_visual_depth()

const char *
fl_vclass_name(intp)
	int		intp

int 
fl_vclass_val(string)
	const char *	string

void 
fl_set_ul_property(int1,int2)
	int		int1
	int		int2

void 
fl_set_clipping(x,y,xl,yl)
	int		x
	int		y
	int		xl
	int		yl

void 
fl_set_text_clipping(x,y,xl,yl)
	int		x 
	int		y 
	int		xl 
	int		yl

void 
fl_unset_text_clipping()

void 
fl_set_clippings(x,y,xl,yl,int1)
	int		x
	int		y
	int		xl
	int		yl
	int		int1
	CODE:
	{
		XRectangle	xrect;
		
		xrect.x = x;
		xrect.y = y;
		xrect.width = xl;
		xrect.height = yl;

		fl_set_clippings(&xrect, int1);
	}

void 
fl_unset_clipping()

FLObject *
fl_create_flobject(otype,type,x,y,width,height,label)
	int		otype
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = (create_funcs[otype])(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of object type %i failed", otype);
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

FLObject *
fl_add_flobject(otype,type,x,y,width,height,label)
	int		otype
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = (add_funcs[otype])(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of object type %i failed", otype);
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

void
fl_set_bitmap_file(object,file)
	FLObject *	object
	char *		file

void
fl_set_pixmap_file(object,file)
	FLObject *	object
	char *		file

void 
fl_set_pixmap_align(obj,int1,int2,int3)
	FLObject *	obj 
	int 		int1
	int 		int2
	int		int3

void 
fl_set_pixmap_colorcloseness(int1,int2,int3)
	int 		int1
	int 		int2
	int		int3

void 
fl_free_pixmap_pixmap(obj)
	FLObject *	obj 

void
fl_clear_browser(object)
	FLObject *	object

void
fl_add_browser_line(object,line)
	FLObject *	object
	char *		line

void
fl_addto_browser(object,line)
	FLObject *	object
	char *		line

void
fl_insert_browser_line(object,place,line)
	FLObject *	object
	int		place
	char *		line

void
fl_delete_browser_line(object,place)
	FLObject *	object
	int		place

void
fl_replace_browser_line(object,place,line)
	FLObject *	object
	int		place
	char *		line

const char *
fl_get_browser_line(object,place)
	FLObject *	object
	int		place

void
fl_load_browser(object,file)
	FLObject *	object
	char *		file

void
fl_select_browser_line(object,place)
	FLObject *	object
	int		place

void
fl_deselect_browser_line(object,place)
	FLObject *	object
	int		place

void
fl_deselect_browser(object)
	FLObject *	object

int
fl_isselected_browser_line(object,place)
	FLObject *	object
	int		place

int
fl_get_browser_topline(object)
	FLObject *	object

int
fl_get_browser(object)
	FLObject *	object

int
fl_get_browser_maxline(object)
	FLObject *	object

int
fl_get_browser_screenlines(object)
	FLObject *	object

void
fl_set_browser_topline(object,line)
	FLObject *	object
	int		line

void
fl_set_browser_fontsize(object,size)
	FLObject *	object
	int		size

void
fl_set_browser_fontstyle(object,style)
	FLObject *	object
	int		style

void
fl_set_browser_specialkey(object,key)
	FLObject *	object
	int		key

void
fl_set_browser_vscrollbar(object,sl)
	FLObject *	object
	int		sl

void
fl_set_browser_leftslider(object,sl)
	FLObject *	object
	int		sl

void
fl_set_browser_line_selectable(object,int1,int2)
	FLObject *	object
	int		int1
	int		int2

int
fl_get_browser_dimension(object)
	FLObject *	object
	PPCODE:
	{
		FL_Coord	x, y, xl, yl;

		fl_get_browser_dimension(object, &x, &y, &xl, &yl);
		EXTEND(sp, 4);
		PUSHs(sv_2mortal(newSViv(x)));
		PUSHs(sv_2mortal(newSViv(y)));
		PUSHs(sv_2mortal(newSViv(xl)));
		PUSHs(sv_2mortal(newSViv(yl)));
	}

void 
fl_set_browser_dblclick_callback(object,callback,parm)
	FLObject *	object
	SV *		callback
	long		parm
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_object_data(object)->od_brdbl_callback), 
			       callback);
		fl_set_object_callback(object, 
			(callback == NULL ? NULL : process_brdbl_callback), 
			parm);
	} 

void 
fl_set_browser_xoffset(object,x)
	FLObject *	object
	FL_Coord	x

void
fl_set_bitmapbutton_file(object,file)
	FLObject *	object
	char *		file

int
fl_get_button(object)
	FLObject *	object

int
fl_get_button_numb(object)
	FLObject *	object

void
fl_set_button(object,value)
	FLObject *	object
	int		value

FLObject *
fl_create_generic_button(type,i,x,y,width,height,label)
	int		type
	int		i
	int		x
	int		y
	int		width
	int		height
	char *		label

void
fl_get_clock(object)
	FLObject *	object
	PPCODE:
	{
		int hrs, min, sec;

		fl_get_clock(object, &hrs, &min, &sec);
		EXTEND(sp, 3);
		PUSHs(sv_2mortal(newSViv(hrs)));
		PUSHs(sv_2mortal(newSViv(min)));
		PUSHs(sv_2mortal(newSViv(sec)));
	}

void 
fl_set_cursor(window,int1)
	Window		window
	int		int1

void 
fl_set_cursor_color(int1,col1,col2)
	int		int1
	FL_COLOR	col1
	FL_COLOR	col2

int 
fl_create_bitmap_cursor(str1,str2,int1,int2,int3,int4)
	const char *	str1 
	const char *	str2
	int		int1
	int		int2
	int		int3
	int		int4

Cursor 
fl_get_cursor_byname(int1)
	int		int1

void
fl_set_input_color(object,col1,col2)
	FLObject *	object
	int		col1
	int		col2

void
fl_set_input(object,string)
	FLObject *	object
	char *		string

void
fl_set_input_return(object,value)
	FLObject *	object
	int		value

void
fl_set_input_scroll(object,value)
	FLObject *	object
	int		value

void
fl_set_input_cursorpos(object,value1,value2)
	FLObject *	object
	int		value1
	int		value2

void
fl_get_input_cursorpos(object)
	FLObject *	object
	PPCODE:
	{
		int i, x, y;

		i = fl_get_input_cursorpos(object, &x, &y);
		EXTEND(sp, 3);
		PUSHs(sv_2mortal(newSViv(i)));
		PUSHs(sv_2mortal(newSViv(x)));
		PUSHs(sv_2mortal(newSViv(y)));
	}

void
fl_set_input_selected(object,value)
	FLObject *	object
	int		value

const char *
fl_get_input(object)
	FLObject *	object

void
fl_set_input_selected_range(object,val1,val2)
	FLObject *	object
	int		val1
	int		val2

void
fl_set_input_maxchars(object,value)
	FLObject *	object
	int		value

void
fl_set_input_filter(object,callback)
	FLObject *	object
	SV *		callback
	CODE:
	{
		return_save_sv(&(ST(0)), 
			       &(get_object_data(object)->od_input_filter), 
			       callback);
		fl_set_input_filter(object, 
			(callback == NULL ? NULL : process_input_filter)); 
	} 

void
fl_set_timer(object,val)
	FLObject *	object
	double		val

double
fl_get_timer(object)
	FLObject *	object

MODULE = Forms_BASIC		PACKAGE = FLFormPtr 	PREFIX = fl_form_

void *
fl_form_u_vdata(form,...)
	FLForm *	form
	CODE:
	{
		if (items > 2 || items < 1)
			croak("usage: $form->u_vdata to read, or $form->u_vdata($ptr) to write");
		if (items == 2)
			get_form_data(form)->u_vdata = (void *)SvIV(ST(1));
		RETVAL = get_form_data(form)->u_vdata;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_form_x(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->x;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_form_y(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->y;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_form_w(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->w;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_form_h(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->h;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_form_hotx(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->hotx;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_form_hoty(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->hoty;
	}
	OUTPUT:
	RETVAL

Window
fl_form_window(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->window;
	}
	OUTPUT:
	RETVAL

int 
fl_form_vmode(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->vmode;
	}
	OUTPUT:
	RETVAL

int 
fl_form_deactivated(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->deactivated;
	}
	OUTPUT:
	RETVAL

int 
fl_form_use_pixmap(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->use_pixmap;
	}
	OUTPUT:
	RETVAL

int 
fl_form_frozen(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->frozen;
	}
	OUTPUT:
	RETVAL

int 
fl_form_visible(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->visible;
	}
	OUTPUT:
	RETVAL

int 
fl_form_wm_border(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->wm_border;
	}
	OUTPUT:
	RETVAL

unsigned int 
fl_form_prop(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->prop;
	}
	OUTPUT:
	RETVAL

int 
fl_form_has_auto(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->has_auto;
	}
	OUTPUT:
	RETVAL

int 
fl_form_top(form)
	FLForm *	form
	CODE:
	{
		RETVAL = form->top;
	}
	OUTPUT:
	RETVAL


MODULE = Forms_BASIC		PACKAGE = FLObjectPtr 	PREFIX = fl_object_

FLForm *
fl_object_form(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->form; 
	}
	OUTPUT:
	RETVAL

long
fl_object_u_ldata(object,...)
	FLObject *	object
	CODE:
	{
		if (items > 2 || items < 1)
			croak("usage: $obj->u_ldata to read, or $obj->u_ldata($long) to write");
		if (items == 2)
			object->u_ldata = SvNV(ST(1));
		RETVAL = object->u_ldata;
	}
	OUTPUT:
	RETVAL

void *
fl_object_u_vdata(object,...)
	FLObject *	object
	CODE:
	{
		if (items > 2 || items < 1)
			croak("usage: $obj->u_vdata to read, or $obj->u_vdata($ptr) to write");
		if (items == 2)
			get_object_data(object)->u_vdata = (void *)SvIV(ST(1));
		RETVAL = get_object_data(object)->u_vdata;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_object_x(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->x;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_object_y(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->y;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_object_w(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->w;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_object_h(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->h;
	}
	OUTPUT:
	RETVAL

FL_Coord
fl_object_bw(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->bw;
	}
	OUTPUT:
	RETVAL

FL_COLOR
fl_object_col1(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->col1;
	}
	OUTPUT:
	RETVAL

FL_COLOR
fl_object_col2(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->col2;
	}
	OUTPUT:
	RETVAL

FL_COLOR
fl_object_lcol(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->lcol;
	}
	OUTPUT:
	RETVAL

char *
fl_object_label(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->label;
	}
	OUTPUT:
	RETVAL

int
fl_object_align(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->align;
	}
	OUTPUT:
	RETVAL

int
fl_object_boxtype(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->boxtype;
	}
	OUTPUT:
	RETVAL

int
fl_object_lsize(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->lsize;
	}
	OUTPUT:
	RETVAL

int
fl_object_lstyle(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->lstyle;
	}
	OUTPUT:
	RETVAL

int
fl_object_visible(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->visible;
	}
	OUTPUT:
	RETVAL

Window
fl_object_window(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->form->window;
	}
	OUTPUT:
	RETVAL

int
fl_object_pushed(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->pushed;
	}
	OUTPUT:
	RETVAL

int 
fl_object_focus(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->focus;
	}
	OUTPUT:
	RETVAL

int 
fl_object_belowmouse(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->belowmouse;
	}
	OUTPUT:
	RETVAL

int 
fl_object_active(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->active;
	}
	OUTPUT:
	RETVAL

int 
fl_object_input(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->input;
	}
	OUTPUT:
	RETVAL

int 
fl_object_wantkey(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->wantkey;
	}
	OUTPUT:
	RETVAL

int 
fl_object_radio(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->radio;
	}
	OUTPUT:
	RETVAL

int 
fl_object_automatic(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->automatic;
	}
	OUTPUT:
	RETVAL

int 
fl_object_redraw(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->redraw;
	}
	OUTPUT:
	RETVAL

int 
fl_object_clip(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->clip;
	}
	OUTPUT:
	RETVAL

unsigned long 
fl_object_click_timeout(object)
	FLObject *	object
	CODE:
	{
		RETVAL = object->click_timeout;
	}
	OUTPUT:
	RETVAL
