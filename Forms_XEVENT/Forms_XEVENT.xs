/*   Forms_XEVENT.xs - An extension to PERL to access XForms functions.
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
 * One slot for each XEvent - when a callback is registered, we
 * chain a cb_data structure off the appropriate slot. XErrorEvent
 * is limited to one callback routine due to the unpredicatable
 * nature of its XID variable - but that may be taken care of by
 * XForms itself.
 */
cb_data **      ecb_data = NULL;

/*
 * And the user event callback routine
 */
SV *            user_event_callback = NULL;
SV *            user_idle_callback = NULL;

/*
 * This function returns the above pointer, calloc-ing the necessary
 * storage if the pointer is null
 */
cb_data **
get_cb_data()
{
	if (ecb_data == NULL)
		ecb_data = (cb_data **)calloc(LASTEvent, sizeof(cb_data **));
	if (ecb_data == NULL)
		croak("Event callback data allocation error");
	return ecb_data;
}

int
process_event_callback(event,parm)
XEvent *        event;
void *          parm;
{
	/*
	 * Generic XEvent callback
	 */

	if (user_event_callback == NULL)
		croak("User event callback routine not set");
	return call_perl_callback(user_event_callback,
			          TRUE,
			          "ep",
			          event,parm);
}

int
process_single_event_callback(event,parm)
XEvent *        event;
void *          parm;
{

	/*
	 * Individual XEvent callback
	 */

	int		event_type;
	cb_data *this,  **prev;
	Window		window;

	/*
	 * We only allow one handler for XErrorEvents for
	 * all windows. this is because the XErrorEvent
	 * may not contain a valid window variable
	 */
	window = (event_type = event->type) ?
		event->xany.window : 0;

	prev = &(get_cb_data()[event_type]);
	while ((this = *prev) && this->window != window)
		prev = &(this->next_data);

	if (this == NULL || this->callback == NULL)
		croak("Single event callback routine not set");

	return call_perl_callback(this->callback,
			          TRUE,
			          "ep",
			          event,parm);
}

int
process_idle_callback(event,parm)
XEvent *        event;
void *          parm;
{

	/*
	 * Generic idle callback
	 */

	if (user_idle_callback == NULL)
		croak("User idle callback routine not set");
	return call_perl_callback(user_idle_callback,
			          TRUE,
			          "ep",
			          event,parm);
}


MODULE = Forms_XEVENT		PACKAGE = Forms_XEVENT

void
fl_add_event_callback(window,event,callback,parm)
	Window		window
	int		event
	SV *		callback
	void *		parm
	CODE:
	{
		cb_data *this,  **prev;

		prev = &(get_cb_data()[event]);
		/*
		 * We only allow one handler for XErrorEvents for
		 * all windows. this is because the XErrorEvent
		 * may not contain a valid window variable
		 */
		if (!event)
			window = 0;

		/*
		 * Now see if this event/window pair has a callback
		 * already set.
		 */
		while ((this = *prev) && this->window != window)
			prev = &(this->next_data);

		ST(0) = sv_newmortal();
		if (this) {
			/*
			 * A callback was found, return the
			 * SV * of it and then use the existing
			 * cb_data area for the new callback
			 */
			sv_setsv(ST(0),this->callback);
		} else {
			/*
			 * No callback was found, get a new cb_data
			 * area and chain the end of the list for
			 * the current event
			 */
			this = *prev =
			        (cb_data *)calloc(1, sizeof(cb_data));
			this->window = window;
		}
		/*
		 * Now save the callback pointer and call the
		 * XForm library function
		 */
		SAVESV(this->callback, callback);

		fl_add_event_callback(window, event,
			              (callback == NULL ? NULL :
			              process_single_event_callback),
			              parm);
	}

void
fl_remove_event_callback(window,event)
	Window		window
	int		event
	CODE:
	{
		cb_data *this,  **prev;

		prev = &(get_cb_data()[event]);
		/*
		 * We only allow one handler for XErrorEvents for
		 * all windows. this is because the XErrorEvent
		 * may not contain a valid window variable
		 */
		if (!event)
			window = 0;

		while ((this = *prev) != NULL && this->window != window)
			prev = &(this->next_data);

		if (this) {
			*prev = this->next_data;
			free(this);
		}

		fl_remove_event_callback(window, event);
	}

void
fl_activate_event_callbacks(window)
	Window		window

XEvent *
fl_print_xevent_name(string,event)
	const char *	string
	const XEvent *	event

void
fl_XNextEvent()
	PPCODE:
	{
		int		status;
		XEvent *	event;
		SV *		tempsv;

		event = (XEvent *)calloc(1, sizeof(XEvent));

		status = fl_XNextEvent(event);

		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSViv(status)));
		tempsv = sv_newmortal();
		sv_setref_iv(tempsv, "XEventPtr", (IV)event);
		PUSHs(tempsv);
	}

void
fl_XPeekEvent()
	PPCODE:
	{
		int		status;
		XEvent *	event;
		SV *		tempsv;

		event = (XEvent *)calloc(1, sizeof(XEvent));

		status = fl_XPeekEvent(event);

		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSViv(status)));
		tempsv = sv_newmortal();
		sv_setref_iv(tempsv, "XEventPtr", (IV)event);
		PUSHs(tempsv);
	}

int
fl_XEventsQueued(int1)
	int		int1

void
fl_XPutBackEvent(event)
	XEvent *	event

const XEvent *
fl_last_event()

void
fl_set_event_callback(callback,ptr)
	SV *		callback
	void *		ptr
	CODE:
	{
		return_save_sv(&(ST(0)),
			       &(user_event_callback),
			       callback);
		fl_set_event_callback((callback == NULL ? NULL :
			              process_event_callback),
			              ptr);
	}

void
fl_set_idle_callback(callback,ptr)
	SV *		callback
	void *		ptr
	CODE:
	{
		return_save_sv(&(ST(0)),
			       &(user_idle_callback),
			       callback);
		fl_set_idle_callback((callback == NULL ? NULL :
			             process_idle_callback),
			             ptr);
	}

long
fl_addto_selected_xevent(window,l1)
	Window		window
	long		l1

long
fl_remove_selected_xevent(window,l1)
	Window		window
	long		l1
