@echo off
title Windows 11 DEEP CLEAN FIX
color 0A

echo Force kill update services...
taskkill /f /im TiWorker.exe 2>nul
taskkill /f /im TrustedInstaller.exe 2>nul
taskkill /f /im MoUsoCoreWorker.exe 2>nul
taskkill /f /im UsoClient.exe 2>nul

echo Stopping services...
net stop wuauserv /y
net stop bits /y
net stop cryptsvc /y

echo Cleaning temp...
del /s /f /q %temp%\* 2>nul
rd /s /q %temp% 2>nul

del /s /f /q C:\Windows\Temp\* 2>nul
rd /s /q C:\Windows\Temp 2>nul

echo Reset update cache...
rd /s /q C:\Windows\SoftwareDistribution 2>nul
rd /s /q C:\Windows\System32\catroot2 2>nul

echo Flush DNS...
ipconfig /flushdns

echo Clear thumbnails...
del /f /q %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_* 2>nul

echo DISM repair...
DISM /Online /Cleanup-Image /RestoreHealth

echo SFC...
sfc /scannow

echo Restart services...
net start wuauserv
net start bits
net start cryptsvc

echo Done
pause