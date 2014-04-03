#!/usr/local/bin/perl
# Credits to Chipmunk and http://www.etherealbits.com/2012/06/the-perl-script-that-may-save-your-life/
# Ask Chipmunk for license for this, this is not my work.

open(DEV, '/dev/sda2') or die "Can't open: $!\n";
while (read(DEV, $buf, 4096)) {
  print tell(DEV), "\n", $buf, "\n"
    if $buf =~ /Cloud/;
}
