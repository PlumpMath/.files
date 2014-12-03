#!/bin/bash

###
# Script which symlinks the contents of it's folder into the parent folder.
###

currentDir=$(pwd)
dest="$HOME"
if [[ $1 != "" ]]; then
    dest=$1
fi
echo "Creating links in $dest"

for file in $(ls -a); do
    # If the file is ., .., .git, this script or README then do nothing.
    if [[ $file =~ ^.$|^..$|^.git$|^symlinker.bash$|^setup.bash$|^README$ ]]; then
	continue
    fi

    if [[ -e $dest/$file ]]; then
	echo $file already exists, moving existing to $file.old
	mv $dest/$file $dest/$file.old
    fi
    ln -s $currentDir/$file $dest/$file
done
