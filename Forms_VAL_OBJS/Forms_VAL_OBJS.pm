#    Forms_VAL_OBJS.pm - An extension to PERL to access XForms functions.
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

package Forms_VAL_OBJS;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(


FL_SLIDER
FL_SLIDER_ALIGN
FL_SLIDER_BOXTYPE
FL_SLIDER_BW1
FL_SLIDER_BW2
FL_SLIDER_COL1
FL_SLIDER_COL2
FL_SLIDER_FINE
FL_SLIDER_LCOL
FL_SLIDER_WIDTH
FL_VALSLIDER
FL_VERT_FILL_SLIDER
FL_VERT_NICE_SLIDER
FL_VERT_SLIDER
FL_HOR_FILL_SLIDER
FL_HOR_NICE_SLIDER
FL_HOR_SLIDER
FL_NORMAL_POSITIONER
FL_POSITIONER
FL_POSITIONER_ALIGN
FL_POSITIONER_BOXTYPE
FL_POSITIONER_COL1
FL_POSITIONER_COL2
FL_POSITIONER_LCOL
FL_DIAL
FL_DIAL_ALIGN
FL_DIAL_BOXTYPE
FL_DIAL_COL1
FL_DIAL_COL2
FL_DIAL_LCOL
FL_DIAL_TOPCOL
FL_LINE_DIAL
FL_NORMAL_DIAL
FL_COUNTER
FL_COUNTER_ALIGN
FL_COUNTER_BOXTYPE
FL_COUNTER_BW
FL_COUNTER_COL1
FL_COUNTER_COL2
FL_COUNTER_LCOL
FL_NORMAL_COUNTER
fl_add_counter
fl_create_counter
fl_add_dial
fl_create_dial
fl_add_positioner
fl_create_positioner
fl_add_slider 
fl_create_slider 
fl_create_valslider
fl_add_valslider 
fl_get_counter_value
fl_get_dial_bounds
fl_get_dial_value
fl_get_positioner_xbounds
fl_get_positioner_xvalue
fl_get_positioner_ybounds
fl_get_positioner_yvalue
fl_get_slider_bounds
fl_get_slider_value
fl_set_counter_bounds
fl_set_counter_filter
fl_set_counter_precision
fl_set_counter_return
fl_set_counter_step
fl_set_counter_value
fl_set_dial_angles
fl_set_dial_bounds
fl_set_dial_cross
fl_set_dial_return
fl_set_dial_step
fl_set_dial_value
fl_set_positioner_return
fl_set_positioner_xbounds
fl_set_positioner_xstep
fl_set_positioner_xvalue
fl_set_positioner_ybounds
fl_set_positioner_ystep
fl_set_positioner_yvalue
fl_set_slider_bounds
fl_set_slider_filter
fl_set_slider_precision
fl_set_slider_return
fl_set_slider_size
fl_set_slider_step
fl_set_slider_value
);

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    local($constname);
    ($constname = $AUTOLOAD) =~ s/.*:://;
    $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
	    ($pack,$file,$line) = caller;
	    die "Your vendor has not defined Forms macro $constname, used at $file line $line.";
	}
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap Forms_VAL_OBJS;

sub FL_SLIDER {15;}
sub FL_SLIDER_ALIGN {2;}
sub FL_SLIDER_BOXTYPE {2;}
sub FL_SLIDER_BW1 {3;}
sub FL_SLIDER_BW2 {2;}
sub FL_SLIDER_COL1 {11;}
sub FL_SLIDER_COL2 {11;}
sub FL_SLIDER_FINE {.05;}
sub FL_SLIDER_LCOL {0;}
sub FL_SLIDER_WIDTH {.08;}
sub FL_VALSLIDER {16;}
sub FL_VERT_FILL_SLIDER {2;}
sub FL_VERT_NICE_SLIDER {4;}
sub FL_VERT_SLIDER {0;}
sub FL_HOR_FILL_SLIDER {3;}
sub FL_HOR_NICE_SLIDER {5;}
sub FL_HOR_SLIDER {1;}
sub FL_NORMAL_POSITIONER {0;}
sub FL_POSITIONER {22;}
sub FL_POSITIONER_ALIGN {2;}
sub FL_POSITIONER_BOXTYPE {2;}
sub FL_POSITIONER_COL1 {11;}
sub FL_POSITIONER_COL2 {1;}
sub FL_POSITIONER_LCOL {0;}
sub FL_DIAL {19;}
sub FL_DIAL_ALIGN {2;}
sub FL_DIAL_BOXTYPE {3;}
sub FL_DIAL_COL1 {11;}
sub FL_DIAL_COL2 {12;}
sub FL_DIAL_LCOL {0;}
sub FL_DIAL_TOPCOL {11;}
sub FL_LINE_DIAL {1;}
sub FL_NORMAL_DIAL {0;}
sub FL_COUNTER {14;}
sub FL_COUNTER_ALIGN {2;}
sub FL_COUNTER_BOXTYPE {1;}
sub FL_COUNTER_BW {2;}
sub FL_COUNTER_COL1 {11;}
sub FL_COUNTER_COL2 {4;}
sub FL_COUNTER_LCOL {0;}
sub FL_NORMAL_COUNTER {0;}
sub FL_SIMPLE_COUNTER {1;}

1;
__END__
