@echo off
color 0a
cd ..
@echo on
echo Installing dependencies...
echo This might take a few moments depending on your internet speed.
haxelib install lime 8.1.2 --always
haxelib install openfl 9.3.3 --always
haxelib install flixel 5.6.1 --always
haxelib install flixel-addons 3.2.2 --always
haxelib install flixel-tools 1.5.1 --always
haxelib install hscript-iris 1.1.0 --always
haxelib install tjson 1.4.0 --always
haxelib install hxdiscord_rpc 1.2.4 --always
haxelib install hxvlc 1.9.2 --always
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 768740a56b26aa0c072720e0d1236b94afe68e3e --always
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit 1906c4a96f6bb6df66562b3f24c62f4c5bba14a7 --always
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis 22b1ce089dd924f15cdc4632397ef3504d464e90 --always
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git cbf91e2180fd2e374924fe74844086aab7891666 --always
echo Finished!
pause
