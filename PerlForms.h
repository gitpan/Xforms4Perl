#ifndef PERLFORMS_H
#define PERLFORSM_H
/*   PerlForms.h - An extension to PERL to access XForms functions.
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


typedef FL_FORM         FLForm;
typedef FL_OBJECT       FLObject;

#define	SAVESV(x,y)	do{ if (x == NULL) { \
				x = newSVsv(y); \
			} else { \
			   	SvSetSV(x,y); \
			}} while(0)

void
return_save_sv(SV **stack, SV **old_cb, SV *new_cb) {

	*stack = sv_newmortal();
	if (*old_cb)
		sv_setsv(*stack, *old_cb);
	SAVESV(*old_cb, new_cb);
}

/*
 * The form callback data structure
 */
typedef struct _form_data {
	SV *	po;
	void *  u_vdata;
	SV * 	fd_callback;
	SV * 	fd_prehandler;
	SV * 	fd_posthandler;
	SV *	fd_atactivate;
	SV *	fd_atdeactivate;
	SV *	fd_rawcallback;
	SV *	fd_fselcallback;
	SV *	fd_atclose;
} form_data;

/*
 * This function returns a pointer to the Form-specific callback 
 * data structure that is used to hold the Perl subroutine pointers 
 * that are registered as callbacks. If the structure doesn't 
 * exist for a Form, it callocs it. It is anchored off the 
 * FORM structure's u_vdata field.
 */

static form_data * 
get_form_data(FLForm *form)
{
	if (form->u_vdata == NULL)
		form->u_vdata = calloc(1, sizeof(form_data));
	if (form->u_vdata == NULL)
    		croak("Form user data allocation error");
	return (form_data *)(form->u_vdata);
}

/*
 * Special bless macro for forms (ensures comparison of blessed
 * form pointers gives expected results)
 */
static void
bless_form(FLForm *f) {

	form_data *	sfd;

	if ((sfd = get_form_data(f))->po == NULL) {
		sfd->po = newSViv(0);
		sv_setref_iv(sfd->po,"FLFormPtr",(IV)f);
		SvREFCNT_inc(sfd->po);
	}
}

/*
 * The object callback data structure
 */
typedef struct _object_data {
	SV *	po;
	void *  u_vdata;
	SV * 	od_callback;
	SV * 	od_prehandler;
	SV * 	od_posthandler;
	SV *	od_makehandler;
	SV *	od_freehandler;
	SV *	od_mcpinit;
	SV *	od_mcpact;
	SV *	od_mcpclean;
	SV **	od_cevents;
	SV *	od_count_filter;
	SV *	od_slider_filter;
	SV *	od_input_filter;
	SV *	od_brdbl_callback;
} object_data;

/*
 * This function returns a pointer to the Object-specific callback 
 * data structure that is used to hold the Perl subroutine pointers  
 * that are registered as callbacks. If the structure doesn't 
 * exist for an Object, it callocs it. It is anchored off the 
 * OBJECT structure's u_vdata field.
 */

static object_data *
get_object_data(FLObject *object)
{
	if (object->u_vdata == NULL)
		object->u_vdata = calloc(1, sizeof(object_data));
	if (object->u_vdata == NULL)
    		croak("Object user data allocation error");
	return (object_data *)(object->u_vdata);
}

/*
 * Special bless function for objects (ensures comparison of blessed
 * object pointers gives expected results)
 */
static void
bless_object(FLObject *o) { 

	object_data *	sod;

	if ((sod = get_object_data(o))->po == NULL) { 
		sod->po = newSViv(0); 
		sv_setref_iv(sod->po,"FLObjectPtr",(IV)o); 
		SvREFCNT_inc(sod->po); 
	}
}

/*
 * The data structure used to record XEvent callback subroutines
 */
typedef struct _cb_data {
	struct _cb_data *	next_data;
	Window			window;
	SV *			callback;
} cb_data;

/*
 * The data structure used to record io event callback subroutines
 */
typedef struct _io_data {
	struct _io_data *	next_data;
	int			fd;
	unsigned		condition;
	void *			parm;
	SV *			callback;
} io_data;


/*
 * This function does the real perl-specific stuff involved in calling
 * a perl subroutine registered as a callback.
 */ 
static int
call_perl_callback(SV *callback, int outexpct, char *parmptrn, ...)
{

	/*
	 * Sets up the perl stack, calls the SUB, returns output if required 
	 * This replaces the need for multiple real callback routines.
	 * It accepts a variable length parm list, the first three of
	 * which are required and are:
	 *
	 *	SV *		pointer to perl subroutine to call
	 *	int		boolean indicating whether integer 
	 *			return value is expected.
	 *	char *		a format string, one character for 
	 *			each parm to the perl sub, the chars
	 *			being:
	 *				p - a pointer
	 *				i - an integer
	 *				I - an ival
	 *				s - a string
	 *				e - an XEvent perl object
	 *				F - an FL_FORM perl object
	 *				O - an FL_OBJECT perl object
	 *
	 * the rest of the parms are the arguments to the perl subroutine.
         */

	dSP ;
	
	va_list ap;
	int	count, result, ival;
	IV	Ival;
	double  dval;
	void 	*pval;
	char 	*sval;
	SV 	*tempsv;
	form_data *fd;
	object_data *od;
	FLForm	*form;
	FLObject *object;

	ENTER;
	SAVETMPS;
	PUSHMARK(sp) ;

	va_start(ap, parmptrn);
	while(*parmptrn) {
	    switch(*parmptrn++) {

		case 'p':
			pval = va_arg(ap, void *);
			XPUSHs(sv_2mortal(newSViv((IV)pval)));
			break;

		case 'I':
			Ival = va_arg(ap, IV);
			XPUSHs(sv_2mortal(newSViv((IV)Ival)));
			break;

		case 'i':
			ival = va_arg(ap, int);
			XPUSHs(sv_2mortal(newSViv((IV)ival)));
			break;

		case 's':
			sval = va_arg(ap, char *);
			XPUSHs(sv_2mortal(newSVpv(sval,0)));
			break;

		case 'e':
			pval = va_arg(ap, void *);
			tempsv = sv_newmortal();
			sv_setref_iv(tempsv,"XEventPtr",(IV)pval);
			XPUSHs(tempsv);
			break;

		case 'F':
			form = (FLForm *)(va_arg(ap, void *));
			bless_form(form);
			XPUSHs(get_form_data(form)->po);
			break;

		case 'O':
			object = (FLObject *)(va_arg(ap, void *));
			bless_object(object);
			XPUSHs(get_object_data(object)->po);
			break;

		default:
			croak("Erroneous call to 'call_perl_callback'");
			break;
	    }
	}
	va_end(ap);
	PUTBACK ;

	count = perl_call_sv(callback, G_SCALAR);

	SPAGAIN;
	if (count > 1)
		croak("Perl callback routine returned incorrectly");
	else if (count == 1)
		result = POPi;
	PUTBACK;
	FREETMPS;
	LEAVE;

	if (outexpct && !count)
		croak("Perl callback routine returned incorrectly");

	return result;
}    


static void	sv_setpv_c(SV* sv, const char* ptr)
{
	/*
	 * Attempting to overcome the problem of casting
	 * consts in sv_setpv
	 */

	char *temp_ptr;
	(const char *)temp_ptr = ptr;
	sv_setpv(sv,temp_ptr);
}

#endif
