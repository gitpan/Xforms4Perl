/*   Forms_GOODIES.xs - An extension to PERL to access XForms functions.
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

static
int		current_fsel = 1;

/*
 * fselector application button callback structure, anchor
 * and allocation routine
 */
typedef struct _fcb_data {
        struct _fcb_data *      next_data;
        SV *                    callback;
        void *                  parm;
        char                    string;
} fcb_data;

fcb_data **	fcb_anchor = NULL;

fcb_data **	get_fcb_data(int fsel){

	if (!fcb_anchor)
		fcb_anchor = (fcb_data **)calloc(FL_MAX_FSELECTOR+1,
						 sizeof(fcb_data));
	if (!fcb_anchor)
		croak("Allocation error - fselector callback array");
	return &fcb_anchor[fsel];
}
	
static int
process_fselector_callback(string,parm)
const char *    string;
void *          parm;
{
	/*
	 * fselector callback processor
	 */

	FLForm *        form = fl_get_fselector_form();
	SV *		form_callback_ptr =
				(get_form_data(form))->fd_fselcallback;

	if (form_callback_ptr == NULL)
		croak("Fselector callack routine not set");
	return call_perl_callback(form_callback_ptr,
				  TRUE,
				  "sp",
				  string, parm);
}

static void
process_fselapp_callback(parm)
void *          parm;
{
	/*
	 * Generic fselector application button callback
	 * the parm is really a pointer to the fcb_data structure!!
	 */

	call_perl_callback(((fcb_data *)parm)->callback,
			   TRUE,
			   "p",
			   ((fcb_data *)parm)->parm);
}

MODULE = Forms_GOODIES		PACKAGE = Forms_GOODIES

void
fl_set_goodies_font(val1,val2)
	int		val1
	int		val2

void
fl_show_message(line1,line2,line3)
	char *		line1
	char *		line2
	char *		line3

void
fl_show_alert(line1,line2,line3,value)
	char *		line1
	char *		line2
	char *		line3
	int		value

int
fl_show_question(line1,line2,line3)
	char *		line1
	char *		line2
	char *		line3

const char *
fl_show_input(line1,line2)
	char *		line1
	char *		line2

int
fl_show_colormap(value)
	int		value

int
fl_show_choice(line1,line2,line3,value,line4,line5,line6)
	char *		line1
	char *		line2
	char *		line3
	int		value
	char *		line4
	char *		line5
	char *		line6

void
fl_set_choices_shortcut(line1,line2,line3)
	char *		line1
	char *		line2
	char *		line3

void
fl_show_oneliner(string,x,y)
	const char *	string
	FL_Coord	x
	FL_Coord	y

void
fl_hide_oneliner()

void
fl_set_oneliner_font(int1,int2)
	int		int1
	int		int2

void
fl_set_oneliner_color(col1,col2)
	unsigned long	col1
	unsigned long	col2

int
fl_use_fselector(int1)
	int		int1
	CODE:
	{
		current_fsel = int1;
		RETVAL = fl_use_fselector(int1);
	}
	OUTPUT:
	RETVAL

const char *
fl_show_fselector(line1,line2,line3,line4)
	char *		line1
	char *		line2
	char *		line3
	char *		line4

void
fl_set_fselector_placement(value)
	int		value

void
fl_set_fselector_border(value)
	int		value

void
fl_set_fselector_callback(callback,parm)
	SV *		callback
	void *		parm
	CODE:
	{
		/*
		 * fselector callback is handled via its
		 * form callback structure
		 */
		form_data *fmdat = get_form_data(fl_get_fselector_form());

		SAVESV(fmdat->fd_fselcallback, callback);
		fl_set_fselector_callback((callback == NULL ? NULL :
				         process_fselector_callback),parm);
	}

const char *
fl_get_directory()

const char *
fl_get_pattern()

const char *
fl_get_filename()

void
fl_refresh_fselector()

void
fl_add_fselector_appbutton(string,callback,parm)
	const char *	string
	SV *		callback
	void *		parm
	CODE:
	{
		/*
		 * These buttons are a pain! They get keyed by the
		 * string on them! Anyway, to cater for this, fcb_data
		 * structures get chained off an array of pointers held
		 * above. And, to get over the 'unknownness' of the
		 * button that actually calls the callback, the fcb_data
		 * structure is passed as the parm, the application's parm
		 * being hidden in the structure!
		 */

		fcb_data	*this,   **prev = get_fcb_data(current_fsel);

		/*
		 * Now see if this button is already there. If so,
		 * delete it first!.
		 */
		while ((this = *prev) && strcmp(&(this->string),string))
			prev = &(this->next_data);

		if (this) {
			/*
			 * A button was found, delete it and use its
			 * area
			 */
			fl_remove_fselector_appbutton(string);
		} else {
			/*
			 * No callback was found, get a new fcb_data
			 * area and chain the end of the list for
			 * the current form
			 */
			this = *prev =
				(fcb_data *)calloc(1, sizeof(fcb_data)+
				                   strlen(string));
			this->next_data = NULL;
			strcpy(&(this->string), string);
		}
		/*
		 * Now save the callback pointerand the user parm and call the
		 * XForm library function
		 */
		SAVESV(this->callback, callback);
		this->parm = parm;

		fl_add_fselector_appbutton(string,
				           (callback == NULL ? NULL :
				           process_fselapp_callback),
				           this);
	}

void
fl_remove_fselector_appbutton(string)
	const char *	string
	CODE:
	{
		fcb_data        *this,   **prev = get_fcb_data(current_fsel);

		while ((this = *prev) && !strcmp(&this->string,string))
			prev = &(this->next_data);

		if (this) {
			*prev = this->next_data;
			free(this);
		}

		fl_remove_fselector_appbutton(string);
	}

void
fl_disable_fselector_cache(flag)
	int		flag

void
fl_invalidate_fselector_cache()

FLForm *
fl_get_fselector_form()

void
fl_hide_fselector()

