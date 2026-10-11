@echo off
setlocal
rem Starts The Spooky Burst from this folder.
rem Godot only plays sounds after importing them once, so a fresh copy gets imported first.
rem Godot is looked for in this order:
rem   1. GODOT, if you set it to Godot's folder or .exe
rem   2. a "godot" folder next to this file (git ignores it)
rem   3. ..\work\tools\godot (the old local setup)
rem   4. godot.exe on your PATH
set "PROJ=%~dp0the-spooky-burst"
set "GD_EXE="

if defined GODOT if exist "%GODOT%\" call :find "%GODOT%"
if not defined GD_EXE if defined GODOT if exist "%GODOT%" set "GD_EXE=%GODOT%"
if not defined GD_EXE call :find "%~dp0godot"
if not defined GD_EXE call :find "%~dp0..\work\tools\godot"
if not defined GD_EXE for %%G in (godot.exe) do if not "%%~$PATH:G"=="" set "GD_EXE=%%~$PATH:G"
if not defined GD_EXE goto notfound

rem the console version shows import progress; fall back to the normal one if it isn't there
for %%F in ("%GD_EXE%") do set "GD_CON=%%~dpnF_console.exe"
if not exist "%GD_CON%" set "GD_CON=%GD_EXE%"

if not exist "%PROJ%\.godot\imported" (
  echo First run: importing sounds, this takes a moment...
  "%GD_CON%" --headless --path "%PROJ%" --import
)
start "" "%GD_EXE%" --path "%PROJ%"
exit /b 0

:find
rem looks for Godot_v4...win64.exe in a folder, or one folder down (where the zip may unpack)
if not exist "%~1\" goto :eof
for %%F in ("%~1\Godot_v4*_win64.exe") do set "GD_EXE=%%~fF"
if defined GD_EXE goto :eof
for /d %%D in ("%~1\*") do for %%F in ("%%~fD\Godot_v4*_win64.exe") do set "GD_EXE=%%~fF"
goto :eof

:notfound
echo Could not find Godot 4.
echo.
echo Download Godot 4.3 or newer (the standard version, not .NET) from godotengine.org
echo and unzip it into this folder:
echo   %~dp0godot
echo.
echo Or set GODOT to the folder or .exe where Godot is.
pause
exit /b 1
