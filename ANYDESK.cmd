@echo off
echo ---------- Dang cai dat Anydesk ----------
%~dp0anydesk.exe --install  "C:\Program Files (x86)\AnyDesk" --start-with-win --create-desktop-icon
timeout /t 30
echo Vinhphuc@2021 | "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --set-password
timeout /t 20
for /f "delims=" %%i in ('"C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --get-id') do set ID=%%i 
echo AnyDesk ID is: %ID% >> C:\temp\id.txt