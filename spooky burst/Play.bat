@echo off
setlocal
rem Starts The Spooky Burst from this folder.
rem Godot only plays sounds after importing them once, so a fresh copy gets imported first.
rem Godot is looked for in this order:
rem   1. GODOT, if you set it to Godot's folder or .exe
rem   2. the Godot you picked before (saved in godot_path.txt)
rem   3. a "godot" folder next to this file (git ignores it)
rem   4. ..\work\tools\godot (the old local setup)
rem   5. godot.exe on your PATH
rem If none is found, it offers to download Godot or let you pick one.
set "PROJ=%~dp0the-spooky-burst"
set "SAVED=%~dp0godot_path.txt"
set "GD_URL=https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_win64.exe.zip"
rem Godot's official SHA512 for that zip, so a broken or tampered download is never used
set "GD_SHA=ad09b7e19949327700dfbe64e35880a2a08091c0751277f5cc21b915e5df9b4fe93fb43c50d6bdfb9d16b46168592491aa698e0d2dbe9f92132e163dd77b97e1"

:search
set "GD_EXE="
set "GD_PICK="
if defined GODOT if exist "%GODOT%\" call :find "%GODOT%"
if not defined GD_EXE if defined GODOT if exist "%GODOT%" set "GD_EXE=%GODOT%"
if not defined GD_EXE if exist "%SAVED%" set /p GD_PICK=<"%SAVED%"
if not defined GD_EXE if defined GD_PICK if exist "%GD_PICK%" set "GD_EXE=%GD_PICK%"
if not defined GD_EXE call :find "%~dp0godot"
if not defined GD_EXE call :find "%~dp0..\work\tools\godot"
if not defined GD_EXE for %%G in (godot.exe) do if not "%%~$PATH:G"=="" set "GD_EXE=%%~$PATH:G"
if not defined GD_EXE goto notfound

rem the console version shows import progress; fall back to the normal one if it isn't there
for %%F in ("%GD_EXE%") do set "GD_CON=%%~dpnF_console.exe"
if not exist "%GD_CON%" set "GD_CON=%GD_EXE%"

rem Import every launch, so anything new (a sound, the mansion picture) is picked up. It's a second when
rem nothing has changed; the first run takes a moment.
if not exist "%PROJ%\.godot\imported" echo First run: importing sounds and pictures, this takes a moment...
"%GD_CON%" --headless --path "%PROJ%" --import
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
echo.
echo The Spooky Burst needs Godot 4 to run, and it isn't set up yet.
echo.
echo   1 = Download Godot 4.3 for me (free, about 57 MB)
echo   2 = I already have Godot, let me pick it
echo   3 = Quit
echo.
choice /c 123 /n /m "Press 1, 2 or 3: "
if errorlevel 3 exit /b 1
if errorlevel 2 goto pick

echo.
echo Downloading Godot 4.3 from godotengine's GitHub...
set "GD_DEST=%~dp0godot"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue'; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; $z=Join-Path $env:TEMP 'spooky_godot_4.3.zip'; Invoke-WebRequest -UseBasicParsing -Uri $env:GD_URL -OutFile $z; if ((Get-FileHash -Algorithm SHA512 $z).Hash -ne $env:GD_SHA) { Remove-Item $z; throw 'The download did not match Godot''s official file.' }; Expand-Archive -Force $z $env:GD_DEST; Remove-Item $z"
if errorlevel 1 (
  echo.
  echo The download didn't work. Check your internet and try again,
  echo or get Godot from godotengine.org and pick it with option 2.
  pause
  goto notfound
)
echo Done! Godot is in: %GD_DEST%
goto search

:pick
echo.
echo A window will open. Find Godot_v4...win64.exe and click Open.
powershell -NoProfile -STA -Command "Add-Type -AssemblyName System.Windows.Forms; $d=New-Object System.Windows.Forms.OpenFileDialog; $d.Title='Pick Godot 4 (Godot_v4...win64.exe)'; $d.Filter='Godot|Godot*.exe|All programs|*.exe'; if ($d.ShowDialog() -ne 'OK') { exit 2 }; if ((Split-Path -Leaf $d.FileName) -notlike 'Godot*.exe') { exit 3 }; [IO.File]::WriteAllText($env:SAVED, $d.FileName)"
if errorlevel 3 (
  echo That doesn't look like Godot. Its name starts with Godot_v4.
  pause
  goto notfound
)
if errorlevel 2 goto notfound
echo Got it. Play.bat will remember that Godot next time.
goto search
