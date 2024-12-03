#!/usr/bin/zsh


for musicfile in ~/downloads/*.zip; do
	unzip $musicfile -d ~/music/
	rm $musicfile
	rm -r ~/music/__MACOSX
done
