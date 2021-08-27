#!/usr/bin/perl
$input = <>;
if ($input =~ /BPM:aiExample .*\b(\d)\b/) {
    if ($1 > 0 && $1 < 10) {
	exit 0;
    } else {
	print "Expected value was out of range: $1";
	exit 2;
    }
}

print $input;
exit 1;
