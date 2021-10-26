#!/bin/bash
sudo su
WORKDIR=$(pwd)
mkdir DEBIAN
#mkdir -p $WORKDIR/usr/local/bin cp /usr/local/bin/deb.sh $WORKDIR/usr/local/bin/
cat >  DEBIAN/control << EOF
Package: movie-ui
Version: 0.2
Maintainer: melissa.jimenezc
Architecture: all
Description: ui 
EOF
touch DEBIAN/postinst
chmod +x DEBIAN/postinst
dpkg-deb --build $WORKDIR


#