#    Xforms.pm - An extension to PERL to access XForms functions.
#    Copyright (C) 1996-1997  Martin Bartlett
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

package Xforms;

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(

fl_XEventsQueued
fl_XNextEvent
fl_XPeekEvent
fl_XPutBackEvent
fl_activate_all_forms
fl_activate_event_callbacks
fl_activate_form
fl_activate_glcanvas
fl_activate_object
fl_add_bitmap
fl_add_bitmapbutton
fl_add_box
fl_add_browser
fl_add_browser_line
fl_add_button
fl_add_canvas
fl_add_canvas_handler
fl_add_chart
fl_add_chart_value
fl_add_checkbutton
fl_add_choice
fl_add_clock
fl_add_counter
fl_add_dial
fl_add_event_callback
fl_add_float_vertex
fl_add_frame
fl_add_free
fl_add_fselector_appbutton
fl_add_glcanvas
fl_add_input
fl_add_io_callback
fl_add_labelframe
fl_add_lightbutton
fl_add_menu
fl_add_object
fl_add_pixmap
fl_add_pixmapbutton
fl_add_positioner
fl_add_round3dbutton
fl_add_roundbutton
fl_add_selected_xevent
fl_add_signal_callback
fl_add_slider
fl_add_text
fl_add_textbox
fl_add_timeout
fl_add_timer
fl_add_valslider
fl_add_vertex
fl_add_xyplot
fl_add_xyplot_overlay
fl_add_xyplot_overlay_file
fl_add_xyplot_text
fl_addto_browser
fl_addto_browser_chars
fl_addto_choice
fl_addto_command_log
fl_addto_form
fl_addto_group
fl_addto_menu
fl_addto_selected_xevent
fl_addtopup
fl_adjust_form_size
fl_app_signal_direct
fl_append_browser
fl_arc
fl_arcf
fl_bgn_form
fl_bgn_group
fl_bgnclosedline
fl_bgnline
fl_bgnpolygon
fl_bk_color
fl_bk_textcolor
fl_call_object_callback
fl_canvas_yield_to_shortcut
fl_check_forms
fl_check_only_forms
fl_circ
fl_circf
fl_clear_browser
fl_clear_chart
fl_clear_choice
fl_clear_command_log
fl_clear_menu
fl_clear_textbox
fl_clear_xyplot
fl_close_command
fl_color
fl_compute_object_geometry
fl_create_GC
fl_create_bitmap
fl_create_bitmap_cursor
fl_create_bitmapbutton
fl_create_box
fl_create_browser
fl_create_button
fl_create_canvas
fl_create_chart
fl_create_checkbutton
fl_create_choice
fl_create_clock
fl_create_counter
fl_create_dial
fl_create_frame
fl_create_free
fl_create_from_bitmapdata
fl_create_from_pixmapdata
fl_create_generic_button
fl_create_generic_canvas
fl_create_glcanvas
fl_create_input
fl_create_labelframe
fl_create_lightbutton
fl_create_menu
fl_create_pixmap
fl_create_pixmapbutton
fl_create_positioner
fl_create_round3dbutton
fl_create_roundbutton
fl_create_slider
fl_create_text
fl_create_textbox
fl_create_timer
fl_create_valslider
fl_create_xyplot
fl_current_form
fl_dashedlinestyle
fl_deactivate_all_forms
fl_deactivate_form
fl_deactivate_object
fl_default_win
fl_default_window
fl_defpup
fl_delete_browser_line
fl_delete_choice
fl_delete_menu_item
fl_delete_object
fl_delete_xyplot_overlay
fl_delete_xyplot_text
fl_deselect_browser
fl_deselect_browser_line
fl_diagline
fl_disable_fselector_cache
fl_display
fl_do_forms
fl_do_only_forms
fl_dopup
fl_draw_object_label
fl_draw_object_label_outside
fl_draw_object_outside_label
fl_draw_text
fl_drawmode
fl_drw_box
fl_drw_checkbox
fl_drw_frame
fl_drw_slider
fl_drw_text
fl_drw_text_beside
fl_drw_text_cursor
fl_end_all_command
fl_end_command
fl_end_form
fl_end_group
fl_endclosedline
fl_endline
fl_endpolygon
fl_exe_command
fl_fill_rectangle
fl_finish
fl_fit_object_label
fl_form_is_visible
fl_free_colors
fl_free_form
fl_free_object
fl_free_pixels
fl_free_pixmap
fl_free_pixmap_pixmap
fl_free_pixmapbutton_pixmap
fl_freepup
fl_freeze_all_forms
fl_freeze_form
fl_get_align_xy
fl_get_app_mainform
fl_get_app_resources
fl_get_border_width
fl_get_browser
fl_get_browser_dimension
fl_get_browser_line
fl_get_browser_maxline
fl_get_browser_screenlines
fl_get_browser_topline
fl_get_button
fl_get_button_numb
fl_get_canvas_colormap
fl_get_canvas_depth
fl_get_canvas_id
fl_get_char_height
fl_get_char_width
fl_get_choice
fl_get_choice_item_text
fl_get_choice_maxitems
fl_get_choice_text
fl_get_clock
fl_get_command_log_fdstruct
fl_get_coordunit
fl_get_counter_bounds
fl_get_counter_value
fl_get_cursor_byname
fl_get_defaults
fl_get_dial_bounds
fl_get_dial_value
fl_get_directory
fl_get_display
fl_get_drawmode
fl_get_filename
fl_get_flcolor
fl_get_fntstruct
fl_get_font_struct
fl_get_fontstruct
fl_get_form_event_cmask
fl_get_form_mouse
fl_get_form_vclass
fl_get_fselector_fdstruct
fl_get_fselector_form
fl_get_glcanvas_attributes
fl_get_glcanvas_context
fl_get_glcanvas_defaults
fl_get_glcanvas_xvisualinfo
fl_get_icm_color
fl_get_input
fl_get_input_cursorpos
fl_get_input_format
fl_get_input_numberoflines
fl_get_input_screenlines
fl_get_input_topline
fl_get_linestyle
fl_get_linewidth
fl_get_menu
fl_get_menu_item_mode
fl_get_menu_item_text
fl_get_menu_maxitems
fl_get_menu_text
fl_get_mouse
fl_get_object_bbox
fl_get_object_geometry
fl_get_object_position
fl_get_pattern
fl_get_pixel
fl_get_pixmap_pixmap
fl_get_pixmapbutton_pixmap
fl_get_positioner_xbounds
fl_get_positioner_xvalue
fl_get_positioner_ybounds
fl_get_positioner_yvalue
fl_get_resource
fl_get_slider_bounds
fl_get_slider_value
fl_get_string_dimension
fl_get_string_height
fl_get_string_size
fl_get_string_width
fl_get_string_widthTAB
fl_get_textbox_longestline
fl_get_timer
fl_get_vclass
fl_get_visual_depth
fl_get_vmode
fl_get_win_geometry
fl_get_win_mouse
fl_get_win_origin
fl_get_win_size
fl_get_wingeometry
fl_get_winorigin
fl_get_winsize
fl_get_xyplot
fl_get_xyplot_data
fl_get_xyplot_xbounds
fl_get_xyplot_xmapping
fl_get_xyplot_ybounds
fl_get_xyplot_ymapping
fl_getmcolor
fl_getpup_mode
fl_getpup_text
fl_gettime
fl_glwincreate
fl_glwinopen
fl_hide_canvas
fl_hide_command_log
fl_hide_form
fl_hide_fselector
fl_hide_object
fl_hide_oneliner
fl_hidepup
fl_initial_wingeometry
fl_initial_winposition
fl_initial_winsize
fl_initial_winstate
fl_initialize
fl_insert_browser_line
fl_insert_chart_value
fl_interpolate
fl_invalidate_fselector_cache
fl_isselected_browser_line
fl_keypressed
fl_keysym_pressed
fl_last_event
fl_library_version
fl_line
fl_lines
fl_linestyle
fl_linewidth
fl_load_browser
fl_lower_form
fl_make_object
fl_mapcolor
fl_mapcolor_name
fl_mapcolorname
fl_mode_capable
fl_modify_canvas_prop
fl_mouse_button
fl_mousebutton
fl_msleep
fl_newpup
fl_noborder
fl_open_command
fl_oval
fl_oval_bound
fl_ovalarc
fl_ovalbound
fl_ovalf
fl_ovall
fl_pieslice
fl_polybound
fl_polyf
fl_polygon
fl_polyl
fl_pref_wingeometry
fl_pref_winposition
fl_pref_winsize
fl_prepare_form_window
fl_print_xevent_name
fl_raise_form
fl_read_bitmapfile
fl_read_pixmapfile
fl_rect
fl_rectangle
fl_rectbound
fl_rectf
fl_redraw_form
fl_redraw_object
fl_refresh_fselector
fl_register_callback
fl_register_raw_callback
fl_remove_canvas_handler
fl_remove_event_callback
fl_remove_fselector_appbutton
fl_remove_io_callback
fl_remove_selected_xevent
fl_remove_signal_callback
fl_remove_timeout
fl_replace_browser_line
fl_replace_chart_value
fl_replace_choice
fl_replace_menu_item
fl_replace_xyplot_point
fl_reset_cursor
fl_reset_focus_object
fl_reset_vertex
fl_reset_winconstraints
fl_resume_timer
fl_ringbell
fl_root
fl_roundrect
fl_roundrectangle
fl_roundrectf
fl_scale_form
fl_scale_object
fl_screen
fl_scrh
fl_scrw
fl_select_browser_line
fl_set_app_mainform
fl_set_app_nomainform
fl_set_atclose
fl_set_background
fl_set_bitmap_data
fl_set_bitmap_datafile
fl_set_bitmap_file
fl_set_bitmapbutton_data
fl_set_bitmapbutton_datafile
fl_set_bitmapbutton_file
fl_set_border_width
fl_set_browser_dblclick_callback
fl_set_browser_fontsize
fl_set_browser_fontstyle
fl_set_browser_hscrollbar
fl_set_browser_leftscrollbar
fl_set_browser_leftslider
fl_set_browser_line_selectable
fl_set_browser_scrollbarsize
fl_set_browser_specialkey
fl_set_browser_topline
fl_set_browser_vscrollbar
fl_set_browser_xoffset
fl_set_button
fl_set_button_shortcut
fl_set_call_back
fl_set_canvas_attributes
fl_set_canvas_colormap
fl_set_canvas_decoration
fl_set_canvas_depth
fl_set_canvas_visual
fl_set_chart_autosize
fl_set_chart_bounds
fl_set_chart_lcol
fl_set_chart_lcolor
fl_set_chart_lsize
fl_set_chart_lstyle
fl_set_chart_maxnumb
fl_set_choice
fl_set_choice_align
fl_set_choice_fontsize
fl_set_choice_fontstyle
fl_set_choice_item_mode
fl_set_choice_item_shortcut
fl_set_choice_shortcut
fl_set_choice_text
fl_set_choices_shortcut
fl_set_clipping
fl_set_clippings
fl_set_color_leak
fl_set_command_log_position
fl_set_coordunit
fl_set_counter_bounds
fl_set_counter_filter
fl_set_counter_precision
fl_set_counter_return
fl_set_counter_step
fl_set_counter_value
fl_set_cursor
fl_set_cursor_color
fl_set_defaults
fl_set_dial_angles
fl_set_dial_bounds
fl_set_dial_cross
fl_set_dial_direction
fl_set_dial_return
fl_set_dial_step
fl_set_dial_value
fl_set_directory
fl_set_dirlist_sort
fl_set_drawmode
fl_set_event_callback
fl_set_focus_object
fl_set_font
fl_set_font_name
fl_set_foreground
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
fl_set_form_icon
fl_set_form_maxsize
fl_set_form_minsize
fl_set_form_position
fl_set_form_property
fl_set_form_size
fl_set_form_title
fl_set_fselector_border
fl_set_fselector_callback
fl_set_fselector_cb
fl_set_fselector_filetype_marker
fl_set_fselector_fontsize
fl_set_fselector_fontstyle
fl_set_fselector_placement
fl_set_fselector_title
fl_set_fselector_transient
fl_set_gamma
fl_set_gc_clipping
fl_set_glcanvas_attributes
fl_set_glcanvas_defaults
fl_set_glcanvas_direct
fl_set_goodies_font
fl_set_graphics_mode
fl_set_icm_color
fl_set_idle_callback
fl_set_idle_delta
fl_set_initial_placement
fl_set_input
fl_set_input_color
fl_set_input_cursorpos
fl_set_input_editkeymap
fl_set_input_filter
fl_set_input_format
fl_set_input_hscrollbar
fl_set_input_maxchars
fl_set_input_return
fl_set_input_scroll
fl_set_input_scrollbarsize
fl_set_input_selected
fl_set_input_selected_range
fl_set_input_shortcut
fl_set_input_topline
fl_set_input_vscrollbar
fl_set_input_xoffset
fl_set_linestyle
fl_set_linewidth
fl_set_menu
fl_set_menu_item_mode
fl_set_menu_item_shortcut
fl_set_menu_popup
fl_set_mouse
fl_set_object_align
fl_set_object_automatic
fl_set_object_boxtype
fl_set_object_bw
fl_set_object_callback
fl_set_object_color
fl_set_object_dblbuffer
fl_set_object_dblclick
fl_set_object_focus
fl_set_object_geometry
fl_set_object_gravity
fl_set_object_label
fl_set_object_lalign
fl_set_object_lcol
fl_set_object_lcolor
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
fl_set_oneliner_color
fl_set_oneliner_font
fl_set_pattern
fl_set_pixmap_align
fl_set_pixmap_colorcloseness
fl_set_pixmap_data
fl_set_pixmap_file
fl_set_pixmap_pixmap
fl_set_pixmapbutton_align
fl_set_pixmapbutton_data
fl_set_pixmapbutton_datafile
fl_set_pixmapbutton_file
fl_set_pixmapbutton_focus_outline
fl_set_pixmapbutton_pixmap
fl_set_positioner_return
fl_set_positioner_xbounds
fl_set_positioner_xstep
fl_set_positioner_xvalue
fl_set_positioner_ybounds
fl_set_positioner_ystep
fl_set_positioner_yvalue
fl_set_resource
fl_set_slider_bounds
fl_set_slider_filter
fl_set_slider_increment
fl_set_slider_precision
fl_set_slider_return
fl_set_slider_size
fl_set_slider_step
fl_set_slider_value
fl_set_tabstop
fl_set_text_clipping
fl_set_textbox_topline
fl_set_textbox_xoffset
fl_set_timer
fl_set_timer_countup
fl_set_timer_filter
fl_set_ul_property
fl_set_visualID
fl_set_winstepunit
fl_set_xyplot_alphaytics
fl_set_xyplot_data
fl_set_xyplot_datafile
fl_set_xyplot_file
fl_set_xyplot_fixed_xaxis
fl_set_xyplot_fixed_yaxis
fl_set_xyplot_fontsize
fl_set_xyplot_fontstyle
fl_set_xyplot_inspect
fl_set_xyplot_interpolate
fl_set_xyplot_linewidth
fl_set_xyplot_maxoverlays
fl_set_xyplot_overlay_type
fl_set_xyplot_return
fl_set_xyplot_symbolsize
fl_set_xyplot_xbounds
fl_set_xyplot_xgrid
fl_set_xyplot_xscale
fl_set_xyplot_xtics
fl_set_xyplot_ybounds
fl_set_xyplot_ygrid
fl_set_xyplot_yscale
fl_set_xyplot_ytics
fl_setpup
fl_setpup_bw
fl_setpup_checkcolor
fl_setpup_color
fl_setpup_cursor
fl_setpup_default_cursor
fl_setpup_fontsize
fl_setpup_fontstyle
fl_setpup_hotkey
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
fl_show_alert
fl_show_choice
fl_show_choices
fl_show_colormap
fl_show_command_log
fl_show_errors
fl_show_file_selector
fl_show_form
fl_show_form_window
fl_show_fselector
fl_show_input
fl_show_menu_symbol
fl_show_message
fl_show_messages
fl_show_object
fl_show_oneliner
fl_show_question
fl_show_simple_input
fl_showpup
fl_signal_caught
fl_simple_line
fl_suspend_timer
fl_textcolor
fl_textgc
fl_transient
fl_trigger_object
fl_ul_magic_char
fl_unfreeze_all_forms
fl_unfreeze_form
fl_unset_clipping
fl_unset_gc_clipping
fl_unset_text_clipping
fl_use_fselector
fl_vclass_name
fl_vclass_val
fl_vmode
fl_vroot
fl_win_background
fl_win_to_form
fl_winaspect
fl_winbackground
fl_winclose
fl_wincreate
fl_wingeometry
fl_winget
fl_winhide
fl_winicon
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
fl_xyplot_s2w
fl_xyplot_w2s

FL_ACTIVE_XYPLOT
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
FL_ALL_FREE
FL_ALPHASORT
FL_ALT_MASK
FL_ALT_VAL
FL_ALWAYS_ON
FL_ANALOG_CLOCK
FL_ATTRIB
FL_AUTO
FL_BAR_CHART
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
FL_BOOL
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
FL_CANVAS
FL_CANVAS_ALIGN
FL_CANVAS_BOXTYPE
FL_CHART
FL_CHARTREUSE
FL_CHART_ALIGN
FL_CHART_BOXTYPE
FL_CHART_COL1
FL_CHART_LCOL
FL_CHART_MAX
FL_CHECKBUTTON
FL_CHECKBUTTON_ALIGN
FL_CHECKBUTTON_BOXTYPE
FL_CHECKBUTTON_COL1
FL_CHECKBUTTON_COL2
FL_CHECKBUTTON_LCOL
FL_CHECKBUTTON_MCOL
FL_CHECKBUTTON_TOPCOL
FL_CHOICE
FL_CHOICE_ALIGN
FL_CHOICE_BOXTYPE
FL_CHOICE_COL1
FL_CHOICE_COL2
FL_CHOICE_LCOL
FL_CHOICE_MAXITEMS
FL_CHOICE_MCOL
FL_CIRCLE_XYPLOT
FL_CLASS_END
FL_CLASS_START
FL_CLICK_TIMEOUT
FL_CLOCK
FL_CLOCK_ALIGN
FL_CLOCK_BOXTYPE
FL_CLOCK_COL1
FL_CLOCK_COL2
FL_CLOCK_LCOL
FL_CLOCK_TOPCOL
FL_CLOSE
FL_COL1
FL_CONTINUOUS_FREE
FL_CONTROL_MASK
FL_COORD_MM
FL_COORD_PIXEL
FL_COORD_POINT
FL_COORD_centiMM
FL_COORD_centiPOINT
FL_COUNTER
FL_COUNTER_ALIGN
FL_COUNTER_BOXTYPE
FL_COUNTER_BW
FL_COUNTER_COL1
FL_COUNTER_COL2
FL_COUNTER_LCOL
FL_CYAN
FL_DARKCYAN
FL_DARKGOLD
FL_DARKORANGE
FL_DARKTOMATO
FL_DARKVIOLET
FL_DASHED_XYPLOT
FL_DATE_INPUT
FL_DBLCLICK
FL_DEEPPINK
FL_DEFAULT_CURSOR
FL_DEFAULT_FONT
FL_DEFAULT_SIZE
FL_DIAL
FL_DIAL_ALIGN
FL_DIAL_BOXTYPE
FL_DIAL_CCW
FL_DIAL_COL1
FL_DIAL_COL2
FL_DIAL_CW
FL_DIAL_LCOL
FL_DIAL_TOPCOL
FL_DIGITAL_CLOCK
FL_DODGERBLUE
FL_DOGERBLUE
FL_DOWN_BOX
FL_DOWN_FRAME
FL_DRAW
FL_DRAWLABEL
FL_DROPLIST_CHOICE
FL_DefaultVisual
FL_EMBOSSED_BOX
FL_EMBOSSED_FRAME
FL_EMBOSSED_STYLE
FL_EMPTY_XYPLOT
FL_END_GROUP
FL_ENGRAVED_FRAME
FL_ENGRAVED_STYLE
FL_ENTER
FL_EXCEPT
FL_East
FL_FILLED_CHART
FL_FILL_CHART
FL_FILL_DIAL
FL_FILL_XYPLOT
FL_FIXEDBOLDITALIC_STYLE
FL_FIXEDBOLD_STYLE
FL_FIXEDITALIC_STYLE
FL_FIXED_STYLE
FL_FIX_SIZE
FL_FLAT_BOX
FL_FLOAT
FL_FLOAT_INPUT
FL_FOCUS
FL_FOLDER
FL_FOLDERTAB
FL_FRAME
FL_FRAME_BOX
FL_FRAME_COL1
FL_FRAME_COL2
FL_FRAME_LCOL
FL_FREE
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
FL_ForgetGravity
FL_GLCANVAS
FL_GRAY16
FL_GRAY35
FL_GRAY63
FL_GRAY75
FL_GRAY80
FL_GRAY90
FL_GREEN
FL_GRID_MINOR
FL_GRID_NONE
FL_GrayScale
FL_HIDDEN_BUTTON
FL_HIDDEN_INPUT
FL_HIDDEN_RET_BUTTON
FL_HIDDEN_TIMER
FL_HOLD_BROWSER
FL_HOLD_TEXTBOX
FL_HORBAR_CHART
FL_HOR_BROWSER_SLIDER
FL_HOR_BROWSER_SLIDER2
FL_HOR_FILL_SLIDER
FL_HOR_NICE_SLIDER
FL_HOR_SLIDER
FL_HUGE_FONT
FL_HUGE_SIZE
FL_IGNORE
FL_IMAGECANVAS
FL_IMPULSE_XYPLOT
FL_INACTIVE
FL_INACTIVE_COL
FL_INACTIVE_FREE
FL_INDIANRED
FL_INOUT_BUTTON
FL_INPUT
FL_INPUT_ALIGN
FL_INPUT_BOXTYPE
FL_INPUT_CCOL
FL_INPUT_COL1
FL_INPUT_COL2
FL_INPUT_DDMM
FL_INPUT_FREE
FL_INPUT_LCOL
FL_INPUT_MMDD
FL_INPUT_TCOL
FL_INT
FL_INT_INPUT
FL_INVALID
FL_INVALID_CLASS
FL_INVALID_STYLE
FL_INVISIBLE_CURSOR
FL_ITALIC_STYLE
FL_KEYBOARD
FL_KEY_ALL
FL_KEY_NORMAL
FL_KEY_SPECIAL
FL_KEY_TAB
FL_LABELFRAME
FL_LARGE_FONT
FL_LARGE_SIZE
FL_LCOL
FL_LEAVE
FL_LEFTMOUSE
FL_LEFT_BCOL
FL_LEFT_MOUSE
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
FL_LINE_CHART
FL_LINE_DIAL
FL_LOG
FL_LONG
FL_MAGENTA
FL_MAXFONTS
FL_MAXPUPI
FL_MAX_COLS
FL_MAX_FONTSIZES
FL_MAX_FSELECTOR
FL_MAX_XYPLOTOVERLAY
FL_MBUTTON1
FL_MBUTTON2
FL_MBUTTON3
FL_MBUTTON4
FL_MBUTTON5
FL_MCOL
FL_MEDIUM_FONT
FL_MEDIUM_SIZE
FL_MENU
FL_MENU_ALIGN
FL_MENU_BOXTYPE
FL_MENU_BUTTON
FL_MENU_COL1
FL_MENU_COL2
FL_MENU_LCOL
FL_MENU_MAXITEMS
FL_MENU_MAXSTR
FL_MIDDLEMOUSE
FL_MIDDLE_MOUSE
FL_MINDEPTH
FL_MODAL
FL_MOTION
FL_MOUSE
FL_MTIMESORT
FL_MULTILINE_INPUT
FL_MULTI_BROWSER
FL_MULTI_TEXTBOX
FL_NOBORDER
FL_NOEVENT
FL_NONE
FL_NORMAL_BITMAP
FL_NORMAL_BROWSER
FL_NORMAL_BUTTON
FL_NORMAL_CANVAS
FL_NORMAL_CHOICE
FL_NORMAL_CHOICE2
FL_NORMAL_COUNTER
FL_NORMAL_DIAL
FL_NORMAL_FONT
FL_NORMAL_FONT1
FL_NORMAL_FONT2
FL_NORMAL_FREE
FL_NORMAL_INPUT
FL_NORMAL_PIXMAP
FL_NORMAL_POSITIONER
FL_NORMAL_SIZE
FL_NORMAL_STYLE
FL_NORMAL_TEXT
FL_NORMAL_TEXTBOX
FL_NORMAL_TIMER
FL_NORMAL_XYPLOT
FL_NO_BOX
FL_NO_FRAME
FL_NoGravity
FL_North
FL_NorthEast
FL_NorthWest
FL_OFF
FL_OK
FL_ON
FL_ORCHID
FL_OSHADOW_BOX
FL_OTHER
FL_OVAL3D_DOWNBOX
FL_OVAL3D_UPBOX
FL_OVAL_BOX
FL_OVAL_FRAME
FL_OptionIsArg
FL_OptionNoArg
FL_OptionResArg
FL_OptionSepArg
FL_OptionSkipArg
FL_OptionSkipLine
FL_OptionSkipNArgs
FL_OptionStickyArg
FL_PALEGREEN
FL_PDBS
FL_PDBorderWidth
FL_PDBrowserFontSize
FL_PDButtonFontSize
FL_PDButtonLabel
FL_PDButtonLabelSize
FL_PDChoiceFontSize
FL_PDClass
FL_PDCoordUnit
FL_PDDebug
FL_PDDepth
FL_PDDouble
FL_PDInputFontSize
FL_PDInputLabelSize
FL_PDLabelFontSize
FL_PDLeftScrollBar
FL_PDMenuFontSize
FL_PDPrivateMap
FL_PDPupFontSize
FL_PDSafe
FL_PDSharedMap
FL_PDSliderFontSize
FL_PDSliderLabelSize
FL_PDStandardMap
FL_PDSync
FL_PDULPropWidth
FL_PDULThickness
FL_PDVisual
FL_PIE_CHART
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
FL_POINTS_XYPLOT
FL_POSITIONER
FL_POSITIONER_ALIGN
FL_POSITIONER_BOXTYPE
FL_POSITIONER_COL1
FL_POSITIONER_COL2
FL_POSITIONER_LCOL
FL_PREEMPT
FL_PS
FL_PULLDOWN_MENU
FL_PUP_BOX
FL_PUP_CHECK
FL_PUP_GRAY
FL_PUP_GREY
FL_PUP_INACTIVE
FL_PUP_NONE
FL_PUP_PADH
FL_PUP_RADIO
FL_PUP_TOGGLE
FL_PUSH
FL_PUSH_BUTTON
FL_PUSH_MENU
FL_PseudoColor
FL_RADIO_BUTTON
FL_RALPHASORT
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
FL_RIGHTMOUSE
FL_RIGHT_BCOL
FL_RIGHT_MOUSE
FL_RINGBELL
FL_RMTIMESORT
FL_ROUND3DBUTTON
FL_ROUND3DBUTTON_ALIGN
FL_ROUND3DBUTTON_BOXTYPE
FL_ROUND3DBUTTON_COL1
FL_ROUND3DBUTTON_COL2
FL_ROUND3DBUTTON_LCOL
FL_ROUND3DBUTTON_MCOL
FL_ROUND3DBUTTON_TOPCOL
FL_ROUNDBUTTON
FL_ROUNDBUTTON_ALIGN
FL_ROUNDBUTTON_BOXTYPE
FL_ROUNDBUTTON_COL1
FL_ROUNDBUTTON_COL2
FL_ROUNDBUTTON_LCOL
FL_ROUNDBUTTON_MCOL
FL_ROUNDBUTTON_TOPCOL
FL_ROUNDED3D_DOWNBOX
FL_ROUNDED3D_UPBOX
FL_ROUNDED_BOX
FL_ROUNDED_FRAME
FL_RSHADOW_BOX
FL_RSIZESORT
FL_SCROLLBAR_ALWAYS_ON
FL_SCROLLBAR_OFF
FL_SCROLLBAR_ON
FL_SCROLLED_CANVAS
FL_SECRET_INPUT
FL_SECRET_INPUT
FL_SELECT_BROWSER
FL_SELECT_TEXTBOX
FL_SHADOW_BOX
FL_SHADOW_FRAME
FL_SHADOW_STYLE
FL_SHADOW_STYLE
FL_SHIFT_MASK
FL_SHORT
FL_SHORTCUT
FL_SIMPLE_CHOICE
FL_SIMPLE_COUNTER
FL_SIZESORT
FL_SLATEBLUE
FL_SLEEPING_FREE
FL_SLIDER
FL_SLIDER_ALIGN
FL_SLIDER_ALL
FL_SLIDER_BOX
FL_SLIDER_BOXTYPE
FL_SLIDER_BW1
FL_SLIDER_BW2
FL_SLIDER_COL1
FL_SLIDER_COL2
FL_SLIDER_DOWN
FL_SLIDER_FINE
FL_SLIDER_LCOL
FL_SLIDER_NOB
FL_SLIDER_NONE
FL_SLIDER_UP
FL_SLIDER_WIDTH
FL_SMALL_FONT
FL_SMALL_SIZE
FL_SPECIALPIE_CHART
FL_SPIKE_CHART
FL_SPRINGGREEN
FL_SQUARE_XYPLOT
FL_STEP
FL_STRING
FL_South
FL_SouthEast
FL_SouthWest
FL_StaticColor
FL_StaticGray
FL_TEXT
FL_TEXTBOX_ALIGN
FL_TEXTBOX_BOXTYPE
FL_TEXTBOX_COL1
FL_TEXTBOX_COL2
FL_TEXTBOX_LCOL
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
FL_TOUCH_MENU
FL_TRANSIENT
FL_TRPLCLICK
FL_TrueColor
FL_UNFOCUS
FL_UP_BOX
FL_UP_FRAME
FL_VALID
FL_VALSLIDER
FL_VALUE_TIMER
FL_VERT_BROWSER_SLIDER
FL_VERT_BROWSER_SLIDER2
FL_VERT_FILL_SLIDER
FL_VERT_NICE_SLIDER
FL_VERT_SLIDER
FL_WHEAT
FL_WHEN_NEEDED
FL_WHITE
FL_WM_NORMAL
FL_WM_SHIFT
FL_WRITE
FL_West
FL_XYPLOT
FL_XYPLOT_ALIGN
FL_XYPLOT_BOXTYPE
FL_XYPLOT_COL1
FL_XYPLOT_LCOL
FL_YELLOW
FL_illegalVisual
);

sub AUTOLOAD {
    #
    # Xforms does not use autoloading. Die!!
    # 

    local($constname);
    ($constname = $AUTOLOAD) =~ s/.*:://;
    my($pack,$file,$line) = caller;
    my($ver_rev, $ver, $rev) = fl_library_version();
    die "\"$file\", line $line: \"$constname\" not implemented in Xforms $ver.$rev\n";
}

bootstrap Xforms;

# Preloaded methods go here.

# Autoload methods go after __END__, and are processed by the autosplit program.

*FL_ALIGN_CENTER = *FL_ANALOG_CLOCK = *FL_BAR_CHART = *FL_BITMAPBUTTON_LCOL =
   *FL_BITMAP_BOXTYPE = *FL_BITMAP_LCOL = *FL_BLACK = *FL_BROWSER_LCOL =
   *FL_BUTTON_ALIGN = *FL_BUTTON_LCOL = *FL_CANCEL = *FL_CANVAS_BOXTYPE =
   *FL_CHART_LCOL = *FL_CHECKBUTTON_ALIGN = *FL_CHECKBUTTON_BOXTYPE =
   *FL_CHECKBUTTON_LCOL = *FL_CHOICE_COL2 = *FL_CHOICE_LCOL = *FL_CLOCK_LCOL =
   *FL_COORD_PIXEL = *FL_COUNTER_LCOL = *FL_DIAL_LCOL = *FL_ForgetGravity =
   *FL_GRID_NONE = *FL_INPUT_LCOL = *FL_INPUT_TCOL = *FL_INVALID =
   *FL_INVALID_CLASS = *FL_LCOL = *FL_LEFTMOUSE = *FL_LEFT_MOUSE =
   *FL_LIGHTBUTTON_ALIGN = *FL_LIGHTBUTTON_LCOL = *FL_LINEAR = *FL_MENU_ALIGN =
   *FL_MENU_LCOL = *FL_NOEVENT = *FL_NONE = *FL_NORMAL_BITMAP =
   *FL_NORMAL_BROWSER = *FL_NORMAL_BUTTON = *FL_NORMAL_CANVAS =
   *FL_NORMAL_CHOICE = *FL_NORMAL_COUNTER = *FL_NORMAL_DIAL = *FL_NORMAL_FREE =
   *FL_NORMAL_INPUT = *FL_NORMAL_PIXMAP = *FL_NORMAL_POSITIONER =
   *FL_NORMAL_STYLE = *FL_NORMAL_TEXT = *FL_NORMAL_TEXTBOX = *FL_NORMAL_TIMER =
   *FL_NORMAL_XYPLOT = *FL_NO_BOX = *FL_NO_FRAME = *FL_NoGravity =
   *FL_OFF = *FL_OptionNoArg = *FL_PIXMAPBUTTON_LCOL = *FL_PLACE_FREE =
   *FL_POSITIONER_LCOL = *FL_PUP_NONE = *FL_RESIZE_NONE =
   *FL_RETURN_END_CHANGED = *FL_ROUNDBUTTON_ALIGN = *FL_ROUNDBUTTON_BOXTYPE =
   *FL_ROUNDBUTTON_LCOL = *FL_SCROLLBAR_OFF = *FL_SIMPLE_CHOICE =
   *FL_SLIDER_LCOL = *FL_StaticGray = *FL_TEXTBOX_LCOL = *FL_TEXT_LCOL =
   *FL_TIMER_ALIGN = *FL_TIMER_LCOL = *FL_TOUCH_MENU = *FL_VERT_SLIDER =
   *FL_XYPLOT_LCOL = *FT_FILE = \&FL_CON_0;
*FL_ALIGN_TOP = *FL_BITMAPBUTTON_BOXTYPE = *FL_BOLD_STYLE = *FL_BUTTON =
   *FL_BUTTON_BOXTYPE = *FL_CANVAS_ALIGN = *FL_CLOCK_BOXTYPE = *FL_COORD_MM =
   *FL_COUNTER_BOXTYPE = *FL_DIGITAL_CLOCK = *FL_DRAW = *FL_FLOAT_INPUT =
   *FL_FULLBORDER = *FL_GRID_MAJOR = *FL_GrayScale = *FL_HORBAR_CHART =
   *FL_HOR_SLIDER = *FL_INACTIVE_FREE = *FL_KEY_NORMAL =
   *FL_LIGHTBUTTON_BOXTYPE = *FL_LINE_DIAL = *FL_LOG = *FL_MIDDLEMOUSE =
   *FL_MIDDLE_MOUSE = *FL_MINDEPTH = *FL_NorthWest = *FL_OK = *FL_ON =
   *FL_OptionIsArg = *FL_PIXMAPBUTTON_BOXTYPE = *FL_PLACE_MOUSE =
   *FL_POSITIONER_COL2 = *FL_PREEMPT = *FL_PUP_GRAY = *FL_PUP_GREY =
   *FL_PUP_INACTIVE = *FL_PUSH_BUTTON = *FL_PUSH_MENU = *FL_READ =
   *FL_RED = *FL_RESIZE_X = *FL_RETURN_CHANGED = *FL_SCROLLBAR_ON =
   *FL_SCROLLED_CANVAS = *FL_SELECT_BROWSER = *FL_SELECT_TEXTBOX =
   *FL_SIMPLE_COUNTER = *FL_SLEEPING_FREE = *FL_SQUARE_XYPLOT = *FL_TIMER_COL2 =
   *FL_UP_BOX = *FL_UP_FRAME = *FL_VALID = *FL_VALUE_TIMER = *FL_WM_SHIFT =
   *FT_FIFO = \&FL_CON_1;
*FL_ALIGN_BOTTOM_RIGHT = *FL_ALIGN_RIGHT_BOTTOM = *FL_BROWSER_FONTSIZE =
   *FL_DEFAULT_FONT = *FL_DEFAULT_SIZE = *FL_DefaultVisual = *FL_MAX_FONTSIZES =
   *FL_MOTION = *FL_NORMAL_FONT1 = *FL_RSHADOW_BOX = *FL_SHORT =
   *FL_SLATEBLUE = *FL_SMALL_FONT = *FL_SMALL_SIZE = *FL_TIMESITALIC_STYLE = 
   \&FL_CON_10;
*FL_BROWSER_LINELENGTH = *FL_MAX_COLS = *FL_PDSliderFontSize =
   *FL_PDSliderLabelSize = \&FL_CON_1024;
*FL_BITMAPBUTTON_COL1 = *FL_BITMAP_COL1 = *FL_BITMAP_COL2 = *FL_BOOL =
   *FL_BROWSER_COL1 = *FL_BROWSER_SLCOL = *FL_BUTTON_COL1 = *FL_BUTTON_COL2 =
   *FL_CHART_COL1 = *FL_CHECKBUTTON_COL1 = *FL_CHECKBUTTON_TOPCOL =
   *FL_CHOICE_COL1 = *FL_CLOCK_TOPCOL = *FL_COL1 = *FL_COUNTER_COL1 =
   *FL_DIAL_COL1 = *FL_DIAL_TOPCOL = *FL_GRAY63 = *FL_INPUT_COL1 =
   *FL_LIGHTBUTTON_COL1 = *FL_LIGHTBUTTON_TOPCOL = *FL_MENU_COL1 =
   *FL_OVAL_BOX = *FL_PIXMAPBUTTON_COL1 = *FL_POSITIONER_COL1 =
   *FL_ROUNDBUTTON_TOPCOL = *FL_SLIDER_COL1 = *FL_SLIDER_COL2 = *FL_STEP =
   *FL_TEXTBOX_COL1 = *FL_TEXT_COL1 = *FL_TIMER_COL1 =
   *FL_TIMESBOLDITALIC_STYLE = *FL_XYPLOT_COL1 = \&FL_CON_11;
*FL_DIAL_COL2 = *FL_GRAY16 = *FL_INT = *FL_LIGHTBUTTON_MINSIZE =
   *FL_NORMAL_FONT = *FL_NORMAL_FONT2 = *FL_NORMAL_SIZE = *FL_RIGHT_BCOL =
   *FL_SHORTCUT = \&FL_CON_12;
*FL_MENU_MAXITEMS = *FL_PDPupFontSize = *FL_PLACE_HOTSPOT = \&FL_CON_128;
*FL_BOTTOM_BCOL = *FL_CLOCK_COL2 = *FL_FREEMEM = *FL_GRAY35 = *FL_LONG = 
   \&FL_CON_13;
*FL_PDSharedMap = \&FL_CON_131072;
*FL_FLOAT = *FL_GRAY80 = *FL_MEDIUM_FONT = *FL_MEDIUM_SIZE = *FL_OTHER =
   *FL_TOP_BCOL = \&FL_CON_14;
*FL_DRAWLABEL = *FL_GRAY90 = *FL_LEFT_BCOL = *FL_STRING = \&FL_CON_15;
*FL_BUTTON_MCOL1 = *FL_BUTTON_MCOL2 = *FL_CHECKBUTTON_MCOL = *FL_CHOICE_MCOL =
   *FL_DBLCLICK = *FL_GRAY75 = *FL_INPUT_COL2 = *FL_LIGHTBUTTON_MCOL =
   *FL_MCOL = *FL_MENU_COL2 = *FL_PDSync = *FL_PLACE_GEOMETRY =
   *FL_RINGBELL = *FL_ROUNDBUTTON_COL1 = *FL_ROUNDBUTTON_MCOL = *FL_TEXT_COL2 =
   \&FL_CON_16;
*FL_ALIGN_VERT = *FL_FREE_SIZE = *FL_PDBS = \&FL_CON_16384;
*FL_PLACE_CENTERFREE = *FL_PLACE_FREE_CENTER = \&FL_CON_16386;
*FL_CLOCK_COL1 = *FL_INACTIVE = *FL_INACTIVE_COL = *FL_TRPLCLICK = \&FL_CON_17;
*FL_LARGE_FONT = *FL_LARGE_SIZE = *FL_PALEGREEN = \&FL_CON_18;
*FL_DARKGOLD = \&FL_CON_19;
*FL_ALIGN_BOTTOM = *FL_AUTO = *FL_BITMAPBUTTON_ALIGN = *FL_BITMAP_ALIGN =
   *FL_BROWSER_ALIGN = *FL_BROWSER_BOXTYPE = *FL_CHART_ALIGN =
   *FL_CIRCLE_XYPLOT = *FL_CLOCK_ALIGN = *FL_COORD_POINT = *FL_COUNTER_ALIGN =
   *FL_COUNTER_BW = *FL_DIAL_ALIGN = *FL_DOWN_BOX = *FL_DOWN_FRAME =
   *FL_GREEN = *FL_GRID_MINOR = *FL_HIDDEN_TIMER = *FL_HOLD_BROWSER =
   *FL_HOLD_TEXTBOX = *FL_INPUT_BOXTYPE = *FL_INPUT_FREE = *FL_INT_INPUT =
   *FL_ITALIC_STYLE = *FL_KEY_TAB = *FL_LIGHTBUTTON = *FL_LINE_CHART =
   *FL_North = *FL_OptionStickyArg = *FL_PDDepth = *FL_PIXMAPBUTTON_ALIGN =
   *FL_PLACE_CENTER = *FL_POSITIONER_ALIGN = *FL_POSITIONER_BOXTYPE =
   *FL_PULLDOWN_MENU = *FL_PUP_BOX = *FL_PUP_TOGGLE = *FL_PUSH =
   *FL_RADIO_BUTTON = *FL_RESIZE_Y = *FL_RETURN_END = *FL_RIGHTMOUSE =
   *FL_RIGHT_MOUSE = *FL_SCROLLBAR_ALWAYS_ON = *FL_SLIDER_ALIGN =
   *FL_SLIDER_BOXTYPE = *FL_SLIDER_BW2 = *FL_StaticColor = *FL_TEXTBOX_ALIGN =
   *FL_TEXTBOX_BOXTYPE = *FL_TIMER_BOXTYPE = *FL_VERT_FILL_SLIDER =
   *FL_WHEN_NEEDED = *FL_WM_NORMAL = *FL_WRITE = *FL_XYPLOT_ALIGN = \&FL_CON_2;
*FL_ORCHID = \&FL_CON_20;
*FL_PDVisual = \&FL_CON_2048;
*FL_DARKCYAN = \&FL_CON_21;
*FL_DARKTOMATO = \&FL_CON_22;
*FL_WHEAT = \&FL_CON_23;
*FL_DARKORANGE = *FL_HUGE_FONT = *FL_HUGE_SIZE = \&FL_CON_24;
*FL_DEEPPINK = \&FL_CON_25;
*FL_FREE_COL1 = *FL_PDButtonFontSize = *FL_PDButtonLabel =
   *FL_PDButtonLabelSize = *FL_PLACE_ICONIC = \&FL_CON_256;
*FL_CHARTREUSE = \&FL_CON_26;
*FL_PDStandardMap = \&FL_CON_262144;
*FL_DARKVIOLET = \&FL_CON_27;
*FL_SPRINGGREEN = \&FL_CON_28;
*FL_BOLDITALIC_STYLE = *FL_BORDER_BOX = *FL_BORDER_FRAME = *FL_BOUND_WIDTH =
   *FL_BROWSER_COL2 = *FL_BUTTON_BW = *FL_CHART_BOXTYPE = *FL_CHECKBUTTON_COL2 =
   *FL_CONTINUOUS_FREE = *FL_COORD_centiMM = *FL_FILLED_CHART = *FL_FILL_CHART =
   *FL_FILL_XYPLOT = *FL_HIDDEN_BUTTON = *FL_HOR_FILL_SLIDER =
   *FL_LIGHTBUTTON_COL2 = *FL_MENU_BOXTYPE = *FL_MULTI_BROWSER =
   *FL_MULTI_TEXTBOX = *FL_NorthEast = *FL_OptionSepArg =
   *FL_PIXMAPBUTTON_COL2 = *FL_PseudoColor = *FL_RELEASE = *FL_RESIZE_ALL =
   *FL_RETURN_ALWAYS = *FL_ROUNDBUTTON = *FL_ROUNDBUTTON_COL2 = *FL_SLIDER_BW1 =
   *FL_TEXTBOX_COL2 = *FL_YELLOW = \&FL_CON_3;
*FL_MAX_XYPLOTOVERLAY = *FL_PDPrivateMap = *FL_PLACE_ASPECT = \&FL_CON_32;
*FL_FIX_SIZE = *FL_PDCoordUnit = \&FL_CON_32768;
*FL_ALIGN_LEFT = *FL_ALL_FREE = *FL_BITMAPBUTTON_COL2 = *FL_BLUE =
   *FL_CHOICE_ALIGN = *FL_COORD_centiPOINT = *FL_COUNTER_COL2 = *FL_ENTER =
   *FL_EXCEPT = *FL_FIXED_STYLE = *FL_INPUT_ALIGN = *FL_INPUT_CCOL =
   *FL_KEY_SPECIAL = *FL_MULTILINE_INPUT = *FL_OptionResArg = *FL_PDClass =
   *FL_PLACE_POSITION = *FL_POINTS_XYPLOT = *FL_PUP_CHECK = *FL_PUP_PADH =
   *FL_RETURN_DBLCLICK = *FL_SHADOW_BOX = *FL_SHADOW_FRAME = *FL_SPIKE_CHART =
   *FL_TEXT_ALIGN = *FL_TOUCH_BUTTON = *FL_TrueColor = *FL_VERT_NICE_SLIDER =
   *FL_West = \&FL_CON_4;
*FL_PDULThickness = \&FL_CON_4096;
*FL_ALIGN_LEFT_TOP = *FL_ALIGN_TOP_LEFT = *FL_DASHED_XYPLOT =
   *FL_ENGRAVED_FRAME = *FL_FIXEDBOLD_STYLE = *FL_FRAME_BOX =
   *FL_HOR_NICE_SLIDER = *FL_INOUT_BUTTON = *FL_LEAVE = *FL_MAGENTA =
   *FL_OptionSkipArg = *FL_PIE_CHART = \&FL_CON_5;
*FL_PDInputFontSize = *FL_PDInputLabelSize = \&FL_CON_512;
*FL_PDBorderWidth = \&FL_CON_524288;
   *FL_ALIGN_BOTTOM_LEFT = *FL_ALIGN_LEFT_BOTTOM = *FL_CHOICE_BOXTYPE =
   *FL_CYAN = *FL_East = *FL_FIXEDITALIC_STYLE = *FL_IMPULSE_XYPLOT =
   *FL_MAX_FSELECTOR = *FL_MOUSE = *FL_OptionSkipLine = *FL_RETURN_BUTTON =
   *FL_ROUNDED_BOX = *FL_ROUNDED_FRAME = *FL_SPECIALPIE_CHART = \&FL_CON_6;
*FL_MAXPUPI = *FL_MENU_MAXSTR = *FL_PDLeftScrollBar = *FL_PLACE_FULLSCREEN = 
   \&FL_CON_64;
*FL_PDDebug = \&FL_CON_65536;
*FL_ACTIVE_XYPLOT = *FL_EMBOSSED_BOX = *FL_EMBOSSED_FRAME =
   *FL_FIXEDBOLDITALIC_STYLE = *FL_FOCUS = *FL_HIDDEN_RET_BUTTON = *FL_KEY_ALL =
   *FL_OptionSkipNArgs = *FL_SouthWest = *FL_WHITE = \&FL_CON_7;
*FL_ALIGN_RIGHT = *FL_DIAL_BOXTYPE = *FL_EMPTY_XYPLOT = *FL_FLAT_BOX =
   *FL_MENU_BUTTON = *FL_OVAL_FRAME = *FL_PDDouble = *FL_PLACE_SIZE =
   *FL_PUP_RADIO = *FL_South = *FL_TEXT_BOXTYPE = *FL_TIMES_STYLE =
   *FL_TINY_FONT = *FL_TINY_SIZE = *FL_TOMATO = *FL_UNFOCUS =
   *FL_XYPLOT_BOXTYPE = \&FL_CON_8;
*FL_ALIGN_INSIDE = *FL_PDULPropWidth = \&FL_CON_8192;
*FL_ALIGN_RIGHT_TOP = *FL_ALIGN_TOP_RIGHT = *FL_INDIANRED = *FL_KEYBOARD =
   *FL_RFLAT_BOX = *FL_SouthEast = *FL_TIMESBOLD_STYLE = \&FL_CON_9;
*FL_DEFAULT_CURSOR = *FL_IGNORE = *FL_INVALID_STYLE = *FL_illegalVisual = 
   \&FL_CON__1;

my($ver_rev, $ver, $rev) = fl_library_version();

if ($ver_rev >= 84) {
	if ($ver_rev >= 86) {
		*FL_MAXFONTS = \&FL_CON_48;
	} else {
		*FL_MAXFONTS = \&FL_CON_32;
	}
	if ($ver_rev >= 85) {
		*FL_SLIDER_NONE = \&FL_CON_0;
		*FL_SLIDER_BOX = \&FL_CON_1;
		*FL_SLIDER_NOB = \&FL_CON_2;
		*FL_SLIDER_UP = \&FL_CON_4;
		*FL_SLIDER_DOWN = \&FL_CON_8;
		*FL_SLIDER_ALL = \&FL_CON_15;
		*FL_CLOSE = \&FL_CON__2;
		*FL_ALT_MASK = \&FL_CON_2P25;
		*FL_CONTROL_MASK = \&FL_CON_2P26;
		*FL_SHIFT_MASK = \&FL_CON_2P27;
		*FL_ALPHASORT = \&FL_CON_1;
		*FL_RALPHASORT = \&FL_CON_2;
		*FL_MTIMESORT = \&FL_CON_3;
		*FL_RMTIMESORT = \&FL_CON_4;
		*FL_SIZESORT = \&FL_CON_5;
		*FL_RSIZESORT = \&FL_CON_6;
		*FL_FRAME_COL1 = \&FL_BLACK;
		*FL_FRAME_COL2 = \&FL_COL_1;
		*FL_FRAME_LCOL = \&FL_BLACK;
		*FL_CLASS_START = \&FL_CON_1001;
		*FL_CLASS_END = \&FL_CON_9999;
		*FL_LABELFRAME = \&FL_CON_28;
		*FL_ALT_VAL = \&FL_CON_2P25;
		*FL_MBUTTON1 = \&FL_CON_1;
		*FL_MBUTTON2 = \&FL_CON_2;
		*FL_MBUTTON3 = \&FL_CON_3;
		*FL_MBUTTON4 = \&FL_CON_4;
		*FL_MBUTTON5 = \&FL_CON_5;
		*FL_CANVAS = \&FL_CON_28;
		*FL_GLCANVAS = \&FL_CON_29;
		*FL_IMAGECANVAS = \&FL_CON_30;
		*FL_FOLDER = \&FL_CON_31;
	} else {
		*FL_ALT_VAL = \&FL_CON_131072;
		*FL_MBUTTON1 = \&FL_CON_0;
		*FL_MBUTTON2 = \&FL_CON_1;
		*FL_MBUTTON3 = \&FL_CON_2;
		*FL_MBUTTON4 = \&FL_CON_3;
		*FL_MBUTTON5 = \&FL_CON_4;
		*FL_CANVAS = \&FL_CON_27;
		*FL_GLCANVAS = \&FL_CON_28;
		*FL_IMAGECANVAS = \&FL_CON_29;
		*FL_FOLDER = \&FL_CON_30;
	}
	*FL_ATTRIB = \&FL_CON_18;
	*FL_BITMAP = \&FL_CON_8; 
	*FL_BITMAPBUTTON = \&FL_CON_6; 
	*FL_BOX = \&FL_CON_10; 
	*FL_BROWSER = \&FL_CON_19;
	*FL_CHART = \&FL_CON_13; 
	*FL_CHART_MAX = \&FL_CON_512;
	*FL_CHECKBUTTON = \&FL_CON_5;
	*FL_CHOICE = \&FL_CON_14;
	*FL_CLOCK = \&FL_CON_22;
	*FL_COUNTER = \&FL_CON_15; 
	*FL_DATE_INPUT = \&FL_CON_3;
	*FL_DIAL = \&FL_CON_20;
	*FL_DIAL_CCW = \&FL_CON_1;
	*FL_DIAL_CW = \&FL_CON_0;
	*FL_DROPLIST_CHOICE = \&FL_CON_2;
	*FL_EMBOSSED_STYLE = \&FL_CON_2048;
	*FL_ENGRAVED_STYLE = \&FL_CON_1024;
	*FL_FILL_DIAL = \&FL_CON_2;
	*FL_FRAME = \&FL_CON_26;
	*FL_FREE = \&FL_CON_24;
	*FL_HIDDEN_INPUT = \&FL_CON_5;
	*FL_HOR_BROWSER_SLIDER = \&FL_CON_6;
	*FL_HOR_BROWSER_SLIDER2 = \&FL_CON_8;
	*FL_INPUT = \&FL_CON_18;
	*FL_INPUT_DDMM = \&FL_CON_1;
	*FL_INPUT_MMDD = \&FL_CON_0;
	*FL_MENU = \&FL_CON_12; 
	*FL_MODAL = \&FL_CON_256;
	*FL_NOBORDER = \&FL_CON_3;
	*FL_NORMAL_CHOICE2 = \&FL_CON_1;
	*FL_OSHADOW_BOX = \&FL_CON_16;
	*FL_OVAL3D_DOWNBOX = \&FL_CON_15;
	*FL_OVAL3D_UPBOX = \&FL_CON_14;
	*FL_PIXMAP = \&FL_CON_9;
	*FL_PIXMAPBUTTON = \&FL_CON_7;
	*FL_POSITIONER = \&FL_CON_23;
	*FL_PS = \&FL_CON_19;
	*FL_ROUND3DBUTTON = \&FL_CON_4;
	*FL_ROUND3DBUTTON_ALIGN = \&FL_ALIGN_CENTER;
	*FL_ROUND3DBUTTON_BOXTYPE = \&FL_NO_BOX;
	*FL_ROUND3DBUTTON_COL1 = \&FL_COL1;
	*FL_ROUND3DBUTTON_COL2 = \&FL_BLACK;
	*FL_ROUND3DBUTTON_LCOL = \&FL_LCOL;
	*FL_ROUND3DBUTTON_MCOL = \&FL_MCOL;
	*FL_ROUND3DBUTTON_TOPCOL = \&FL_COL1;
	*FL_ROUNDED3D_DOWNBOX = \&FL_CON_13;
	*FL_ROUNDED3D_UPBOX = \&FL_CON_12;
	*FL_SECRET_INPUT = \&FL_CON_6;
	*FL_SHADOW_STYLE = \&FL_CON_512;
	*FL_SLIDER = \&FL_CON_16; 
	*FL_TEXT = \&FL_CON_11;
	*FL_TIMER = \&FL_CON_21;
	*FL_TRANSIENT = \&FL_CON_2;
	*FL_VALSLIDER = \&FL_CON_17; 
	*FL_VERT_BROWSER_SLIDER = \&FL_CON_7;
	*FL_VERT_BROWSER_SLIDER2 = \&FL_CON_9;
	*FL_XYPLOT = \&FL_CON_25;
} else {
	*FL_MAXFONTS = \&FL_CON_32;
	*FL_ALT_VAL = \&FL_CON_131072;
	*FL_ALWAYS_ON = \&FL_CON_2;
	*FL_BITMAP = \&FL_CON_7; 
	*FL_BITMAPBUTTON = \&FL_CON_5; 
	*FL_BITMAP_MAXSIZE = \&FL_CON_16384;
	*FL_BOX = \&FL_CON_9; 
	*FL_BROWSER = \&FL_CON_18;
	*FL_BROWSER_SLIDER = \&FL_CON_6;
	*FL_BROWSER_SLIDER2 = \&FL_CON_7;
	*FL_CANVAS = \&FL_CON_26;
	*FL_CHART = \&FL_CON_12; 
	*FL_CHART_MAX = \&FL_CON_256;
	*FL_CHECKBUTTON = \&FL_CON_4;
	*FL_CHOICE = \&FL_CON_13;
	*FL_CLOCK = \&FL_CON_21;
	*FL_COUNTER = \&FL_CON_14; 
	*FL_DIAL = \&FL_CON_19;
	*FL_DROPLIST_CHOICE = \&FL_CON_1;
	*FL_EMBOSSED_STYLE = \&FL_CON_524288;
	*FL_ENGRAVED_STYLE = \&FL_CON_262144;
	*FL_FOLDERTAB = \&FL_CON_25;
	*FL_FRAME = \&FL_CON_27;
	*FL_FREE = \&FL_CON_23;
	*FL_GLCANVAS = \&FL_CON_28;
	*FL_HIDDEN_INPUT = \&FL_CON_3;
	*FL_INPUT = \&FL_CON_17;
	*FL_MENU = \&FL_CON_11; 
	*FL_NOBORDER = \&FL_CON_0;
	*FL_OSHADOW_BOX = \&FL_CON_12;
	*FL_PIXMAP = \&FL_CON_8;
	*FL_PIXMAPBUTTON = \&FL_CON_6;
	*FL_POSITIONER = \&FL_CON_22;
	*FL_PS = \&FL_CON_18;
	*FL_SECRET_INPUT = \&FL_CON_5;
	*FL_SHADOW_STYLE = \&FL_CON_131072;
	*FL_SLIDER = \&FL_CON_15; 
	*FL_TEXT = \&FL_CON_10;
	*FL_TIMER = \&FL_CON_20;
	*FL_TRANSIENT = \&FL_CON__1;
	*FL_VALSLIDER = \&FL_CON_16; 
	*FL_XYPLOT = \&FL_CON_24;
}

sub FL_BEGIN_GROUP { 10000; }
sub FL_BUILT_IN_COLS { 30; }
sub FL_CHOICE_MAXITEMS {63;}
sub FL_CLICK_TIMEOUT { 400; }
sub FL_CON__1 { -1; }
sub FL_CON__2 { -2; }
sub FL_DODGERBLUE { 29; }
sub FL_DOGERBLUE { 29; }
sub FL_END_GROUP { 20000; }
sub FL_FREE_COL10 { 265; }
sub FL_FREE_COL11 { 266; }
sub FL_FREE_COL12 { 267; }
sub FL_FREE_COL13 { 268; }
sub FL_FREE_COL14 { 269; }
sub FL_FREE_COL15 { 270; }
sub FL_FREE_COL16 { 271; }
sub FL_FREE_COL2 { 257; }
sub FL_FREE_COL3 { 258; }
sub FL_FREE_COL4 { 259; }
sub FL_FREE_COL5 { 260; }
sub FL_FREE_COL6 { 261; }
sub FL_FREE_COL7 { 262; }
sub FL_FREE_COL8 { 263; }
sub FL_FREE_COL9 { 264; }
sub FL_INVISIBLE_CURSOR { -2; }
sub FL_PDBrowserFontSize {4194304;}
sub FL_PDChoiceFontSize {8388608;}
sub FL_PDLabelFontSize {16777216;}
sub FL_PDMenuFontSize {2097152;}
sub FL_PDSafe {1048576;}
sub FL_SLIDER_FINE {.05;}
sub FL_SLIDER_WIDTH {.10;}
sub FL_TIMER_BLINKRATE { .2; }
sub FL_TIMER_EVENT { 1073741824; }
sub FL_CON_2P25 { 33554432; }
sub FL_CON_2P26 { 67108864; }
sub FL_CON_2P27 { 134217728; }
sub FL_CON_1001 { 1001; }
sub FL_CON_9999 { 9999; }

sub fl_arc {fl_pieslice(0, $_[0]-$_[2], $_[1]-$_[2], 2*$_[2], 2*$_[2], $_[3], $_[4], $_[5]);}
sub fl_arcf {fl_pieslice(1, $_[0]-$_[2], $_[1]-$_[2], 2*$_[2], 2*$_[2], $_[3], $_[4], $_[5]);}
sub fl_circ {fl_oval(   0, $_[0]-$_[2], $_[1]-$_[2], 2*$_[2], 2*$_[2], $_[3]);}
sub fl_circf {fl_oval(  1, $_[0]-$_[2], $_[1]-$_[2], 2*$_[2], 2*$_[2], $_[3]);}
sub fl_diagline {fl_line($_[0],$_[1],$_[0]+$_[2]-1,$_[1]+$_[3]-1,$_[4]);}
sub fl_ovalf {fl_oval(1,@_);}
sub fl_ovall {fl_oval(0,@_);}
sub fl_rect {fl_rectangle(0,@_);}
sub fl_rectf {fl_rectangle(1,@_);}
sub fl_reset_cursor {fl_set_cursor(@_,0);}
sub fl_roundrect {fl_roundrectangle(0,@_);}
sub fl_roundrectf {fl_roundrectangle(1,@_);}
sub fl_set_fselector_title {fl_set_form_title(fl_get_fselector_form(),@_);}
sub fl_set_fselector_transient {fl_set_fselector_border($_[0] ? FL_TRANSIENT() : FL_FULLBORDER());}
sub fl_set_object_dblclick {my($ob, $t) = @_; $ob->click_timeout($t);}

1;
__END__
