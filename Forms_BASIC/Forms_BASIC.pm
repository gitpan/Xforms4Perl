#    Forms_BASIC.pm - An extension to PERL to access XForms functions.
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

package Forms_BASIC;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(
FL_ALIGN_BOTTOM
FL_ALIGN_BOTTOM_LEFT
FL_ALIGN_BOTTOM_RIGHT
FL_ALIGN_CENTER
FL_ALIGN_INSIDE
FL_ALIGN_LEFT
FL_ALIGN_LEFT_BOTTOM
FL_ALIGN_LEFT_TOP
FL_ALIGN_RIGHT
FL_ALIGN_RIGHT_BOTTOM
FL_ALIGN_RIGHT_TOP
FL_ALIGN_TOP
FL_ALIGN_TOP_LEFT
FL_ALIGN_TOP_RIGHT
FL_ALIGN_VERT
FL_ALT_VAL
FL_ALWAYS_ON
FL_ANALOG_CLOCK
FL_BEGIN_GROUP
FL_BITMAP
FL_BITMAPBUTTON
FL_BITMAPBUTTON_ALIGN
FL_BITMAPBUTTON_BOXTYPE
FL_BITMAPBUTTON_COL1
FL_BITMAPBUTTON_COL2
FL_BITMAPBUTTON_LCOL
FL_BITMAP_ALIGN
FL_BITMAP_BOXTYPE
FL_BITMAP_COL1
FL_BITMAP_COL2
FL_BITMAP_LCOL
FL_BITMAP_MAXSIZE
FL_BLACK
FL_BLUE
FL_BOLDITALIC_STYLE
FL_BOLD_STYLE
FL_BORDER_BOX
FL_BORDER_FRAME
FL_BOTTOM_BCOL
FL_BOUND_WIDTH
FL_BOX
FL_BROWSER
FL_BROWSER_ALIGN
FL_BROWSER_BOXTYPE
FL_BROWSER_COL1
FL_BROWSER_COL2
FL_BROWSER_FONTSIZE
FL_BROWSER_LCOL
FL_BROWSER_LINELENGTH
FL_BROWSER_SLCOL
FL_BROWSER_SLIDER
FL_BROWSER_SLIDER2
FL_BUILT_IN_COLS
FL_BUTTON
FL_BUTTON_ALIGN
FL_BUTTON_BOXTYPE
FL_BUTTON_BW
FL_BUTTON_COL1
FL_BUTTON_COL2
FL_BUTTON_LCOL
FL_BUTTON_MCOL1
FL_BUTTON_MCOL2
FL_CANCEL
FL_CHECKBUTTON
FL_CHECKBUTTON_ALIGN
FL_CHECKBUTTON_BOXTYPE
FL_CHECKBUTTON_COL1
FL_CHECKBUTTON_COL2
FL_CHECKBUTTON_LCOL
FL_CHECKBUTTON_MCOL
FL_CHECKBUTTON_TOPCOL
FL_CLOCK
FL_CLOCK_ALIGN
FL_CLOCK_BOXTYPE
FL_CLOCK_COL1
FL_CLOCK_COL2
FL_CLOCK_LCOL
FL_CLOCK_TOPCOL
FL_COL1
FL_COORD_MM
FL_COORD_PIXEL
FL_COORD_POINT
FL_COORD_centiMM
FL_COORD_centiPOINT
FL_CYAN
FL_DARKCYAN
FL_DARKGOLD
FL_DARKORANGE
FL_DARKTOMATO
FL_DARKVIOLET
FL_DBLCLICK
FL_DEEPPINK
FL_DEFAULT_FONT
FL_DEFAULT_SIZE
FL_DIGITAL_CLOCK
FL_DOGERBLUE
FL_DOWN_BOX
FL_DOWN_FRAME
FL_DRAW
FL_DRAWLABEL
FL_EMBOSSED_FRAME
FL_EMBOSSED_STYLE
FL_END_GROUP
FL_ENGRAVED_FRAME
FL_ENGRAVED_STYLE
FL_ENTER
FL_EXCEPT
FL_FIXEDBOLDITALIC_STYLE
FL_FIXEDBOLD_STYLE
FL_FIXEDITALIC_STYLE
FL_FIXED_STYLE
FL_FIX_SIZE
FL_FLAT_BOX
FL_FLOAT_INPUT
FL_FOCUS
FL_FOLDERTAB
FL_FRAME
FL_FRAME_BOX
FL_FREEMEM
FL_FREE_COL1
FL_FREE_COL10
FL_FREE_COL11
FL_FREE_COL12
FL_FREE_COL13
FL_FREE_COL14
FL_FREE_COL15
FL_FREE_COL16
FL_FREE_COL2
FL_FREE_COL3
FL_FREE_COL4
FL_FREE_COL5
FL_FREE_COL6
FL_FREE_COL7
FL_FREE_COL8
FL_FREE_COL9
FL_FREE_SIZE
FL_FULLBORDER
FL_GRAY16
FL_GRAY35
FL_GRAY63
FL_GRAY75
FL_GRAY80
FL_GRAY90
FL_GREEN
FL_HIDDEN_BUTTON
FL_HIDDEN_INPUT
FL_HIDDEN_RET_BUTTON
FL_HIDDEN_TIMER
FL_HOLD_BROWSER
FL_HUGE_FONT
FL_HUGE_SIZE
FL_IGNORE
FL_INACTIVE
FL_INACTIVE_COL
FL_INDIANRED
FL_INOUT_BUTTON
FL_INPUT
FL_INPUT_ALIGN
FL_INPUT_BOXTYPE
FL_INPUT_CCOL
FL_INPUT_COL1
FL_INPUT_COL2
FL_INPUT_FREE
FL_INPUT_LCOL
FL_INPUT_TCOL
FL_INT_INPUT
FL_INVALID
FL_INVALID_CLASS
FL_INVALID_STYLE
FL_ITALIC_STYLE
FL_KEYBOARD
FL_KEY_ALL
FL_KEY_NONE
FL_KEY_NORMAL
FL_KEY_SPECIAL
FL_KEY_TAB
FL_LARGE_FONT
FL_LARGE_SIZE
FL_LEAVE
FL_LEFT_BCOL
FL_LIGHTBUTTON
FL_LIGHTBUTTON_ALIGN
FL_LIGHTBUTTON_BOXTYPE
FL_LIGHTBUTTON_COL1
FL_LIGHTBUTTON_COL2
FL_LIGHTBUTTON_LCOL
FL_LIGHTBUTTON_MCOL
FL_LIGHTBUTTON_MINSIZE
FL_LIGHTBUTTON_TOPCOL
FL_LINEAR
FL_LOG
FL_MAGENTA
FL_MAXFONTS
FL_MAX_COLS
FL_MAX_FONTSIZES
FL_MCOL
FL_MEDIUM_FONT
FL_MEDIUM_SIZE
FL_MINDEPTH
FL_MOTION
FL_MOUSE
FL_MOVE
FL_MULTILINE_INPUT
FL_MULTI_BROWSER
FL_NOBORDER
FL_NOEVENT
FL_NONE
FL_NORMAL_BROWSER
FL_NORMAL_BUTTON
FL_NORMAL_FONT
FL_NORMAL_FONT1
FL_NORMAL_FONT2
FL_NORMAL_INPUT
FL_NORMAL_PIXMAP
FL_NORMAL_SIZE
FL_NORMAL_STYLE
FL_NORMAL_TEXT
FL_NORMAL_TIMER
FL_NO_BOX
FL_NO_FRAME
FL_OFF
FL_OK
FL_ON
FL_ORCHID
FL_OSHADOW_BOX
FL_OTHER
FL_OVAL_BOX
FL_OVAL_FRAME
FL_PALEGREEN
FL_PIXMAP
FL_PIXMAPBUTTON
FL_PIXMAPBUTTON_ALIGN
FL_PIXMAPBUTTON_BOXTYPE
FL_PIXMAPBUTTON_COL1
FL_PIXMAPBUTTON_COL2
FL_PIXMAPBUTTON_LCOL
FL_PLACE_ASPECT
FL_PLACE_CENTER
FL_PLACE_CENTERFREE
FL_PLACE_FREE
FL_PLACE_FREE_CENTER
FL_PLACE_FULLSCREEN
FL_PLACE_GEOMETRY
FL_PLACE_HOTSPOT
FL_PLACE_ICONIC
FL_PLACE_MOUSE
FL_PLACE_POSITION
FL_PLACE_SIZE
FL_PREEMPT
FL_PS
FL_PUSH
FL_PUSH_BUTTON
FL_RADIO_BUTTON
FL_READ
FL_RED
FL_RELEASE
FL_RESIZE_ALL
FL_RESIZE_NONE
FL_RESIZE_X
FL_RESIZE_Y
FL_RETURN_ALWAYS
FL_RETURN_BUTTON
FL_RETURN_CHANGED
FL_RETURN_DBLCLICK
FL_RETURN_END
FL_RETURN_END_CHANGED
FL_RFLAT_BOX
FL_RIGHT_BCOL
FL_RINGBELL
FL_ROUNDBUTTON
FL_ROUNDBUTTON_ALIGN
FL_ROUNDBUTTON_BOXTYPE
FL_ROUNDBUTTON_COL1
FL_ROUNDBUTTON_COL2
FL_ROUNDBUTTON_LCOL
FL_ROUNDBUTTON_MCOL
FL_ROUNDBUTTON_TOPCOL
FL_ROUNDED_BOX
FL_ROUNDED_FRAME
FL_RSHADOW_BOX
FL_SCROLLBAR_ALWAYS_ON
FL_SCROLLBAR_OFF
FL_SCROLLBAR_ON
FL_SECRET_INPUT
FL_SELECT_BROWSER
FL_SHADOW_BOX
FL_SHADOW_FRAME
FL_SHADOW_STYLE
FL_SHORTCUT
FL_SLATEBLUE
FL_SMALL_FONT
FL_SMALL_SIZE
FL_SPRINGGREEN
FL_STEP
FL_TEXT
FL_TEXT_ALIGN
FL_TEXT_BOXTYPE
FL_TEXT_COL1
FL_TEXT_COL2
FL_TEXT_LCOL
FL_TIMER
FL_TIMER_ALIGN
FL_TIMER_BLINKRATE
FL_TIMER_BOXTYPE
FL_TIMER_COL1
FL_TIMER_COL2
FL_TIMER_EVENT
FL_TIMER_LCOL
FL_TIMESBOLDITALIC_STYLE
FL_TIMESBOLD_STYLE
FL_TIMESITALIC_STYLE
FL_TIMES_STYLE
FL_TINY_FONT
FL_TINY_SIZE
FL_TOMATO
FL_TOP_BCOL
FL_TOUCH_BUTTON
FL_TRANSIENT
FL_TRPLCLICK
FL_UNFOCUS
FL_UP_BOX
FL_UP_FRAME
FL_VALID
FL_VALUE_TIMER
FL_WHITE
FL_WM_NORMAL
FL_WM_SHIFT
FL_WRITE
FL_YELLOW
fl_activate_all_forms
fl_activate_form
fl_activate_object
fl_add_bitmap
fl_add_bitmapbutton
fl_add_box
fl_add_browser
fl_add_browser_line
fl_add_button
fl_add_checkbutton
fl_add_clock
fl_add_frame
fl_add_input
fl_add_io_callback
fl_add_lightbutton
fl_add_object
fl_add_pixmap
fl_add_pixmapbutton
fl_add_roundbutton
fl_add_text
fl_add_timer
fl_addto_browser
fl_addto_form
fl_bgn_form
fl_bgn_group
fl_bk_color
fl_bk_textcolor
fl_call_object_callback
fl_check_forms
fl_check_only_forms
fl_clear_browser
fl_color
fl_compute_object_geometry
fl_create_bitmap
fl_create_bitmap_cursor
fl_create_bitmapbutton
fl_create_box
fl_create_browser
fl_create_button
fl_create_checkbutton
fl_create_clock
fl_create_frame
fl_create_generic_button
fl_create_input
fl_create_lightbutton
fl_create_pixmap
fl_create_pixmapbutton
fl_create_roundbutton
fl_create_text
fl_create_timer
fl_current_form
fl_deactivate_all_forms
fl_deactivate_form
fl_deactivate_object
fl_default_win 
fl_default_window
fl_delete_browser_line
fl_delete_object
fl_deselect_browser
fl_deselect_browser_line
fl_display
fl_do_forms
fl_do_only_forms
fl_end_form
fl_end_group
fl_finish
fl_free_colors
fl_free_form
fl_free_object
fl_free_pixels
fl_free_pixmap_pixmap
fl_freeze_all_forms
fl_freeze_form
fl_get_align_xy
fl_get_border_width
fl_get_browser
fl_get_browser_dimension
fl_get_browser_line
fl_get_browser_maxline
fl_get_browser_screenlines
fl_get_browser_topline
fl_get_button
fl_get_button_numb
fl_get_char_height
fl_get_char_width
fl_get_clock
fl_get_coordunit
fl_get_cursor_byname
fl_get_display 
fl_get_flcolor 
fl_get_form_event_cmask
fl_get_form_mouse
fl_get_form_vclass 
fl_get_icm_color
fl_get_input
fl_get_mouse
fl_get_object_geometry
fl_get_object_position
fl_get_pixel
fl_get_string_dimension
fl_get_string_height
fl_get_string_size 
fl_get_string_width
fl_get_string_widthTAB
fl_get_timer
fl_get_vclass 
fl_get_visual_depth
fl_getmcolor
fl_hide_form
fl_hide_object
fl_initialize
fl_insert_browser_line
fl_isselected_browser_line
fl_load_browser
fl_make_object
fl_mapcolor
fl_mapcolor_name
fl_mapcolorname
fl_mode_capable
fl_prepare_form_window
fl_redraw_form
fl_redraw_object
fl_register_call_back 
fl_register_raw_callback
fl_remove_io_callback
fl_replace_browser_line
fl_reset_cursor 
fl_scale_form
fl_raise_form
fl_lower_form
fl_scale_object
fl_select_browser_line
fl_set_app_mainform
fl_set_app_nomainform
fl_get_app_mainform
fl_set_atclose
fl_set_bitmap_datafile 
fl_set_bitmap_file
fl_set_bitmapbutton_datafile 
fl_set_bitmapbutton_file
fl_set_border_width
fl_set_browser_dblclick_callback
fl_set_browser_fontsize
fl_set_browser_fontstyle
fl_set_browser_leftscrollbar 
fl_set_browser_leftslider
fl_set_browser_line_selectable
fl_set_browser_specialkey
fl_set_browser_topline
fl_set_browser_vscrollbar
fl_set_browser_xoffset
fl_set_button
fl_set_button_shortcut 
fl_set_call_back 
fl_set_clipping
fl_set_clippings
fl_set_color_leak
fl_set_coordunit
fl_set_cursor
fl_set_cursor_color
fl_set_focus_object
fl_set_font
fl_set_font_name
fl_set_form_atactivate
fl_set_form_atclose
fl_set_form_atdeactivate
fl_set_form_call_back 
fl_set_form_callback
fl_set_form_dblbuffer
fl_set_form_event_cmask
fl_set_form_geometry
fl_set_form_hotobject
fl_set_form_hotspot
fl_set_form_maxsize
fl_set_form_minsize
fl_set_form_position
fl_set_form_property
fl_set_form_size
fl_set_form_title
fl_set_gamma
fl_set_graphics_mode
fl_set_icm_color
fl_set_initial_placement 
fl_set_input
fl_set_input_color
fl_set_input_cursorpos
fl_get_input_cursorpos
fl_set_input_filter
fl_set_input_maxchars
fl_set_input_return
fl_set_input_scroll
fl_set_input_selected
fl_set_input_selected_range
fl_set_input_shortcut 
fl_set_mouse
fl_set_object_automatic 
fl_set_object_align 
fl_set_object_boxtype
fl_set_object_bw
fl_set_object_callback
fl_set_object_color
fl_set_object_dblclick
fl_set_object_dblbuffer
fl_set_object_focus 
fl_set_object_geometry
fl_set_object_gravity
fl_set_object_label
fl_fit_object_label
fl_set_object_lalign
fl_set_object_lcol
fl_set_object_lsize
fl_set_object_lstyle
fl_set_object_position
fl_set_object_posthandler
fl_set_object_prehandler
fl_set_object_resize
fl_set_object_return
fl_set_object_shortcut
fl_set_object_shortcutkey
fl_set_object_size
fl_set_pixmap_align
fl_set_pixmap_colorcloseness
fl_set_pixmap_datafile 
fl_set_pixmap_file
fl_set_pixmapbutton_datafile 
fl_set_pixmapbutton_file
fl_set_tabstop
fl_set_text_clipping
fl_set_timer
fl_set_ul_property
fl_show_errors
fl_show_form
fl_show_form_window
fl_show_object
fl_textcolor
fl_trigger_object
fl_unfreeze_all_forms
fl_unfreeze_form
fl_unset_clipping
fl_unset_text_clipping
fl_vclass_name
fl_vclass_val
fl_vmode
fl_screen
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

bootstrap Forms_BASIC;

# Preloaded methods go here.

# Autoload methods go after __END__, and are processed by the autosplit program.

   *fl_set_object_focus = \&fl_set_focus_object;
   *fl_set_initial_placement = \&fl_set_form_geometry;
   *fl_register_call_back = \&fl_register_raw_callback;
   *fl_set_object_align = \&fl_set_object_lalign;
   *fl_set_call_back = \&fl_set_object_callback;
   *fl_set_form_call_back = \&fl_set_form_callback;
   *fl_get_string_size = \&fl_get_string_dimension;
   *fl_get_flcolor = \&fl_get_pixel;
   *fl_get_fntstruct = \&fl_get_font_struct;
   *fl_set_bitmap_datafile = \&fl_set_bitmap_file;
   *fl_set_browser_leftscrollbar = \&fl_set_browser_leftslider;
   *fl_set_bitmapbutton_datafile = \&fl_set_bitmapbutton_file;
   *fl_set_pixmapbutton_data = \&fl_set_pixmap_data;
   *fl_set_pixmapbutton_file = \&fl_set_pixmap_file;
   *fl_set_pixmapbutton_pixmap = \&fl_set_pixmap_pixmap;
   *fl_get_pixmapbutton_pixmap = \&fl_get_pixmap_pixmap;
   *fl_set_pixmapbutton_datafile = \&fl_set_pixmap_file;
   *fl_free_pixmapbutton_pixmap = \&fl_free_pixmap_pixmap;
   *fl_set_button_shortcut = \&fl_set_object_shortcut;
   *fl_set_input_shortcut = \&fl_set_object_shortcut;
   *fl_get_display = \&fl_display;
   *fl_get_vclass = \&fl_vmode;
   *fl_get_form_vclass = \&fl_vmode;
   *fl_default_win = \&fl_default_window;
   *fl_mapcolor_name = \&fl_mapcolorname;

sub FL_ALIGN_BOTTOM {2;}
sub FL_ALIGN_BOTTOM_LEFT {6;} 
sub FL_ALIGN_BOTTOM_RIGHT {10;} 
sub FL_ALIGN_CENTER {0;}
sub FL_ALIGN_INSIDE {8192;}
sub FL_ALIGN_LEFT {4;}
sub FL_ALIGN_LEFT_BOTTOM {6;}
sub FL_ALIGN_LEFT_TOP {5;}
sub FL_ALIGN_RIGHT {8;}
sub FL_ALIGN_RIGHT_BOTTOM {10;}
sub FL_ALIGN_RIGHT_TOP {9;}
sub FL_ALIGN_TOP {1;}
sub FL_ALIGN_TOP_LEFT {5;}
sub FL_ALIGN_TOP_RIGHT {9;}
sub FL_ALIGN_VERT {16384;}
sub FL_ALT_VAL {131072;}
sub FL_ALWAYS_ON {2;}
sub FL_ANALOG_CLOCK {0;}
sub FL_BEGIN_GROUP {10000;}
sub FL_BITMAP {7;}
sub FL_BITMAPBUTTON {5;}
sub FL_BITMAPBUTTON_ALIGN {2;}
sub FL_BITMAPBUTTON_BOXTYPE {1;}
sub FL_BITMAPBUTTON_COL1 {11;}
sub FL_BITMAPBUTTON_COL2 {4;}
sub FL_BITMAPBUTTON_LCOL {0;}
sub FL_BITMAP_ALIGN {2;}
sub FL_BITMAP_BOXTYPE {0;}
sub FL_BITMAP_COL1 {11;}
sub FL_BITMAP_COL2 {11;}
sub FL_BITMAP_LCOL {0;}
sub FL_BITMAP_MAXSIZE {16384;}
sub FL_BLACK {0;}
sub FL_BLUE {4;}
sub FL_BOLDITALIC_STYLE {3;}
sub FL_BOLD_STYLE {1;}
sub FL_BORDER_BOX {4;}
sub FL_BORDER_FRAME {3;}
sub FL_BOTTOM_BCOL {13;}
sub FL_BOUND_WIDTH {3;}
sub FL_BOX {9;}
sub FL_BROWSER {18;}
sub FL_BROWSER_ALIGN {2;}
sub FL_BROWSER_BOXTYPE {2;}
sub FL_BROWSER_COL1 {11;}
sub FL_BROWSER_COL2 {3;}
sub FL_BROWSER_FONTSIZE {10;}
sub FL_BROWSER_LCOL {0;}
sub FL_BROWSER_LINELENGTH {1024;}
sub FL_BROWSER_SLCOL {11;}
sub FL_BROWSER_SLIDER {6;}
sub FL_BROWSER_SLIDER2 {7;}
sub FL_BUILT_IN_COLS {29;}
sub FL_BUTTON {1;}
sub FL_BUTTON_ALIGN {0;}
sub FL_BUTTON_BOXTYPE {1;}
sub FL_BUTTON_BW {3;}
sub FL_BUTTON_COL1 {11;}
sub FL_BUTTON_COL2 {11;}
sub FL_BUTTON_LCOL {0;}
sub FL_BUTTON_MCOL1 {16;}
sub FL_BUTTON_MCOL2 {16;}
sub FL_CANCEL {0;}
sub FL_CHECKBUTTON {4;}
sub FL_CHECKBUTTON_ALIGN {0;}
sub FL_CHECKBUTTON_BOXTYPE {0;}
sub FL_CHECKBUTTON_COL1 {11;}
sub FL_CHECKBUTTON_COL2 {3;}
sub FL_CHECKBUTTON_LCOL {0;}
sub FL_CHECKBUTTON_MCOL {16;}
sub FL_CHECKBUTTON_TOPCOL {11;}
sub FL_CLOCK {21;}
sub FL_CLOCK_ALIGN {2;}
sub FL_CLOCK_BOXTYPE {1;}
sub FL_CLOCK_COL1 {17;}
sub FL_CLOCK_COL2 {13;}
sub FL_CLOCK_LCOL {0;}
sub FL_CLOCK_TOPCOL {11;}
sub FL_COL1 {11;}
sub FL_COORD_MM {1;}
sub FL_COORD_PIXEL {0;}
sub FL_COORD_POINT {2;}
sub FL_COORD_centiMM {3;}
sub FL_COORD_centiPOINT {4;}
sub FL_CYAN {6;}
sub FL_DARKCYAN {21;}
sub FL_DARKGOLD {19;}
sub FL_DARKORANGE {23;}
sub FL_DARKTOMATO {22;}
sub FL_DARKVIOLET {26;}
sub FL_DBLCLICK {16;}
sub FL_DEEPPINK {24;}
sub FL_DEFAULT_FONT {10;}
sub FL_DEFAULT_SIZE {10;}
sub FL_DOGERBLUE {28;}
sub FL_DOWN_BOX {2;}
sub FL_DOWN_FRAME {2;}
sub FL_DRAW {1;}
sub FL_DRAWLABEL {15;}
sub FL_EMBOSSED_FRAME {7;}
sub FL_EMBOSSED_STYLE {524288;}
sub FL_END_GROUP {20000;}
sub FL_ENGRAVED_FRAME {5;}
sub FL_ENGRAVED_STYLE {262144;}
sub FL_ENTER {4;}
sub FL_EXCEPT {4;}
sub FL_FIXEDBOLDITALIC_STYLE {7;}
sub FL_FIXEDBOLD_STYLE {5;}
sub FL_FIXEDITALIC_STYLE {6;}
sub FL_FIXED_STYLE {4;}
sub FL_FIX_SIZE {32768;}
sub FL_FLAT_BOX {3;}
sub FL_FLOAT_INPUT {1;}
sub FL_FOCUS {7;}
sub FL_FOLDERTAB {25;}
sub FL_FRAME {27;}
sub FL_FRAME_BOX {6;}
sub FL_FREEMEM {13;}
sub FL_FREE_COL1 {256;}
sub FL_FREE_COL10 {265;}
sub FL_FREE_COL11 {266;}
sub FL_FREE_COL12 {267;}
sub FL_FREE_COL13 {268;}
sub FL_FREE_COL14 {269;}
sub FL_FREE_COL15 {270;}
sub FL_FREE_COL16 {271;}
sub FL_FREE_COL2 {257;}
sub FL_FREE_COL3 {258;}
sub FL_FREE_COL4 {259;}
sub FL_FREE_COL5 {260;}
sub FL_FREE_COL6 {261;}
sub FL_FREE_COL7 {262;}
sub FL_FREE_COL8 {263;}
sub FL_FREE_COL9 {264;}
sub FL_FREE_SIZE {16384;}
sub FL_FULLBORDER {1;}
sub FL_GRAY16 {12;}
sub FL_GRAY35 {13;}
sub FL_GRAY63 {11;}
sub FL_GRAY75 {16;}
sub FL_GRAY80 {14;}
sub FL_GRAY90 {15;}
sub FL_GREEN {2;}
sub FL_HIDDEN_BUTTON {3;}
sub FL_HIDDEN_INPUT {3;}
sub FL_HIDDEN_RET_BUTTON {7;}
sub FL_HIDDEN_TIMER {2;}
sub FL_HOLD_BROWSER {2;}
sub FL_HUGE_FONT {24;}
sub FL_HUGE_SIZE {24;}
sub FL_IGNORE {-1;}
sub FL_INACTIVE {17;}
sub FL_INACTIVE_COL {17;}
sub FL_INDIANRED {9;}
sub FL_INOUT_BUTTON {5;}
sub FL_INPUT {17;}
sub FL_INPUT_ALIGN {4;}
sub FL_INPUT_BOXTYPE {2;}
sub FL_INPUT_CCOL {4;}
sub FL_INPUT_COL1 {11;}
sub FL_INPUT_COL2 {16;}
sub FL_INPUT_FREE {2;}
sub FL_INPUT_LCOL {0;}
sub FL_INPUT_TCOL {0;}
sub FL_INT_INPUT {2;}
sub FL_INVALID {0;}
sub FL_INVALID_CLASS {0;}
sub FL_INVALID_STYLE {-1;}
sub FL_ITALIC_STYLE {2;}
sub FL_KEYBOARD {9;}
sub FL_KEY_ALL {7;}
sub FL_KEY_NONE {0;}
sub FL_KEY_NORMAL {2;}
sub FL_KEY_SPECIAL {4;}
sub FL_KEY_TAB {1;}
sub FL_LARGE_FONT {18;}
sub FL_LARGE_SIZE {18;}
sub FL_LEAVE {5;}
sub FL_LEFT_BCOL {15;}
sub FL_LIGHTBUTTON {2;}
sub FL_LIGHTBUTTON_ALIGN {0;}
sub FL_LIGHTBUTTON_BOXTYPE {1;}
sub FL_LIGHTBUTTON_COL1 {11;}
sub FL_LIGHTBUTTON_COL2 {3;}
sub FL_LIGHTBUTTON_LCOL {0;}
sub FL_LIGHTBUTTON_MCOL {16;}
sub FL_LIGHTBUTTON_MINSIZE {12;}
sub FL_LIGHTBUTTON_TOPCOL {11;}
sub FL_LINEAR {0;}
sub FL_LOG {1;}
sub FL_MAGENTA {5;}
sub FL_MAXFONTS {32;}
sub FL_MAX_COLS {1024;}
sub FL_MAX_FONTSIZES {10;}
sub FL_MCOL {16;}
sub FL_MEDIUM_FONT {14;}
sub FL_MEDIUM_SIZE {14;}
sub FL_MINDEPTH {1;}
sub FL_MOTION {10;}
sub FL_MOUSE {6;}
sub FL_MOVE {10;}
sub FL_MULTILINE_INPUT {4;}
sub FL_MULTI_BROWSER {3;}
sub FL_NOBORDER {0;}
sub FL_NOEVENT {0;}
sub FL_NONE {0;}
sub FL_NORMAL_BROWSER {0;}
sub FL_NORMAL_BUTTON {0;}
sub FL_NORMAL_FONT {12;}
sub FL_NORMAL_FONT1 {10;}
sub FL_NORMAL_FONT2 {12;}
sub FL_NORMAL_INPUT {0;}
sub FL_NORMAL_PIXMAP {0;}
sub FL_NORMAL_SIZE {12;}
sub FL_NORMAL_STYLE {0;}
sub FL_NORMAL_TEXT {0;}
sub FL_NORMAL_TIMER {0;}
sub FL_NO_BOX {0;}
sub FL_NO_FRAME {0;}
sub FL_OFF {0;}
sub FL_OK {1;}
sub FL_ON {1;}
sub FL_ORCHID {20;}
sub FL_OSHADOW_BOX {11;}
sub FL_OTHER {14;}
sub FL_OVAL_BOX {10;}
sub FL_OVAL_FRAME {8;}
sub FL_PALEGREEN {18;}
sub FL_PIXMAP {8;}
sub FL_PIXMAPBUTTON {6;}
sub FL_PIXMAPBUTTON_ALIGN {2;}
sub FL_PIXMAPBUTTON_BOXTYPE {1;}
sub FL_PIXMAPBUTTON_COL1 {11;}
sub FL_PIXMAPBUTTON_COL2 {3;}
sub FL_PIXMAPBUTTON_LCOL {0;}
sub FL_PLACE_ASPECT {32;}
sub FL_PLACE_CENTER {2;}
sub FL_PLACE_CENTERFREE {16386;}
sub FL_PLACE_FREE {0;}
sub FL_PLACE_FREE_CENTER {16386;}
sub FL_PLACE_FULLSCREEN {64;}
sub FL_PLACE_GEOMETRY {16;}
sub FL_PLACE_HOTSPOT {128;}
sub FL_PLACE_ICONIC {256;}
sub FL_PLACE_MOUSE {1;}
sub FL_PLACE_POSITION {4;}
sub FL_PLACE_SIZE {8;}
sub FL_PREEMPT {1;}
sub FL_PS {18;}
sub FL_PUSH {2;}
sub FL_PUSH_BUTTON {1;}
sub FL_RADIO_BUTTON {2;}
sub FL_READ {1;}
sub FL_RED {1;}
sub FL_RELEASE {3;}
sub FL_RESIZE_ALL {3;}
sub FL_RESIZE_NONE {0;}
sub FL_RESIZE_X {1;}
sub FL_RESIZE_Y {2;}
sub FL_RETURN_ALWAYS {3;}
sub FL_RETURN_BUTTON {6;}
sub FL_RETURN_CHANGED {1;}
sub FL_RETURN_DBLCLICK {4;}
sub FL_RETURN_END {2;}
sub FL_RETURN_END_CHANGED {0;}
sub FL_RFLAT_BOX {8;}
sub FL_RIGHT_BCOL {12;}
sub FL_RINGBELL {16;}
sub FL_ROUNDBUTTON {3;}
sub FL_ROUNDBUTTON_ALIGN {0;}
sub FL_ROUNDBUTTON_BOXTYPE {0;}
sub FL_ROUNDBUTTON_COL1 {16;}
sub FL_ROUNDBUTTON_COL2 {3;}
sub FL_ROUNDBUTTON_LCOL {0;}
sub FL_ROUNDBUTTON_MCOL {16;}
sub FL_ROUNDBUTTON_TOPCOL {11;}
sub FL_ROUNDED_BOX {7;}
sub FL_ROUNDED_FRAME {6;}
sub FL_RSHADOW_BOX {9;}
sub FL_SCROLLBAR_ALWAYS_ON {2;}
sub FL_SCROLLBAR_OFF {0;}
sub FL_SCROLLBAR_ON {1;}
sub FL_SECRET_INPUT {5;}
sub FL_SELECT_BROWSER {1;}
sub FL_SHADOW_BOX {5;}
sub FL_SHADOW_FRAME {4;}
sub FL_SHADOW_STYLE {131072;}
sub FL_SHORTCUT {12;}
sub FL_SLATEBLUE {10;}
sub FL_SMALL_FONT {10;}
sub FL_SMALL_SIZE {10;}
sub FL_SPRINGGREEN {27;}
sub FL_STEP {11;}
sub FL_TEXT {10;}
sub FL_TEXT_ALIGN {4;}
sub FL_TEXT_BOXTYPE {3;}
sub FL_TEXT_COL1 {11;}
sub FL_TEXT_COL2 {16;}
sub FL_TEXT_LCOL {0;}
sub FL_TIMER {20;}
sub FL_TIMER_ALIGN {0;}
sub FL_TIMER_BLINKRATE {.2;}
sub FL_TIMER_BOXTYPE {2;}
sub FL_TIMER_COL1 {11;}
sub FL_TIMER_COL2 {1;}
sub FL_TIMER_EVENT {1073741824;}
sub FL_TIMER_LCOL {0;}
sub FL_TIMESBOLDITALIC_STYLE {11;}
sub FL_TIMESBOLD_STYLE {9;}
sub FL_TIMESITALIC_STYLE {10;}
sub FL_TIMES_STYLE {8;}
sub FL_TINY_FONT {8;}
sub FL_TINY_SIZE {8;}
sub FL_TOMATO {8;}
sub FL_TOP_BCOL {14;}
sub FL_TOUCH_BUTTON {4;}
sub FL_TRANSIENT {-1;}
sub FL_TRPLCLICK {17;}
sub FL_UNFOCUS {8;}
sub FL_UP_BOX {1;}
sub FL_UP_FRAME {1;}
sub FL_VALID {1;}
sub FL_VALUE_TIMER {1;}
sub FL_WHITE {7;}
sub FL_WM_NORMAL {2;}
sub FL_WM_SHIFT {1;}
sub FL_WRITE {2;}
sub FL_YELLOW {3;}
sub fl_add_bitmap {fl_add_flobject(FL_BITMAP(),@_);}
sub fl_add_bitmapbutton {fl_add_flobject(FL_BITMAPBUTTON(),@_);}
sub fl_add_box {fl_add_flobject(FL_BOX(),@_);}
sub fl_add_browser {fl_add_flobject(FL_BROWSER(),@_);}
sub fl_add_button {fl_add_flobject(FL_BUTTON(),@_);}
sub fl_add_checkbutton {fl_add_flobject(FL_CHECKBUTTON(),@_);}
sub fl_add_clock {fl_add_flobject(FL_CLOCK(),@_);}
sub fl_add_foldertab {fl_add_flobject(FL_FOLDERTAB(),@_);}
sub fl_add_frame {fl_add_flobject(FL_FRAME(),@_);}
sub fl_add_input {fl_add_flobject(FL_INPUT(),@_);}
sub fl_add_lightbutton {fl_add_flobject(FL_LIGHTBUTTON(),@_);}
sub fl_add_pixmap {fl_add_flobject(FL_PIXMAP(),@_);}
sub fl_add_pixmapbutton {fl_add_flobject(FL_PIXMAPBUTTON(),@_);}
sub fl_add_roundbutton {fl_add_flobject(FL_ROUNDBUTTON(),@_);}
sub fl_add_text {fl_add_flobject(FL_TEXT(),@_);}
sub fl_add_timer {fl_add_flobject(FL_TIMER(),@_);}
sub fl_create_bitmap {fl_create_flobject(FL_BITMAP(),@_);}
sub fl_create_bitmapbutton {fl_create_flobject(FL_BITMAPBUTTON(),@_);}
sub fl_create_box {fl_create_flobject(FL_BOX(),@_);}
sub fl_create_browser {fl_create_flobject(FL_BROWSER(),@_);}
sub fl_create_button {fl_create_flobject(FL_BUTTON(),@_);}
sub fl_create_checkbutton {fl_create_flobject(FL_CHECKBUTTON(),@_);}
sub fl_create_clock {fl_create_flobject(FL_CLOCK(),@_);}
sub fl_create_foldertab {fl_create_flobject(FL_FOLDERTAB(),@_);}
sub fl_create_frame {fl_create_flobject(FL_FRAME(),@_);}
sub fl_create_input {fl_create_flobject(FL_INPUT(),@_);}
sub fl_create_lightbutton {fl_create_flobject(FL_LIGHTBUTTON(),@_);}
sub fl_create_pixmap {fl_create_flobject(FL_PIXMAP(),@_);}
sub fl_create_pixmapbutton {fl_create_flobject(FL_PIXMAPBUTTON(),@_);}
sub fl_create_roundbutton {fl_create_flobject(FL_ROUNDBUTTON(),@_);}
sub fl_create_text {fl_create_flobject(FL_TEXT(),@_);}
sub fl_create_timer {fl_create_flobject(FL_TIMER(),@_);}
sub fl_reset_cursor {fl_set_cursor(@_,0);}
sub fl_set_object_dblclick {my($ob, $t) = @_; $ob->click_timeout(t);}
1;
__END__
