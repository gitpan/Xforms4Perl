#    Forms_WIN.pm - An extension to PERL to access XForms functions.
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

package Forms_WIN;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(

fl_set_gc_clipping
fl_unset_gc_clipping
fl_pref_winposition
fl_win_background 
fl_set_winstepunit
fl_pref_winsize 
fl_pref_wingeometry
fl_get_win_size
fl_get_win_origin
fl_get_win_geometry
fl_initial_winposition
fl_create_GC
fl_fill_rectangle
fl_get_win_mouse
fl_get_wingeometry
fl_get_winorigin
fl_get_winsize
fl_initial_wingeometry
fl_initial_winsize
fl_initial_winstate
fl_noborder
fl_reset_winconstraints
fl_set_background
fl_set_foreground
fl_transient
fl_win_to_form
fl_winaspect
fl_winbackground
fl_winclose
fl_wincreate
fl_wingeometry
fl_winget
fl_winhide
fl_winisvalid
fl_winmaxsize
fl_winminsize
fl_winmove
fl_winopen
fl_winposition
fl_winreshape
fl_winresize
fl_winset
fl_winshow
fl_winsize
fl_winstepunit
fl_wintitle
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

bootstrap Forms_WIN;

   *fl_pref_winposition = \&fl_winposition;
   *fl_win_background = \&fl_winbackground;
   *fl_set_winstepunit = \&fl_winstepunit;
   *fl_pref_winsize = \&fl_winsize;
   *fl_pref_wingeometry = \&fl_wingeometry;
   *fl_get_win_size = \&fl_get_winsize;
   *fl_get_win_origin = \&fl_get_winorigin;
   *fl_get_win_geometry = \&fl_get_wingeometry;
   *fl_initial_winposition = \&fl_pref_winposition;

1;
__END__
