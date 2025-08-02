@echo off
title Triceratops Debug Tool
color 0E
setlocal enabledelayedexpansion

:: Check if running as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges . . .
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:mainMenu
cls
echo ==================================================
echo Main Menu
echo ==================================================
echo.
echo 1. System File Checker
echo 2. Deployment Image Servicing and Management
echo 3. Restart Windows Explorer
echo 4. Defragment and Optimize Drives
echo 5. Open Disk Cleanup
echo 6. Open Sound Control Panel
echo 7. Open Advanced System Settings
echo 8. List System Information
echo.
echo 9. Exit
echo.

set /p choice=Select an option: 

if "%choice%"=="1" call :sfc
if "%choice%"=="2" call :dism
if "%choice%"=="3" call :rwe
if "%choice%"=="4" call :dod
if "%choice%"=="5" call :odc
if "%choice%"=="6" call :scp
if "%choice%"=="7" call :ass
if "%choice%"=="8" call :lsi
if "%choice%"=="9" goto :eof

cls
echo Invalid option selected.
pause
goto :mainMenu

:: ---- System File Checker ----
:sfc
cls
echo ==================================================
echo System File Checker
echo ==================================================
echo.
echo 1. Scan Now    // Scans all protected system files and attempts to repair any issues found.
echo 2. Verify Only // Scans all protected system files, but does not attempt to repair them.
==
echo 3. Return to Main Menu
echo.

set /p choice=Select an option: 

if "%choice%"=="1" call :scanNow
if "%choice%"=="2" call :verifyOnly
if "%choice%"=="3" goto :mainMenu

cls
echo Invalid option selected.
pause
goto :mainMenu

:scanNow
cls
echo Running System File Checker - Scan Now . . .
sfc /scannow
echo.
pause
goto :mainMenu

:verifyOnly
cls
echo Running System File Checker - Verify Only . . .
sfc /verifyonly
echo.
pause
goto :mainMenu

:: ---- Deployment Image Servicing and Management ----
:dism
cls
echo ==================================================
echo Deployment Image Servicing and Management
echo ==================================================
echo.
echo 1. Check Health    // Performs a quick check to determine if the Windows image has been corrupted.
echo 2. Scan Health     // Executes a more comprehensive scan for image corruption.
echo 3. Restore Health  // Scans for and repairs corrupted files in the Windows image.
echo.
echo 4. Return to Main Menu
echo.

set /p choice=Select an option: 

if "%choice%"=="1" call :checkHealth
if "%choice%"=="2" call :scanHealth
if "%choice%"=="3" call :restoreHealth
if "%choice%"=="4" goto :mainMenu

cls
echo Invalid option selected.
pause
goto :mainMenu

:checkHealth
cls
echo Running Deployment Image Servicing and Management - Check Health . . .
dism /Online /Cleanup-Image /CheckHealth
echo.
pause
goto :mainMenu

:scanHealth
cls
echo Running Deployment Image Servicing and Management - Scan Health . . .
dism /Online /Cleanup-Image /ScanHealth
echo.
pause
goto :mainMenu

:restoreHealth
cls
echo Running Deployment Image Servicing and Management - Restore Health . . .
dism /Online /Cleanup-Image /RestoreHealth
echo.
pause
goto :mainMenu

:: ---- Restarting Windows Explorer ----
:rwe
cls
echo Restarting Windows Explorer . . .
taskkill /f /im explorer.exe
timeout /t 1 /nobreak > nul
start explorer.exe
echo.
pause
goto :mainMenu

:: ---- Defragment and Optimize Drives ----
:dod
cls
echo Defragment and Optimize Drives . . .
start dfrgui.exe
echo.
pause
goto :mainMenu

:: ---- Open Disk Cleanup ----
:odc
cls
echo Opening Disk Cleanup . . .
start cleanmgr.exe
echo.
pause
goto :mainMenu

:: ---- Open Sound Control Panel ----
:scp
cls
echo Opening Sound Control Panel . . .
control mmsys.cpl sounds
echo.
pause
goto :mainMenu

:: ---- Open Advanced System Settings ----
:ass
cls
echo Opening Advanced System Settings . . .
sysdm.cpl
echo.
pause
goto :mainMenu

:: ---- List System Information ----
:lsi
cls
echo ==================================================
echo System Information
echo ==================================================
echo.
echo OS Information:
systeminfo | findstr /B /C:"OS"
echo.
echo --------------------------------------------------
echo.
echo BIOS Information:
powershell -Command "Get-WmiObject -Class Win32_BIOS | Select-Object Manufacturer, Name, Version"
echo.
echo --------------------------------------------------
echo.
echo Motherboard Information:
powershell -Command "Get-WmiObject -Class Win32_BaseBoard | Select-Object Manufacturer, Product, SerialNumber"
echo.
echo --------------------------------------------------
echo.
echo System Architecture: %PROCESSOR_ARCHITECTURE%
echo.
echo --------------------------------------------------
echo.
echo CPU Information:
powershell -Command "Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty Name"
echo.
echo --------------------------------------------------
echo.
echo RAM Information:
systeminfo | findstr /C:"Total Physical Memory"
echo.
echo --------------------------------------------------
echo.
echo GPU Information:
powershell -Command "Get-WmiObject -Class Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion"
echo.
echo --------------------------------------------------
echo.
echo Storage Information:
powershell -Command "Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, @{Name='FreeSpace(GB)';Expression={[math]::round($_.FreeSpace/1GB,2)}}, @{Name='Size(GB)';Expression={[math]::round($_.Size/1GB,2)}}"
echo.
echo --------------------------------------------------
echo.
ipconfig
echo.
echo --------------------------------------------------
echo.
getmac
echo.
echo --------------------------------------------------
echo.
systeminfo | findstr /C:"System Boot Time"
echo.
echo --------------------------------------------------
echo.
echo USB Devices:
powershell -Command "Get-WmiObject -Class Win32_USBHub | Select-Object DeviceID, PNPDeviceID, Description"
echo.
echo --------------------------------------------------
echo.
echo Sound Devices:
powershell -Command "Get-WmiObject -Class Win32_SoundDevice | Select-Object Name, Manufacturer, Status"
echo.
echo --------------------------------------------------
echo.
echo Running Processes:
powershell -Command "Get-Process | Select-Object Name, Id, CPU, StartTime"
echo.
echo --------------------------------------------------
echo.
echo Installed Programs:
powershell -Command "Get-WmiObject -Class Win32_Product | Select-Object Name, Version"
echo.
echo --------------------------------------------------
echo.
pause
goto :mainMenu

goto :eof

:eof
cls
exit