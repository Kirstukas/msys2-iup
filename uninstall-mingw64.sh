#!/bin/bash

# Remove all the libraries
for LIBRARY in `cat extra/libraries.txt`
do
	echo "Removing: /mingw64/lib/$LIBRARY"
	rm "/mingw64/lib/$LIBRARY"
done

# Remove all the headers
for HEADER in `cat extra/headers.txt`
do
	echo "Removing: /mingw64/include/$HEADER"
	rm "/mingw64/include/$HEADER"
done

# Remove pkgconf configuration
echo "Removing: /mingw64/lib/pkgconfig/iup.pc"
rm "/mingw64/lib/pkgconfig/iup.pc"
