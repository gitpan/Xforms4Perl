#    Forms_PLOT_OBJS.pm - An extension to PERL to access XForms functions.
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

package Forms_PLOT_OBJS;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(

FL_ACTIVE_XYPLOT
FL_CIRCLE_XYPLOT
FL_DASHED_XYPLOT
FL_EMPTY_XYPLOT
FL_FILL_XYPLOT
FL_IMPULSE_XYPLOT
FL_MAX_XYPLOTOVERLAY
FL_NORMAL_XYPLOT
FL_POINTS_XYPLOT
FL_SQUARE_XYPLOT
FL_XYPLOT
FL_XYPLOT_ALIGN
FL_XYPLOT_BOXTYPE
FL_XYPLOT_COL1
FL_XYPLOT_LCOL
FL_BAR_CHART
FL_CHART
FL_CHARTREUSE
FL_CHART_ALIGN
FL_CHART_BOXTYPE
FL_CHART_COL1
FL_CHART_LCOL
FL_CHART_MAX
FL_FILLED_CHART
FL_HORBAR_CHART
FL_LINE_CHART
FL_PIE_CHART
FL_SPECIALPIE_CHART
FL_SPIKE_CHART
fl_set_xyplot_datafile
fl_add_xyplot
fl_create_xyplot
fl_add_chart
fl_create_chart
fl_add_chart_value
fl_add_xyplot_overlay
fl_add_xyplot_text
fl_clear_chart
fl_delete_xyplot_overlay
fl_delete_xyplot_text
fl_get_xyplot
fl_get_xyplot_data
fl_get_xyplot_xbounds
fl_get_xyplot_xmapping
fl_get_xyplot_xscale
fl_get_xyplot_ybounds
fl_get_xyplot_ymapping
fl_get_xyplot_yscale
fl_insert_chart_value
fl_replace_chart_value
fl_replace_xyplot_point
fl_set_chart_autosize
fl_set_chart_bounds
fl_set_chart_maxnumb
fl_set_xyplot_data
fl_set_xyplot_file
fl_set_xyplot_fontsize
fl_set_xyplot_fontstyle
fl_set_xyplot_inspect
fl_set_xyplot_interpolate
fl_set_xyplot_overlay_type
fl_set_xyplot_return
fl_set_xyplot_scale
fl_set_xyplot_symbolsize
fl_set_xyplot_xbounds
fl_set_xyplot_xtics
fl_set_xyplot_ybounds
fl_set_xyplot_ytics
fl_xyplot_s2w
fl_xyplot_w2s
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

bootstrap Forms_PLOT_OBJS;

   *fl_set_xyplot_datafile = \&fl_set_xyplot_file;

sub FL_ACTIVE_XYPLOT {7;}
sub FL_CIRCLE_XYPLOT {2;}
sub FL_DASHED_XYPLOT {5;}
sub FL_EMPTY_XYPLOT {8;}
sub FL_FILL_XYPLOT {3;}
sub FL_IMPULSE_XYPLOT {6;}
sub FL_MAX_XYPLOTOVERLAY {32;}
sub FL_NORMAL_XYPLOT {0;}
sub FL_POINTS_XYPLOT {4;}
sub FL_SQUARE_XYPLOT {1;}
sub FL_XYPLOT {24;}
sub FL_XYPLOT_ALIGN {2;}
sub FL_XYPLOT_BOXTYPE {3;}
sub FL_XYPLOT_COL1 {11;}
sub FL_XYPLOT_LCOL {0;}
sub FL_BAR_CHART {0;}
sub FL_CHART {12;}
sub FL_CHARTREUSE {25;}
sub FL_CHART_ALIGN {2;}
sub FL_CHART_BOXTYPE {4;}
sub FL_CHART_COL1 {11;}
sub FL_CHART_LCOL {0;}
sub FL_CHART_MAX {256;}
sub FL_FILLED_CHART {3;}
sub FL_HORBAR_CHART {1;}
sub FL_LINE_CHART {2;}
sub FL_PIE_CHART {5;}
sub FL_SPECIALPIE_CHART {6;}
sub FL_SPIKE_CHART {4;}


1;
__END__
