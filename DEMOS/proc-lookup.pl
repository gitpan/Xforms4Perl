#!/usr/bin/perl
$|=1;
use X11::Xforms;   
$browser = $picture = undef;
$quit=0;
@matrix=("null","//proc//cpuinfo","//proc//interrupts","//proc//ioports","//proc//pci","//proc//dma");
fl_initialize('Monitor');
create_form_main();
fl_set_bitmap_file($picture,"srs.xbm");
fl_set_browser_fontstyle($browser,FL_FIXED_STYLE);
fl_show_form($mainform,FL_PLACE_CENTER,FL_FULLBORDER,"System Monitor");
while ($quit==0) {
	fl_do_forms();
}

sub button1 {
	fl_set_button($cpu,1);
	fl_set_button($int,0);
	fl_set_button($io,0);
	fl_set_button($pci,0);
	fl_set_button($dma,0);
	fl_clear_browser($browser);
	local $ignore=fl_load_browser($browser,$matrix[1]);
}
sub button2 {	
	fl_set_button($cpu,0);
	fl_set_button($int,1);
	fl_set_button($io,0);
	fl_set_button($pci,0);
	fl_set_button($dma,0);

	fl_clear_browser($browser);
	local $ignore=fl_load_browser($browser,$matrix[2]);
}
sub button3 {	
	fl_set_button($cpu,0);
	fl_set_button($int,0);
	fl_set_button($io,1);
	fl_set_button($pci,0);
	fl_set_button($dma,0);

	fl_clear_browser($browser);
	local $ignore=fl_load_browser($browser,$matrix[3]);
}
sub button4 {
	fl_set_button($cpu,0);
	fl_set_button($int,0);
	fl_set_button($io,0);
	fl_set_button($pci,1);
	fl_set_button($dma,0);

	fl_clear_browser($browser);
	local $ignore=fl_load_browser($browser,$matrix[4]);
}
sub button5 {
	fl_set_button($cpu,0);
	fl_set_button($int,0);
	fl_set_button($io,0);
	fl_set_button($pci,0);
	fl_set_button($dma,1);

	fl_clear_browser($browser);
	local $ignore=fl_load_browser($browser,$matrix[5]);
}			

sub quit_cb {
	exit(0);
}	
sub create_form_main {
#	FL_OBJECT *obj;
#  FD_main *fdui = (FD_main *) fl_calloc(1, sizeof(FD_main));

  $mainform = fl_bgn_form(FL_NO_BOX, 480, 280);
  $obj = fl_add_box(FL_UP_BOX,0,0,480,280,"");
  $obj = fl_add_clock(FL_DIGITAL_CLOCK,120,110,70,20,"");
    fl_set_object_color($obj,FL_COL1,FL_BLUE);
  $obj = fl_add_text(FL_NORMAL_TEXT,10,240,220,30,"System Status");
    fl_set_object_lcol($obj,FL_MCOL);
    fl_set_object_lsize($obj,FL_HUGE_SIZE);
    fl_set_object_lstyle($obj,FL_BOLD_STYLE+FL_ENGRAVED_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT,140,230,90,10,"Reza Naima, 1996");
    fl_set_object_lsize($obj,FL_TINY_SIZE);
    fl_set_object_lstyle($obj,FL_BOLD_STYLE);
  $picture = $obj = fl_add_bitmap(FL_NORMAL_PIXMAP,10,110,100,120,"");
    fl_set_object_boxtype($obj,FL_DOWN_BOX);
  $browser= $obj = fl_add_browser(FL_NORMAL_BROWSER,250,10,220,260,"");

$buttons = fl_bgn_group();
  $cpu = $obj = fl_add_lightbutton(FL_PUSH_BUTTON,120,210,70,20,"CPU");
    fl_set_object_callback($obj,"button1",1);
  $int = $obj = fl_add_lightbutton(FL_PUSH_BUTTON,120,190,70,20,"INT");
    fl_set_object_callback($obj,"button2",2);
  $io = $obj = fl_add_lightbutton(FL_PUSH_BUTTON,120,170,70,20,"IO");
    fl_set_object_callback($obj,"button3",3);
  $pci = $obj = fl_add_lightbutton(FL_PUSH_BUTTON,120,150,70,20,"PCI");
    fl_set_object_callback($obj,"button4",4);
  $dma = $obj = fl_add_lightbutton(FL_PUSH_BUTTON,120,130,70,20,"DMA");
    fl_set_object_callback($obj,"button5",5);
  fl_end_group();

$obj =  fl_add_button(FL_NORMAL_BUTTON,10,10,100,40,"Quit");
    fl_set_object_lsize($obj,FL_LARGE_SIZE);
    fl_set_object_lstyle($obj,FL_BOLD_STYLE);
    fl_set_object_callback($obj,"quit_cb",0);


  fl_end_form();

}