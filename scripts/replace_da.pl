#!/usr/bin/perl
use strict;
use warnings;

# Check if the filename is provided
if (@ARGV != 1) {
    die "Usage: $0 <filename>\n";
}

my $filename = $ARGV[0];

# Read the content of the file
open my $fh, '<', $filename or die "Cannot open file: $!";
my $content = do { local $/; <$fh> };
close $fh;

# Perform the replacement
$content =~ s/da='[^']*'/da=''\/g;

# Write the modified content back to the file
open my $fh, '>', $filename or die "Cannot write to file: $!";
print $fh $content;
close $fh;

print "Replacement complete.\n";
