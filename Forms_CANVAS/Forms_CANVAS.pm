#    Forms_CANVAS.pm - An extension to PERL to access XForms functions.
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

package Forms_CANVAS;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(
FL_NORMAL_CANVAS
FL_SCROLLED_CANVAS
FL_CANVAS
FL_MESACANVAS
FL_CANVAS_ALIGN
FL_CANVAS_BOXTYPE
fl_add_canvas
fl_create_canvas
fl_add_canvas_handler
fl_canvas_yield_to_shortcut
fl_create_generic_canvas
fl_get_canvas_colormap
fl_get_canvas_id
fl_hide_canvas
fl_modify_canvas_prop
fl_remove_canvas_handler
fl_set_canvas_attributes
fl_set_canvas_colormap
fl_set_canvas_decoration
fl_set_canvas_depth
fl_get_canvas_depth
fl_set_canvas_visual
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

bootstrap Forms_CANVAS;

sub FL_NORMAL_CANVAS {0;}
sub FL_SCROLLED_CANVAS {1;}
sub FL_CANVAS {26;}
sub FL_MESACANVAS {29;}
sub FL_CANVAS_ALIGN {1;}
sub FL_CANVAS_BOXTYPE {0;}

1;
__END__
