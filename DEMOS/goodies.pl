#!/usr/bin/perl
#/* This demo program uses the routines in the
#   goodies section, that help you create easy
#   forms in an even easier way.
#*/

use Forms_BASIC;
use Forms_GOODIES;

  fl_initialize("FormDemo");

  if( fl_show_question("","Do you want bold font ?", "")) {
     fl_set_goodies_font(FL_BOLD_STYLE,FL_DEFAULT_SIZE);
  }

  fl_show_message("This is a test program",
		"for the goodies of the",
		"forms library");

  fl_show_alert("Alert", "Alert form can be used to inform",
                "recoverable errors", 0);

  exit(0) if (fl_show_question("", "Do you want to quit?",""));

  $str1 = fl_show_input("Give a string:","");
  fl_show_message("You typed:","",$str1);
  $choice = fl_show_choice("Pick a choice","","",3,"One","Two","Three");
  if ($choice == 1) {
     fl_show_message("You typed: One","","");
  } elsif ($choice == 2) {
     fl_show_message("You typed: Two","","");
  } elsif ($choice == 3) {
     fl_show_message("You typed: Three","","");
  } else {
     fl_show_message("An error occured!","","");
  }
  $str2 = fl_show_input("Give another string:",$str1);
  fl_show_message("You typed:","",$str2);
  fl_show_message("Good Bye","","");
