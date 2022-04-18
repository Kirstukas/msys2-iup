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
rm -rf libiup64-tmp # Delete if already exists
mkdir libiup64-tmp
cd libiup64-tmp

# Download and unpack iup
wget "https://sourceforge.net/projects/iup/files/3.30/Windows%20Libraries/Static/iup-3.30_Win64_mingw6_lib.zip/download"
unzip download
rm download

# Download and unpack iup-lua
wget "https://sourceforge.net/projects/iup/files/3.30/Windows%20Libraries/Static/Lua54/iup-3.30-Lua54_Win64_mingw6_lib.zip/download"
yes A | unzip download
rm download

# Move all the libraries
for LIBRARY in `cat ../extra/libraries.txt`
do
	echo "$LIBRARY -> /mingw64/lib/$LIBRARY"
	mv $LIBRARY "/mingw64/lib/$LIBRARY"
done

# Move all the headers
for HEADER in `cat ../extra/headers.txt`
do
	echo "$HEADER -> /mingw64/include/$HEADER"
	mv include/$HEADER "/mingw64/include/$HEADER"
done

# Copy pkgconf configuration
mkdir -p /mingw64/lib/pkgconfig
echo "mingw64-iup.pc -> /mingw64/lib/pkgconfig/iup.pc"
cp ../extra/mingw64-iup.pc /mingw64/lib/pkgconfig/iup.pc
echo "mingw64-iup-lua.pc -> /mingw64/lib/pkgconfig/iup-lua.pc"
cp ../extra/mingw64-iup-lua.pc /mingw64/lib/pkgconfig/iup-lua.pc

# Cleanup
cd ..
rm -rf libiup64-tmp

# Done
echo
echo Done!
