/*   Forms_PLOT_OBJS.xs - An extension to PERL to access XForms functions.
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

MODULE = Forms_PLOT_OBJS		PACKAGE = Forms_PLOT_OBJS

void
fl_clear_chart(object)
	FLObject *	object

void
fl_add_chart_value(object,double1,string,int1)
	FLObject *	object
	double		double1
	const char *	string
	int		int1

void
fl_insert_chart_value(object,int1,double1,string,int2)
	FLObject *	object
	int		int1
	double		double1
	const char *	string
	int		int2

void
fl_replace_chart_value(object,int1,double1,string,int2)
	FLObject *	object
	int		int1
	double		double1
	const char *	string
	int		int2

void
fl_set_chart_bounds(object,double1,double2)
	FLObject *	object
	double		double1
	double		double2

void
fl_set_chart_maxnumb(object,int1)
	FLObject *	object
	int		int1

void
fl_set_chart_autosize(object,int1)
	FLObject *	object
	int		int1

void
fl_set_xyplot_return(object,val)
	FLObject *	object
	int		val

void
fl_set_xyplot_xtics(object,val1,val2)
	FLObject *	object
	int		val1
	int		val2

void
fl_set_xyplot_ytics(object,val1,val2)
	FLObject *	object
	int		val1
	int		val2

void
fl_set_xyplot_xbounds(object,val1,val2)
	FLObject *	object
	double		val1
	double		val2

void
fl_set_xyplot_ybounds(object,val1,val2)
	FLObject *	object
	double		val1
	double		val2

void
fl_get_xyplot_xbounds(object)
	FLObject *	object
	PPCODE:
	{
		float		value1, value2;

		fl_get_xyplot_xbounds(object, &value1, &value2);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
	}

void
fl_get_xyplot_ybounds(object)
	FLObject *	object
	PPCODE:
	{
		float		value1, value2;

		fl_get_xyplot_ybounds(object, &value1, &value2);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
	}

void
fl_get_xyplot(object)
	FLObject *	object
	PPCODE:
	{
		float  value1, value2;
		int		value3;

		fl_get_xyplot(object, &value1, &value2, &value3);
		EXTEND(sp, 3);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
		PUSHs(sv_2mortal(newSViv(value3)));
	}

void
fl_get_xyplot_data(object)
	FLObject *	object
	PPCODE:
	{
		float  value1, value2;
		int		value3;

		fl_get_xyplot_data(object, &value1, &value2, &value3);
		EXTEND(sp, 3);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
		PUSHs(sv_2mortal(newSViv(value3)));
	}

void
fl_set_xyplot_data(object,...)
	FLObject *	object
	CODE:
	{
		float           *xfloat, *yfloat;
		int		i, numpts, xST, yST;
		unsigned int    slen1, slen2, slen3;
		char            *str1, *str2, *str3;
		if (items < 6 || items % 2 != 0)
			croak("usage: fl_set_xyplot_data(object,x,y,...,label,x-label,y-label)");
		/* The number of points sent */
		numpts = (items - 4) / 2;

		/*
		 * First get the lengths of the three labels
		 */
		SvPV(ST(items-3),slen1);
		SvPV(ST(items-2),slen2);
		SvPV(ST(items-1),slen3);

		/*
		 * Now figure out storage size and get it:
		 * It is the size of two floats for each point plus
		 * the size of each label, plus one byte for each
		 * label so we can add a 'just-in-case' '\0' to
		 * each one. The top of the area 'gotten' is the
		 * start of the x-point data.
		 */
		xfloat = (float *)calloc
			(1, (2*numpts*sizeof(float))+3+slen1+slen2+slen3);

		/*
		 * The y-point data starts numpts floats from the
		 * x-point data
		 */
		yfloat = xfloat + numpts;

		/*
		 * The label data starts numpts floats from the
		 * y-point data
		 */
		str1 = (char *)(yfloat + numpts);
		str2 = str1 + slen1 + 1;
		str3 = str2 + slen2 + 1;

		/*
		 * Copy in the labels and there '\0' bytes
		 */
		memcpy(str1,SvPV(ST(items-3),na),slen1);
		memcpy(str2,SvPV(ST(items-2),na),slen2);
		memcpy(str3,SvPV(ST(items-1),na),slen3);

		str1[slen1] = str2[slen2] = str3[slen3] = '\0';

		/*
		 * Now build the X-point and Y-point arrays by
		 * moving each point pair to its relevant array
		 */
		for (i=0; i<numpts; ++i) {

			xST = (i*2)+1;
			yST = (i*2)+2;
			xfloat[i] = SvNV(ST(xST));
			yfloat[i] = SvNV(ST(yST));

		}
		fl_set_xyplot_data(object,xfloat,yfloat,numpts,
				        (const char *)str1,
				        (const char *)str2,
				        (const char *)str3);

		/* Ok, we're done, lose the area */
		free((void*)xfloat);
	}

void
fl_set_xyplot_file(object,filename,title,xlabel,ylabel)
	FLObject *	object
	const char *	filename
	const char *	title
	const char *	xlabel
	const char *	ylabel

void
fl_add_xyplot_text(object,value1,value2,string,value3,color)
	FLObject *	object
	double		value1
	double		value2
	const char *	string
	int		value3
	int		color

void
fl_delete_xyplot_text(object,string)
	FLObject *	object
	const char *	string

void
fl_set_xyplot_xscale(object,i,d)
	FLObject *	object
	int		i
	double		d

void
fl_set_xyplot_yscale(object,i,d)
	FLObject *	object
	int		i
	double		d

void
fl_add_xyplot_overlay(object,overlay_id,...)
	FLObject *	object
	int		overlay_id
	CODE:
	{
		/*
		 * The algorithm here is much the same as for
		 * fl_set_xyplot_data above but without the
		 * the labels and with a color parameter.
		 */
		float   *xfloat, *yfloat;
		int		i, numpts, color, xST, yST;

		if (items < 5 || (items-1) % 2 != 0)
			croak("usage: fl_add_xyplot_overlay(object,ol_id,x,y,...)");                
		numpts = (items - 3) / 2;

		xfloat = (float *)calloc(2*numpts, sizeof(float));
		yfloat = xfloat + numpts;

		for (i=0; i<numpts; ++i) {

			xST = (i*2)+2;
			yST = (i*2)+3;
			xfloat[i] = SvNV(ST(xST));
			yfloat[i] = SvNV(ST(yST));

		}
		color = SvIV(ST(items-1));
		fl_add_xyplot_overlay(object,overlay_id,
				        xfloat,yfloat,numpts,color);
		free((void*)xfloat);
	}

void
fl_set_xyplot_overlay_type(object,value1,value2)
	FLObject *	object
	double		value1
	double		value2

void
fl_delete_xyplot_overlay(object,value1)
	FLObject *	object
	int		value1

void
fl_set_xyplot_interpolate(object,value1,value2,value3)
	FLObject *	object
	int		value1
	int		value2
	double		value3

void
fl_set_xyplot_fontsize(object,value1)
	FLObject *	object
	int		value1

void
fl_set_xyplot_fontstyle(object,value1)
	FLObject *	object
	int		value1

void
fl_set_xyplot_inspect(object,value1)
	FLObject *	object
	int		value1

void
fl_set_xyplot_symbolsize(object,value1)
	FLObject *	object
	int		value1

void
fl_set_xyplot_scale(object,value1,value2,value3)
	FLObject *	object
	int		value1
	int		value2
	int		value3

void
fl_replace_xyplot_point(object,value1,value2,value3)
	FLObject *	object
	int		value1
	double		value2
	double		value3

void
fl_get_xyplot_xmapping(object)
	FLObject *	object
	PPCODE:
	{
		float  value1, value2;

		fl_get_xyplot_xmapping(object, &value1, &value2);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
	}

void
fl_get_xyplot_ymapping(object)
	FLObject *	object
	PPCODE:
	{
		float  value1, value2;

		fl_get_xyplot_ymapping(object, &value1, &value2);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(value1)));
		PUSHs(sv_2mortal(newSVnv(value2)));
	}

void
fl_xyplot_s2w(object,sx,sy)
	FLObject *	object
	double		sx
	double		sy
	PPCODE:
	{
		float wx, wy;

		fl_xyplot_s2w(object, sx, sy, &wx, &wy);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(wx)));
		PUSHs(sv_2mortal(newSVnv(wy)));
	}

void
fl_xyplot_w2s(object,wx,wy)
	FLObject *	object
	double		wx
	double		wy
	PPCODE:
	{
		float sx, sy;

		fl_xyplot_w2s(object, wx, wy, &sx, &sy);
		EXTEND(sp, 2);
		PUSHs(sv_2mortal(newSVnv(sx)));
		PUSHs(sv_2mortal(newSVnv(sy)));
	}

FLObject *
fl_create_xyplot(type,x,y,width,height,label)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_create_xyplot(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of xyplot failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL


FLObject *
fl_add_xyplot(type,x,y,width,height,label)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_add_xyplot(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of xyplot failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL


FLObject *
fl_create_chart(type,x,y,width,height,label)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_create_chart(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Create of chart failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL


FLObject *
fl_add_chart(type,x,y,width,height,label)
	int		type
	int		x
	int		y
	int		width
	int		height
	char *		label
	CODE:
	{
		RETVAL = fl_add_chart(type,x,y,width,height,label);
		if (RETVAL == NULL)
			croak("Add of chart failed");
		RETVAL->u_vdata = NULL;
	}
	OUTPUT:
	RETVAL

