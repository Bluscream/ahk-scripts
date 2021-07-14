for /r %%a in (*) do (
echo deleting file "%%a" ...
if exist "%%a" del /s /q "%%a"
)

Ahk2Exe.exe /in infile.ahk [/out outfile.exe] [/icon iconfile.ico] [/bin AutoHotkeySC.bin] [/mpress 1 (true) or 0 (false)] [/cp codepage]