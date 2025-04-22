#!/usr/bin/perl -w

use strict;

use FileHandle;

my $F90 = shift;

my @text = do { my $fh = 'FileHandle'->new ("<$F90"); <$fh> };


for (@text)
  {
    s/\!\$acc enter data attach \((.*)\)/GPU_ATTACH($1)/go;
    s/\!\$acc enter data create \((.*)\)/GPU_CREATE($1)/go;
    s/\!\$acc exit data delete \((.*)\)/GPU_DELETE($1)/go;
    s/\!\$acc exit data detach \((.*)\)/GPU_DETACH($1)/go;
    s/\!\$acc update device \((.*)\)/GPU_UPDATE_DEVICE($1)/go;
  }

'FileHandle'->new (">$F90")-> print (@text);


__END__
#ifdef USE_OPENACC
#define GPU_ATTACH(x)        !$acc enter data attach (x)
#define GPU_CREATE(x)        !$acc enter data create (x)
#define GPU_DELETE(x)        !$acc exit data delete (x)
#define GPU_DETACH(x)        !$acc exit data detach (x)
#define GPU_UPDATE_DEVICE(x) !$acc update device (x)
#endif
