#!/usr/bin/perl 
use X11::Xforms;
#-*-perl-*-
# Autogenerated by fd2pl from fdesign file ProcCntl.fd
#
#
# This builds a browser that contains the system process tree. It relies
# upon the Linux 'ps -f' command for the heirarchical view. However, in
# the demos directory is another script named psf that, with a bit of
# tweaking, should be able to emulate that command on other systems. 
# Therefore, you can replace the 'ps -xafw' command used here with 'psf -xaw'
# and get the same results. 
#
# Unless you have a /proc file system, the details menu will not work
#

fl_initialize('ProcCntl');
$ProcCntl = undef;
@Processes = undef;
$SelectedProcs = undef;
$Browser = undef;
$Menu = undef;
$details_showing = 0;
$details_proc = 0;
$autoupdate = 1;
$menuautoupdate = 1;
$ProcDtls = undef;
$stackBase = undef;
$stackPtr = undef;
$codeStart = undef;
$codeEnd = undef;
$instPtr = undef;
$mappedMemory = undef;
$sigPnMask = undef;
$sigBlMask = undef;
$sigIgMask = undef;
$sigCtMask = undef;
$minFaultsSelf = undef;
$VMsize = undef;
$residentSet = undef;
$minFaultsTree = undef;
$majFaultsTree = undef;
$majFaultsSelf = undef;
$kernCPUSelf = undef;
$kernCPUTree = undef;
$userCPUTree = undef;
$userCPUSelf = undef;
$procGrp = undef;
$pid = undef;
$ppid = undef;
$tty = undef;
$state = undef;
$session = undef;
$priority = undef;
$ttyProcGrp = undef;
$executable = undef;

%state_string = (
	R => "Running",
	S => "Suspended",
	D => "Sleep/Swap",
	Z => "Zombie",
	T => "Traced/Stopped"
);


create_the_forms();
PopulateBrowser();
($icon_pixmap, $w, $h, $mask, $hx, $hy) = fl_read_pixmapfile(fl_default_window(),"crab45.xpm",0);
fl_set_form_icon($ProcCntl,$icon_pixmap,1);
fl_show_form($ProcCntl, FL_PLACE_FREE, FL_FULLBORDER, "Processes");
fl_add_timeout(10000, "AutoUpdate", 0);
fl_do_forms();
exit 0;

sub PopulateBrowser {

	$top = fl_get_browser_topline($Browser);
	$newtop = -1;
	if (!defined($topproc = $Processes[$top-1])) {
		$topproc = 0;
	}
	@Processes = ();
	@SelectedProcs = ();
	fl_freeze_form($ProcCntl); 
	fl_clear_browser($Browser);
	open (PROCS, 'ps -xafw |');
	$linenum = 0;
	while ($procline = <PROCS>) {
		if ($procline =~ /\s*(\d\d*).*:\d\d (.*)/) {
			$linenum++;
			$procnum = $1;
			$proctext = $2;
			push (@Processes,$procnum);
			$newtop = $linenum if ($procnum == $topproc);
			fl_add_browser_line($Browser,$proctext);
		}
	}
	if ($newtop == -1) {
		if ($top <= $linenum) {
			$newtop = $top;
		} else {
			$newtop = $linenum;
		}
	}
	fl_set_browser_topline($Browser, $newtop);
	fl_set_menu_item_mode($Menu, 2, FL_PUP_GRAY);
	fl_unfreeze_form($ProcCntl);
	close PROCS;
}
			
sub SelectBrows {

	my $selline = fl_get_browser($Browser);
	my $process = $Processes[abs($selline)-1];

	if ($selline > 0) {
		push (@SelectedProcs, $process);
		show_details($process) if ($details_showing);
	} else {
		for ($i = 0; $i <= $#SelectedProcs && $SelectedProcs[$i] != $process; $i++) {}
		splice (@SelectedProcs, $i, 1) if ($i <= $#SelectedProcs);
	}
	if (@SelectedProcs) {
		fl_set_menu_item_mode($Menu, 1, FL_PUP_NONE);
		fl_set_menu_item_mode($Menu, 2, FL_PUP_NONE);
		$autoupdate = 0;
	} else { 		
		fl_set_menu_item_mode($Menu, 1, FL_PUP_GRAY);
		fl_set_menu_item_mode($Menu, 2, FL_PUP_GRAY);
		$autoupdate = $menuautoupdate;
	}

}

sub AutoUpdate {
	my($num, $obj) = @_;

	if ($autoupdate) {
		PopulateBrowser();
		show_details($details_proc) if ($details_showing);
	}
	
	fl_add_timeout(10000, "AutoUpdate", 0);
}

sub HideDetails {

	fl_hide_form($ProcDtls);
	$details_showing = 0;

}

sub ProcMenu {

	$menuitem = fl_get_menu($Menu);
	if ($menuitem == 5) {
		fl_finish();
		exit;
	} elsif ($menuitem == 4) {
		$menuautoupdate = $autoupdate = !$menuautoupdate;
	} elsif ($menuitem == 3) {
		PopulateBrowser();
		show_details($details_proc) if ($details_showing);
		$autoupdate = $menuautoupdate;
	} elsif ($menuitem == 1 && @SelectedProcs) {
		show_details($SelectedProcs[0]);
	} elsif ($menuitem == 2 && @SelectedProcs) {
		kill (9, @SelectedProcs);  
		PopulateBrowser();
		$autoupdate = $menuautoupdate;
	}

}

sub show_details {

  my($proc) = @_;
  open(PROCDTLS,"/proc/$proc/stat");
  $procdtls = <PROCDTLS>;
  close PROCDTLS;

  open(PROCMAPS,"/proc/$proc/maps");
  @mapdtls = <PROCMAPS>;
  close PROCMAPS;

  open(PROCMEM,"/proc/$proc/statm");
  $memdtls = <PROCMEM>;
  close PROCMEM;

#
# This array is derived from the output of the get_stat function
# in the Linux kernel source 'fs/proc/array.c'
#

  ($pid_val,
  $executable_val,
  $state_i,
  $ppid_val,
  $procGrp_val,
  $session_val,
  $tty_val,
  $ttyProcGrp_val,
  $flags_val,
  $minFaultsSelf_val,
  $minFaultsTree_val,
  $majFaultsSelf_val,
  $majFaultsTree_val,
  $userCPUSelf_val,
  $kernCPUSelf_val,
  $userCPUTree_val,
  $kernCPUTree_val,
  $priority_val,
  $nice_val,
  $time_to_time_out_val,
  $time_to_sigalrm_val,
  $start_time_val,
  $VMsize_val,
  $residentSet_val,
  $max_res_set_size_val,
  $codeStart_val,
  $codeEnd_val,
  $stackBase_val,
  $stackPtr_val,
  $instPtr_val,
  $sigPnMask_val,
  $sigBlMask_val,
  $sigIgMask_val,
  $sigCtMask_val,
  $channel,
  $swapSelf,
  $swapTree) = split(' ',$procdtls);

  $state_val = $state_string{"$state_i"};

  ($mem_size_val,
  $mem_res_val,
  $mem_share_val,
  $mem_text_val,
  $mem_lib_val,
  $mem_data_val,
  $mem_dirty_val) = split(' ',$memdtls);

  fl_set_object_label($stackBase,sprintf('%#010X', $stackBase_val));
  fl_set_object_label($stackPtr,sprintf('%#010X',$stackPtr_val));
  fl_set_object_label($codeStart,sprintf('%#010X',$codeStart_val));
  fl_set_object_label($codeEnd,sprintf('%#010X',$codeEnd_val));
  fl_set_object_label($instPtr,sprintf('%#010X',$instPtr_val));
  fl_set_object_label($sigPnMask,sprintf('%#010X',$sigPnMask_val));
  fl_set_object_label($sigBlMask,sprintf('%#010X',$sigBlMask_val));
  fl_set_object_label($sigIgMask,sprintf('%#010X',$sigIgMask_val));
  fl_set_object_label($sigCtMask,sprintf('%#010X',$sigCtMask_val));
  fl_set_object_label($minFaultsSelf,$minFaultsSelf_val);
  fl_set_object_label($VMsize,$VMsize_val/1024);
  fl_set_object_label($residentSet,$mem_res_val*4);
  fl_set_object_label($minFaultsTree,$minFaultsTree_val);
  fl_set_object_label($majFaultsTree,$majFaultsTree_val);
  fl_set_object_label($majFaultsSelf,$majFaultsSelf_val);
  fl_set_object_label($kernCPUSelf,$kernCPUSelf_val);
  fl_set_object_label($kernCPUTree,$kernCPUTree_val);
  fl_set_object_label($userCPUTree,$userCPUTree_val);
  fl_set_object_label($userCPUSelf,$userCPUSelf_val);
  fl_set_object_label($procGrp,$procGrp_val);
  fl_set_object_label($pid,$pid_val);
  fl_set_object_label($ppid,$ppid_val);
  fl_set_object_label($tty,$tty_val);
  fl_set_object_label($state,$state_val);
  fl_set_object_label($session,$session_val);
  fl_set_object_label($priority,$priority_val);
  fl_set_object_label($ttyProcGrp,$ttyProcGrp_val);
  fl_set_object_label($executable,$executable_val);

  fl_freeze_form($ProcDtls) if ($details_showing);
  fl_clear_browser($mappedMemory);
  fl_addto_browser($mappedMemory,"\@baddress           perm offset   dev   inode");
  for ($i = 0; $i <= $#mapdtls; ++$i){
	fl_addto_browser($mappedMemory,$mapdtls[$i]);
  }
  fl_set_browser_topline($mappedMemory, 1);
  fl_show_form($ProcDtls, FL_PLACE_SIZE, FL_FULLBORDER, "Process Details");
  fl_unfreeze_form($ProcDtls) if ($details_showing);
  
  $details_showing = 1;
  $details_proc = $proc;
}

sub create_form_ProcCntl {
  $obj = undef;
  $ProcCntl = fl_bgn_form(FL_NO_BOX, 300, 260);
  $obj = fl_add_box(FL_FLAT_BOX, 0, 0, 300, 260, "");
  $obj = $Browser = fl_add_browser(FL_MULTI_BROWSER, 0, 22, 300, 237, "");
  fl_set_object_gravity($obj, FL_NorthWest, FL_SouthEast);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  fl_set_object_callback($obj, "SelectBrows", 0);
  fl_set_browser_fontsize($obj, FL_NORMAL_SIZE);
  fl_set_browser_fontstyle($obj, FL_FIXED_STYLE);
  fl_set_object_resize($obj, FL_RESIZE_X);
  $obj = $Menu = fl_add_menu(FL_PULLDOWN_MENU, 2, 5, 60, 15, "Process");
  fl_set_object_resize($obj,FL_RESIZE_NONE);
  fl_set_object_gravity($obj, FL_NorthWest, FL_NorthWest);
  fl_set_object_shortcut($obj, "P", 1);
  fl_set_object_boxtype($obj, FL_FLAT_BOX);
  fl_set_object_lsize($obj, FL_NORMAL_SIZE);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  fl_setpup_fontstyle(FL_BOLD_STYLE);
  fl_set_menu($obj, "Details|Kill%l|Refresh Now|Auto Refresh%l|Exit");
  fl_set_menu_item_mode($obj, 1, FL_PUP_GRAY);
  fl_set_menu_item_mode($obj, 2, FL_PUP_GRAY);
  fl_set_menu_item_mode($obj, 4, FL_PUP_CHECK | FL_PUP_TOGGLE);
  fl_set_object_callback($obj, "ProcMenu", 0);

  fl_end_form();
}

sub create_form_ProcDtls {
  $obj = undef;
  $ProcDtls = fl_bgn_form(FL_NO_BOX, 310, 390);
  $obj = fl_add_box(FL_UP_BOX, 0, 0, 310, 390, "");
  $obj = fl_add_button(FL_NORMAL_BUTTON, 5, 368,300,19,"Hide Process Details");
  fl_set_object_callback($obj, "HideDetails", 0);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 5, 190, 300, 175, "Memory Details");
  fl_set_object_lsize($obj, FL_NORMAL_SIZE);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 145, 210, 64, 15, "Minor Faults");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 254, 205, 45, 40, "Tree");
  fl_set_object_lalign($obj, FL_ALIGN_TOP_RIGHT);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 209, 205, 45, 40, "Self");
  fl_set_object_lalign($obj, FL_ALIGN_TOP_RIGHT);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 145, 228, 64, 15, "Major Faults");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 10, 255, 130, 40, "Stack");
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 15, 260, 45, 15, "Base");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 15, 275, 45, 15, "Current");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 260, 70, 15, "0x00000000");
  $stackBase = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 275, 70, 15, "0x00000000");
  $stackPtr = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 10, 305, 130, 55, "Code");
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 15, 310, 45, 15, "Start");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 308, 70, 15, "0x00000000");
  $codeStart = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 325, 70, 15, "0x00000000");
  $codeEnd = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 15, 325, 45, 15, "End");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 14, 340, 50, 15, "Instr Ptr");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 340, 70, 15, "0x00000000");
  $instPtr = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_browser(FL_NORMAL_BROWSER, 150, 265, 150, 95, "Mapped Regions");
  $mappedMemory = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_TOP);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  fl_set_browser_fontsize($obj, 11);
  fl_set_browser_fontstyle($obj, FL_FIXED_STYLE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 5, 105, 135, 75, "Signal Masks");
  fl_set_object_lsize($obj, FL_NORMAL_SIZE);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 6, 115, 75, 15, "Pending");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 6, 130, 75, 15, "Blocked");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 6, 160, 75, 15, "Caught");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 6, 145, 75, 15, "Ignored");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 115, 70, 15, "0x00000000");
  $sigPnMask = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 130, 70, 15, "0x00000000");
  $sigBlMask = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 145, 70, 15, "0x00000000");
  $sigIgMask = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 65, 160, 70, 15, "0x00000000");
  $sigCtMask = $obj;
  fl_set_object_lstyle($obj, FL_FIXED_STYLE);
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 210, 210, 42, 15, "000");
  $minFaultsSelf = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 10, 205, 130, 40, "Sizes (Kb)");
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 15, 210, 45, 15, "VM");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 15, 225, 48, 15, "Res Set");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 67, 210, 68, 15, "0x00000000");
  $VMsize = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 67, 225, 68, 15, "0x00000000");
  $residentSet = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_frame(FL_ENGRAVED_FRAME, 209, 226, 90, 19, "");
  $obj = fl_add_text(FL_NORMAL_TEXT, 255, 210, 42, 15, "000");
  $minFaultsTree = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 255, 228, 42, 15, "000");
  $majFaultsTree = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 210, 228, 42, 15, "000");
  $majFaultsSelf = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 150, 105, 155, 74, "CPU");
  fl_set_object_lsize($obj, FL_NORMAL_SIZE);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 155, 128, 42, 15, "Kernel");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 244, 122, 50, 48, "Tree");
  fl_set_object_lalign($obj, FL_ALIGN_TOP_RIGHT);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_labelframe(FL_ENGRAVED_FRAME, 194, 122, 50, 48, "Self");
  fl_set_object_lalign($obj, FL_ALIGN_TOP_RIGHT);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 155, 152, 37, 15, "User");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 196, 128, 47, 15, "000");
  $kernCPUSelf = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_frame(FL_ENGRAVED_FRAME, 194, 147, 100, 23, "");
  $obj = fl_add_text(FL_NORMAL_TEXT, 246, 128, 47, 15, "000");
  $kernCPUTree = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 246, 151, 47, 15, "000");
  $userCPUTree = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 196, 151, 47, 15, "000");
  $userCPUSelf = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_RIGHT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 176, 46, 78, 15, "Process Group");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 262, 46, 41, 15, "00000");
  $procGrp = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 6, 31, 78, 15, "Process ID");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 90, 31, 45, 15, "00000");
  $pid = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 6, 61, 89, 15, "Parent Proc ID");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 90, 61, 45, 15, "00000");
  $ppid = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 6, 76, 89, 15, "TTY");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 90, 76, 45, 15, "00000");
  $tty = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 5, 46, 43, 15, "State");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 90, 46, 88, 15, "Traced/Stopped");
  $state = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 176, 61, 78, 15, "Session ID");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 262, 61, 41, 15, "00000");
  $session = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 176, 31, 78, 15, "Priority");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 262, 31, 41, 15, "00000");
  $priority = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 176, 76, 78, 15, "TTY Proc Grp");
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 262, 76, 41, 15, "00000");
  $ttyProcGrp = $obj;
  fl_set_object_lalign($obj, FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
  $obj = fl_add_text(FL_NORMAL_TEXT, 50, 3, 210, 23, "Command Name");
  $executable = $obj;
  fl_set_object_lsize($obj, FL_MEDIUM_SIZE);
  fl_set_object_lalign($obj, FL_ALIGN_CENTER|FL_ALIGN_INSIDE);
  fl_set_object_lstyle($obj, FL_BOLD_STYLE);
  fl_end_form();
}

sub create_the_forms {
  create_form_ProcCntl();
  create_form_ProcDtls();
}
1;
