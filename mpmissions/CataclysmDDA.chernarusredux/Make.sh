#!/bin/bash
echo "Copying BrezBlock.framework to addons/ folder"
rm -rf addons/BrezBlock.framework
cp -rv ../BrezBlock.framework addons/BrezBlock.framework
echo "Executing makepbo (Make sure you have Mikero's Dos Tools installed)"
echo -n "Press any key to continue . . ."
read
makepbo  -P -X=*.xcf,*.psd,*.gif,*.sh,*.bat,*.png,*.jpg,*.jpeg ./ ../CataclysmDDA.chernarusredux.pbo
