#!/usr/bin/perl
#
# Battery level from /proc/apm. Use with laptops and linux.
#

$XFbat = undef;
$pos = undef;
$batlevel = undef;
$batring = 0;
use Xforms;

   fl_initialize("XFbat");
   fl_set_defaults(FL_PDBorderWidth, -2);

   create_form_XFbat();

   fl_set_form_position($XFbat,0,0);
   fl_show_form($XFbat,FL_PLACE_POSITION,FL_NOBORDER,"XFbat");
   set_positioner();
   fl_do_forms();
   exit 0;

sub set_positioner
{
	open(APM, "/proc/apm");
	$apm = <APM>;
	close APM;

	$apm =~ /([x\d\.]*\s){6}(\d\d*)%/;
	$batlevel = int($2);

	if ($batlevel > 75) {
		$col2 = FL_PALEGREEN;
		$col1 = FL_SLIDER_COL1;
	} elsif ($batlevel > 50) {
		if ($batring < 1) {
			fl_ringbell(100);
			$batring = 1;
		}
		$col2 = FL_SLATEBLUE;
		$col1 = FL_SLIDER_COL1;
	} elsif ($batlevel > 25) {
		if ($batring < 2) {
			fl_ringbell(100);
			fl_ringbell(100);
			$batring = 2;
		}
		$col2 = FL_DARKORANGE;
		$col1 = FL_SLIDER_COL1;
	} else {
		fl_ringbell(100);
		$col2 = FL_RED;
		$col1 = FL_RED;
	}
	fl_set_slider_value($pos, $batlevel);	
	fl_set_object_color($pos, $col1, $col2);
	fl_add_timeout(10000, "set_positioner", 0);
	return;
}
  
sub slider_filter {

	my($obj, $value, $int) = @_;
	$str = "$batlevel";
	return $str;
}

sub create_form_XFbat
{
  $XFbat = fl_bgn_form(FL_UP_BOX, 125, 36);
  $obj = fl_add_box(FL_UP_BOX,0,0,125,36,"");
  $obj = fl_add_text(FL_NORMAL_TEXT,2,2,108,16,"Battery Level");
    fl_set_object_lsize($obj,FL_NORMAL_SIZE);
    fl_set_object_lalign($obj,FL_ALIGN_CENTER);
    fl_set_object_lstyle($obj,FL_TIMESBOLD_STYLE);
  $pos = $obj = fl_add_valslider(FL_HOR_FILL_SLIDER,2,18,108,16,"");
    fl_set_object_lsize($obj,FL_SMALL_SIZE);
    fl_set_object_lstyle($obj,FL_NORMAL_STYLE);
    fl_set_slider_bounds($obj, 0, 100);
    fl_set_slider_filter($obj, "slider_filter");
    fl_set_slider_step($obj, 1);
    fl_deactivate_object($obj);
  $obj = fl_add_button(FL_NORMAL_BUTTON,111,2,11,32,"X");
  fl_end_form();

  return;
}

