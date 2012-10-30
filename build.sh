#!/bin/bash

# this script should be replaced by a proper Makefile, until then...

dir=`dirname $0`
dir=`readlink -f "$dir"`
packagename=`basename $dir`

if [ ! -e "$dir/src" ]; then
	echo "\"src\" directory not found, exiting."
	exit 1
fi

cd "$dir/src"
if [ $? != 0 ]; then
	echo "Could nout cd into \"src\" dir"
	exit 2
fi

now=`date +%Y%m%d_%H%M%S`
package="${packagename}_${now}.deb"

echo "Updating md5sums controlfile..."
find -type f  | sed -e 's/^.\///g' | grep -v 'DEBIAN/' | xargs md5sum > DEBIAN/md5sums

# http://www.debian.org/doc/debian-policy/ch-files.html#s-permissions-owners
echo "Fixing permissions of control directory..."
chown -R 0:0 DEBIAN
chmod 755 DEBIAN
chmod 644 DEBIAN/*
# chmod 755 DEBIAN/{preinst,postinst,prerm,postrm}

echo "Building package ($package)..."
mkdir -p ../builds
dpkg-deb --build . ../builds/$package
result=$?

if [ $result == 0 ]; then
	echo "Successfully built."
	exit 0
else
	echo "dpkg-deb returned error code $result, exiting."
	exit $result
fi

