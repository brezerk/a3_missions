@ECHO OFF
rem ECHO Copying BrezBlock.framework to addons/ folder
rem xcopy /I /E /Y ..\BrezBlock.framework addons\BrezBlock.framework
ECHO Executing makepbo (Make sure you have Mikero's Dos Tools installed)
set /p temp="Press any key to continue . . ."
"C:\Program Files (x86)\Mikero\DePboTools\bin\MakePbo.exe" -P -X=*.sh,*.bat,*.png,*.jpg,*.jpeg ./ ../HeadlessTest.Altis.pbo
PAUSE
