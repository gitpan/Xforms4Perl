#!/usr/bin/perl -pi.x4p.4
#
# Convert scripts from Xforms4Perl 0.4 to Xforms4Perl 0.5
#

s/Forms_BASIC/Xforms/g;
if (/^\s*use\s\s*Forms_\w*/) {
	s/^(\s*use\s\s*Forms_\w*)/#$1/;
} else {
	s/Forms_\w*/Xforms/g;
}
