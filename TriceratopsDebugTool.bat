@echo off
title Triceratops Debug Tool
color 0e

:menu
cls
echo ----------------------
echo Triceratops Debug Tool
echo ----------------------
echo.
echo Select an option:
echo.
echo [1] System File Checker
echo [2] Deployment Image Servicing and Management
echo [3] Disk Cleanup (Work in Progress)
echo [4] Defragment and Optimize Drives
echo [5] Restart Windows Explorer
echo [6] Exit Debug Tool
echo.
set /p op=">>> "
if %op%==1 goto 1
if %op%==2 goto 2
if %op%==3 goto 3
if %op%==4 goto 4
if %op%==5 goto 5
if %op%==6 goto exit
goto error
pause >nul

:1
cls
echo ----------------------
echo System File Checker
echo ----------------------
echo.
echo [1] Start Scan
echo [2] Return to Menu
echo.
set /p op=">>> "
if %op%==1 goto sfcscan
if %op%==2 goto menu
goto error
pause >nul

:sfcscan
cls
sfc /scannow
echo Press Any Key to Continue...
pause >nul
goto menu

:2
cls
echo ----------------------
echo Deployment Image Servicing and Management
echo ----------------------
echo.
echo [1] Scan Health
echo [2] Check Health
echo [3] Restore Health
echo [4] Return to Menu
echo.
set /p op=">>> "
if %op%==1 goto scanhealth
if %op%==2 goto checkhealth
if %op%==3 goto restorehealth
if %op%==4 goto menu
goto error
pause >nul
goto menu

:scanhealth
cls
dism.exe /Online /Cleanup-Image /ScanHealth
echo Press Any Key to Continue...
pause >nul
goto menu

:checkhealth
cls
dism.exe /Online /Cleanup-Image /CheckHealth
pause >nul
goto menu

:restorehealth
cls
dism.exe /Online /Cleanup-Image /RestoreHealth
pause >nul
goto menu

:3
cls
echo ----------------------
echo Disk Cleanup
echo ----------------------
echo.
cleanmgr.exe /sagerun:65535
echo Press Any Key to Continue...
pause >nul
goto menu


:4
cls
echo ----------------------
echo Defragment and Optimize Drives
echo ----------------------
echo.
echo Defragmenting Hard Disks. This Might Take Awhile...
ping localhost -n 3 >nul
defrag -c -v
echo.
echo Press Any Key to Continue...
pause >nul
goto menu

:5
cls
echo ----------------------
echo Restart Windows Explorer
echo ----------------------
echo.
taskkill /f /im explorer.exe
timeout /t 1 /nobreak > nul
start explorer.exe
echo Press Any Key to Continue...
pause >nul
goto menu

:error
cls
echo Error Has Occurred
ping localhost -n 3 >nul
goto menu

:exit
/b