@echo off
rem ---------------------------------------------------------------------------
rem Dienstplan-Updater (Bootstrap)
rem
rem Diese Datei liegt neben der dienstplan.html und aendert sich praktisch nie.
rem Sie holt nur das aktuelle Installer-Skript von GitHub und startet es.
rem Was genau installiert wird (eine Datei oder mehrere), steht im Installer.
rem ---------------------------------------------------------------------------

setlocal
set "BASE_URL=https://raw.githubusercontent.com/knibel/sn-dienstplan/main"
set "INSTALLER=%TEMP%\sn-dienstplan-install.ps1"

rem %~dp0 endet immer mit einem Backslash. Uebergibt man das direkt als
rem "%~dp0", entwertet der Backslash beim PowerShell-Aufruf das schliessende
rem Anfuehrungszeichen - im Skript kaeme dann C:\Ordner" an ("Illegales
rem Zeichen im Pfad"). Deshalb hier abschneiden.
set "TARGET_DIR=%~dp0"
if "%TARGET_DIR:~-1%"=="\" set "TARGET_DIR=%TARGET_DIR:~0,-1%"

echo Lade Installer...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ErrorActionPreference='Stop';" ^
  "$ProgressPreference='SilentlyContinue';" ^
  "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;" ^
  "Invoke-WebRequest -Uri '%BASE_URL%/install.ps1?t=%RANDOM%%RANDOM%' -Headers @{'Cache-Control'='no-cache'} -OutFile '%INSTALLER%'"

if errorlevel 1 (
  echo.
  echo FEHLER: Installer konnte nicht geladen werden. Besteht eine Internetverbindung?
  echo.
  pause
  exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%INSTALLER%" -TargetDir "%TARGET_DIR%"
set "RC=%ERRORLEVEL%"

del "%INSTALLER%" >nul 2>&1
echo.
pause
exit /b %RC%
