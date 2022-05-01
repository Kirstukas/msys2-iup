#!/bin/bash

# Check if required commands exist
CMDS="wget unzip"
FAILED=0

for CMD in $CMDS
do
	command -v $CMD > /dev/null || { echo "'$CMD' command not found."; FAILED=1; }
done

if [ $FAILED -ne 0 ]
then
	exit 1
fi

# Create temporary working directory
rm -rf libiup32-tmp # Delete if already exists
mkdir libiup32-tmp
cd libiup32-tmp

# Download and unpack iup
wget "https://sourceforge.net/projects/iup/files/3.30/Windows%20Libraries/Static/iup-3.30_Win32_mingw6_lib.zip/download"
unzip download
rm download

# Download and unpack iup-lua
wget "https://sourceforge.net/projects/iup/files/3.30/Windows%20Libraries/Static/Lua54/iup-3.30-Lua54_Win32_mingw6_lib.zip/download"
yes A | unzip download
rm download

# Move all the libraries
for LIBRARY in `cat ../extra/libraries.txt`
do
	echo "$LIBRARY -> /mingw32/lib/$LIBRARY"
	mv $LIBRARY "/mingw32/lib/$LIBRARY"
done

# Move all the headers
for HEADER in `cat ../extra/headers.txt`
do
	echo "$HEADER -> /mingw32/include/$HEADER"
	mv include/$HEADER "/mingw32/include/$HEADER"
done

# Copy pkgconf configuration
mkdir -p /mingw32/lib/pkgconfig
echo "mingw32-iup.pc -> /mingw32/lib/pkgconfig/iup.pc"
cp ../extra/mingw32-iup.pc /mingw32/lib/pkgconfig/iup.pc
echo "mingw32-iup-lua.pc -> /mingw32/lib/pkgconfig/iup-lua.pc"
cp ../extra/mingw32-iup-lua.pc /mingw32/lib/pkgconfig/iup-lua.pc

# Cleanup
cd ..
rm -rf libiup32-tmp

# Done
echo
echo Done!
