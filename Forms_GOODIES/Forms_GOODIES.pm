#    Forms_GOODIES.pm - An extension to PERL to access XForms functions.
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

package Forms_GOODIES;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(

fl_show_file_selector
fl_set_fselector_cb
fl_set_fselector_title
fl_set_fselector_transient
fl_add_fselector_appbutton
fl_disable_fselector_cache
fl_get_directory
fl_get_filename
fl_get_fselector_form
fl_get_pattern
fl_hide_fselector
fl_hide_oneliner
fl_invalidate_fselector_cache
fl_refresh_fselector
fl_remove_fselector_appbutton
fl_set_choices_shortcut
fl_set_fselector_border
fl_set_fselector_callback
fl_set_fselector_placement
fl_set_goodies_font
fl_set_oneliner_color
fl_set_oneliner_font
fl_show_alert
fl_show_choice
fl_show_colormap
fl_show_fselector
fl_show_input
fl_show_message
fl_show_oneliner
fl_show_question
fl_use_fselector
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

bootstrap Forms_GOODIES;

   *fl_show_file_selector = \&fl_show_fselector;
   *fl_set_fselector_cb = \&fl_set_fselector_callback;
sub fl_set_fselector_title {fl_set_form_title(fl_get_fselector_form(),@_);}
sub fl_set_fselector_transient {fl_set_fselector_border($_[0] ? FL_TRANSIENT() : FL_FULLBORDER());}

sub FL_MAX_FSELECTOR {6;}

1;
__END__
