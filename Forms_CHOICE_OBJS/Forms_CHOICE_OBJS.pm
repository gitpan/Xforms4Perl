#    Forms_CHOICE_OBJS.pm - An extension to PERL to access XForms functions.
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

package Forms_CHOICE_OBJS;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(

FL_CHOICE
FL_CHOICE_ALIGN
FL_CHOICE_BOXTYPE
FL_CHOICE_COL1
FL_CHOICE_COL2
FL_CHOICE_LCOL
FL_CHOICE_MAXITEMS
FL_CHOICE_MCOL
FL_PUP_BOX
FL_PUP_CHECK
FL_PUP_GRAY
FL_PUP_GREY
FL_PUP_INACTIVE
FL_PUP_NONE
FL_PUP_PADH
FL_PUP_RADIO
FL_PUP_TOGGLE 
FL_MAXPUPI
FL_MENU
FL_MENU_ALIGN
FL_MENU_BOXTYPE
FL_MENU_BUTTON
FL_MENU_COL1
FL_MENU_COL2
FL_MENU_LCOL
FL_MENU_MAXITEMS
FL_MENU_MAXSTR
FL_PULLDOWN_MENU
FL_PUSH_MENU
FL_TOUCH_MENU
FL_DROPLIST_CHOICE
FL_NORMAL_CHOICE
fl_setpup_hotkey 
fl_setpup
fl_add_choice
fl_create_choice
fl_add_menu 
fl_create_menu
fl_addto_choice
fl_addto_menu
fl_addtopup
fl_clear_choice
fl_clear_menu
fl_defpup
fl_delete_choice
fl_delete_menu_item
fl_dopup
fl_freepup
fl_get_choice
fl_get_choice_maxitems
fl_get_choice_text
fl_get_menu
fl_get_menu_item_mode
fl_get_menu_maxitems
fl_get_menu_text
fl_getpup_mode
fl_getpup_text
fl_hidepup
fl_newpup
fl_replace_choice
fl_replace_menu_item
fl_set_choice
fl_set_choice_align
fl_set_choice_fontsize
fl_set_choice_fontstyle
fl_set_choice_item_mode
fl_set_choice_item_shortcut
fl_set_choice_text
fl_set_menu
fl_set_menu_item_mode
fl_set_menu_item_shortcut
fl_set_menu_popup
fl_setpup_bw
fl_setpup_color
fl_setpup_cursor
fl_setpup_default_cursor
fl_setpup_fontsize
fl_setpup_fontstyle
fl_setpup_maxpup
fl_setpup_mode
fl_setpup_pad
fl_setpup_position
fl_setpup_selection
fl_setpup_shadow
fl_setpup_shortcut
fl_setpup_softedge
fl_setpup_submenu
fl_setpup_title
fl_show_menu_symbol
fl_showpup
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

bootstrap Forms_CHOICE_OBJS;

   *fl_setpup_hotkey = \&fl_setpup_shortcut;
   *fl_setpup = \&fl_setpup_mode;

sub FL_CHOICE {13;}
sub FL_CHOICE_ALIGN {4;}
sub FL_CHOICE_BOXTYPE {7;}
sub FL_CHOICE_COL1 {11;}
sub FL_CHOICE_COL2 {0;}
sub FL_CHOICE_LCOL {0;}
sub FL_CHOICE_MAXITEMS {63;}
sub FL_CHOICE_MCOL {16;}
sub FL_PUP_BOX {2;}
sub FL_PUP_CHECK {4;}
sub FL_PUP_GRAY {1;}
sub FL_PUP_GREY {1;}
sub FL_PUP_INACTIVE {1;}
sub FL_PUP_NONE {0;}
sub FL_PUP_PADH {4;}
sub FL_PUP_RADIO {8;}
sub FL_PUP_TOGGLE {2;}
sub FL_MAXPUPI {64;}
sub FL_MENU {11;}
sub FL_MENU_ALIGN {0;}
sub FL_MENU_BOXTYPE {4;}
sub FL_MENU_BUTTON {8;}
sub FL_MENU_COL1 {11;}
sub FL_MENU_COL2 {16;}
sub FL_MENU_LCOL {0;}
sub FL_MENU_MAXITEMS {128;}
sub FL_MENU_MAXSTR {64;}
sub FL_PULLDOWN_MENU {2;}
sub FL_PUSH_MENU {1;}
sub FL_TOUCH_MENU {0;}
sub FL_DROPLIST_CHOICE {1;}
sub FL_NORMAL_CHOICE {0;}


1;
__END__
