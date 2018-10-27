#!/bin/sh
VIM_CONF=~/.vimrc
BUNDLE_DIR=~/.vim/bundle/

if [ ! -f $VIM_CONF ]; 
then
        cp vimrc ~/.vimrc -rf
        echo 'cp .vimrc done'
fi

if [ ! -d $BUNDLE_DIR ];
then
        mkdir -p $BUNDLE_DIR
fi

for file in `find . -name "*.zip" -print`
do 
        echo "unzip file to $BUNDLE_DIR"
        unzip -o $file -d $BUNDLE_DIR
done


for dir in `find $BUNDLE_DIR -name "*-master" -print`
do 
        echo "change dir name"
        new_dir=${dir/-master/}
        mv $dir $new_dir
done
