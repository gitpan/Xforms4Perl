#!/usr/bin/perl
#
# Switching cursors demo
#

use Xforms;

fl_initialize("FormDemo");
$cursor = undef;

#
# The bitstring deatils were derived from bm1.xbm and bm2.xbm in the 
# DEMOS directory
#
$bm1_width = 16;
$bm1_height = 16;
$bm1_bits = "\x00\x00\x00\x57\x7c\x72\xc4\x52\xc4\x00\x44\x01\x44\x1f\xfc\x22\x40\x42\x40\x44\x40\x43\xc0\x40\x70\x40\x8c\x20\x00\x1f\x00\x00";
$bm2_bits = "\x00\x00\x00\x57\x7c\x72\xfc\x52\xfc\x00\x7c\x01\x7c\x1f\xfc\x22\x40\x42\x40\x44\x40\x43\xc0\x40\x70\x40\x8c\x20\x00\x1f\x00\x00";
$l = length($bm1_bits);
print "Here $l\n";
$bitmapcur = fl_create_bitmap_cursor($bm1_bits, $bm2_bits, 
                    $bm1_width, $bm1_height,
                    $bm1_width/2, $bm1_height/2);

   fl_set_border_width(-2);
   create_form_cursor();

# fill-in form initialization code */

   fl_show_form($cursor,FL_PLACE_CENTER,FL_FULLBORDER,"cursor");
   fl_do_forms();


# callbacks for form cursor */
sub setcursor_cb
{
   my($ob, $data) = @_;
   fl_set_cursor($ob->window, $data);
}

sub setbitmapcursor_cb
{

  my($ob, $data) = @_;
  fl_set_cursor($ob->window, $bitmapcur);

}

sub done_cb
{
    exit(0);
}



sub create_form_cursor
{

  $cursor = fl_bgn_form(FL_NO_BOX, 325, 175);
  $obj = fl_add_box(FL_UP_BOX,0,0,325,175,"");
  $obj = fl_add_frame(FL_EMBOSSED_FRAME,10,10,305,120,"");
  $obj = fl_add_button(FL_NORMAL_BUTTON,20,20,65,30,"Hand");
    fl_set_object_callback($obj,"setcursor_cb",60);
  $obj = fl_add_button(FL_NORMAL_BUTTON,250,140,60,25,"Done");
    fl_set_object_callback($obj,"done_cb",0);
  $obj = fl_add_button(FL_NORMAL_BUTTON,95,20,65,30,"Watch");
    fl_set_object_callback($obj,"setcursor_cb",150);
  $obj = fl_add_button(FL_NORMAL_BUTTON,170,20,65,30,"Invisible");
    fl_set_object_callback($obj,"setcursor_cb",FL_INVISIBLE_CURSOR);
  $obj = fl_add_button(FL_NORMAL_BUTTON,90,70,140,50,"DefaultCursor");
    fl_set_button_shortcut($obj,"Dd#d",1);
    fl_set_object_callback($obj,"setcursor_cb",FL_DEFAULT_CURSOR);
  $obj = fl_add_button(FL_NORMAL_BUTTON,245,20,65,30,"BitmapCur");
    fl_set_object_callback($obj,"setbitmapcursor_cb",0);
  fl_end_form();

}

