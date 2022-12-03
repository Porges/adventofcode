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
apt-get install -y fis-gtm 
