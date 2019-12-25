#!/bin/bash
echo "Copying BrezBlock.framework to addons/ folder"
cp -rv ../BrezBlock.framework addons/BrezBlock.framework
echo "Executing makepbo (Make sure you have Mikero's Dos Tools installed)"
echo -n "Press any key to continue . . ."
read
makepbo  -P -X=*.xcf,*.psd,*.gif,*.sh,*.bat,*.png,*.jpg,*.jpeg ./ ../DynamicOutpost.ProvingGrounds_PMC.pbo
