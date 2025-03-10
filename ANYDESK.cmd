@echo off
echo ---------- Import profile Wifi ----------
echo.
echo ---------- Import profile Wifi HA NAM ----------
netsh wlan add profile filename=%~dp0VN0122.xml
--netsh wlan add profile filename=%~dp0supperwifi.xml
--netsh wlan add profile filename=%~dp0kubo.xml
--netsh wlan add profile filename=%~dp0IOT-hanam.xml
echo.
echo.
echo.
echo ---------- Import profile Wifi VINH PHUC----------
netsh wlan add profile filename=%~dp0vnpost.xml
netsh wlan add profile filename=%~dp0kubo.xml
--netsh wlan add profile filename=%~dp0IOT-VINHPHUC.xml
echo ---------- Remove installation files ----------
%~dp0anydesk.exe --install  "C:\Program Files (x86)\AnyDesk" --start-with-win --create-desktop-icon
timeout /t 30
echo Vinhphuc@2021 | "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --set-password
timeout /t 20
for /f "delims=" %%i in ('"C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --get-id') do set ID=%%i 
echo AnyDesk ID is: %ID% >> C:\temp\id.txt