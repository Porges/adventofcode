#!/bin/sh

set -eux

tmpdir=$(mktemp -d)
cd "$tmpdir"
wget 'http://ftp.regressive.org/snobol4/snobol4-2.3.1.tar.gz' -O - | tar xz
cd snobol4-2.3.1
./configure && make && make install
cd /tmp
rm -r "$tmpdir"

apt-get update 
apt-get install -y fis-gtm cmake ghc gnucobol4 gfortran aplus-fsf

tmpdir=$(mktemp -d)
cd "$tmpdir"
git clone https://github.com/VorpalBlade/cfunge
mkdir cfunge/build
cd cfunge/build
cmake .. -DUSE_NCURSES=OFF && make && make install
cd /tmp
rm -r "$tmpdir"

tmpdir=$(mktemp -d)
cd "$tmpdir"
wget 'https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.3-linux-x86_64.tar.gz' -O - | tar xz
mv julia-1.8.3 /opt/julia
cd /tmp
rm -r "$tmpdir"
