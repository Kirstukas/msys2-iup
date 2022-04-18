# Remove all the libraries
for LIBRARY in `cat extra/libraries.txt`
do
	echo "Removing: /mingw32/lib/$LIBRARY"
	rm "/mingw32/lib/$LIBRARY"
done

# Remove all the headers
for HEADER in `cat extra/headers.txt`
do
	echo "Removing: /mingw32/include/$HEADER"
	rm "/mingw32/include/$HEADER"
done

# Remove pkgconf configuration
echo "Removing: /mingw32/lib/pkgconfig/iup.pc"
rm "/mingw32/lib/pkgconfig/iup.pc"
