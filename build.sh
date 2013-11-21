#!/bin/bash
# Copyright (c) 2013, Eberhard Beilharz.
# Distributable under the terms of the MIT license (http://opensource.org/licenses/MIT).
WINE_VERSION=1.7.6
TNTMPD_VERSION=3.0.21
TARGET_DIR=$HOME/wineTntMpd

set -e

if [ "$(uname -m)" != "i686" ]; then
	echo "Wine requires a 32-bit system for building."
	echo "This can easiest be done in a virtual machine."
	exit 1
fi

THISDIR=$(dirname $(readlink -f "$0"))

if [ ! -d wine ]; then
	echo "Cloning Wine source code"
	git clone git://source.winehq.org/git/wine.git
fi	

cd wine
echo "Updating Wine source code"
git checkout master
git reset --hard
git clean -dxf
git fetch origin
git checkout wine-$WINE_VERSION

echo "Building Wine"
./configure --prefix=$TARGET_DIR && make depend && make

echo "Installing Wine"
make install

cd $TARGET_DIR
git init .
git add --all
git commit -m "Installation of Wine $WINE_VERSION"

echo "Installing helper scripts"
cat > environ <<ENDOFENVIRON
PATH="$TARGET_DIR/bin:\$PATH"
export WINEPREFIX=$TARGET_DIR/.wine
ENDOFENVIRON

cat > tntmpd <<ENDOFSTARTUP
#!/bin/bash
cd $(dirname "$0")
. environ
wine .wine/drive_c/Program\ Files/TntWare/TntMPD/TntMPD.exe 2> /dev/null
ENDOFSTARTUP

chmod +x tntmpd
git add --all
git commit -m "Add startup scripts"

echo "Downloading TntMPD"
cd $THISDIR
mkdir downloads
cd downloads
wget http://download.tntware.com/tntmpd/archive/$TNTMPD_VERSION/SetupTntMPD.exe

echo "Installing TntMPD"
cd $TARGET_DIR
. environ
wine $THISDIR/downloads/SetupTntMPD.exe

echo "Saving state"
git add --all
git commit -m "Installation of TntMPD $TNTMPD_VERSION"

echo "Finished."
echo "You can now run $TARGET_DIR/tntmpd to start TntMPD."


