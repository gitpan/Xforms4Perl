#    Forms_DRAW.pm - An extension to PERL to access XForms functions.
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

package Forms_DRAW;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(

FL_ALL_FREE
FL_CONTINUOUS_FREE
FL_FREE
FL_INACTIVE_FREE
FL_NORMAL_FREE 
FL_SLEEPING_FREE
fl_arc
fl_arcf
fl_circ
fl_circf
fl_diagline
fl_ovalf
fl_ovall
fl_polybound
fl_polyf
fl_polyl
fl_rect
fl_rectf
fl_roundrect
fl_roundrectf
fl_oval_bound
fl_bgnline
fl_bgnclosedline
fl_bgnpolygon
fl_add_float_vertex
fl_add_free
fl_add_vertex
fl_create_free
fl_drw_box
fl_drw_checkbox
fl_drw_frame
fl_draw_text
fl_drw_text
fl_drw_text_beside
fl_drw_text_cursor
fl_endclosedline
fl_endline
fl_endpolygon
fl_line
fl_lines
fl_linewidth
fl_linestyle
fl_oval
fl_ovalbound
fl_pieslice
fl_polygon
fl_rectangle
fl_rectbound
fl_reset_vertex
fl_roundrectangle
fl_simple_line

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

bootstrap Forms_DRAW;

   *fl_oval_bound = \&fl_ovalbound;
   *fl_bgnline = \&fl_reset_vertex;
   *fl_bgnclosedline = \&fl_reset_vertex;
   *fl_bgnpolygon = \&fl_reset_vertex;
   *fl_simple_line = \&fl_line;


sub fl_arc {fl_pieslice(0, $_[0]-$_[2], $_[1]-$_[2], 2*$_[2], 2*$_[2], $_[3], $_[4], $_[5]);}
sub fl_arcf {fl_pieslice(1, $_[0]-$_[2], $_[1]-$_[2], 2*$_[2], 2*$_[2], $_[3], $_[4], $_[5]);}
sub fl_circ {fl_oval(   0, $_[0]-$_[2], $_[1]-$_[2], 2*$_[2], 2*$_[2], $_[3]);}
sub fl_circf {fl_oval(  1, $_[0]-$_[2], $_[1]-$_[2], 2*$_[2], 2*$_[2], $_[3]);}
sub fl_diagline {fl_line($_[0],$_[1],$_[0]+$_[2]-1,$_[1]+$_[3]-1,$_[4]);}
sub fl_ovalf {fl_oval(1,@_);}
sub fl_ovall {fl_oval(0,@_);}
sub fl_polybound {fl_polyf(@_); fl_polygon($_[0],$_[1],0);}
sub fl_polyf {fl_polygon(1,@_);}
sub fl_polyl {fl_polygon(0,@_);}
sub fl_rect {fl_rectangle(0,@_);}
sub fl_rectf {fl_rectangle(1,@_);}
sub fl_roundrect {fl_roundrectangle(0,@_);}
sub fl_roundrectf {fl_roundrectangle(1,@_);}

sub FL_ALL_FREE {4;}
sub FL_CONTINUOUS_FREE {3;}
sub FL_FREE {23;}
sub FL_INACTIVE_FREE {1;}
sub FL_NORMAL_FREE {0;}
sub FL_SLEEPING_FREE {1;}

1;
__END__
