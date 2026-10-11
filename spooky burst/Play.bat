@echo off
rem Starts The Spooky Burst from this folder.
rem Godot only plays sounds after importing them once, so a fresh copy gets imported first.
set GD=%~dp0..\work\tools\godot
set PROJ=%~dp0the-spooky-burst
if not exist "%PROJ%\.godot\imported" "%GD%\Godot_v4.3-stable_win64_console.exe" --headless --path "%PROJ%" --import
start "" "%GD%\Godot_v4.3-stable_win64.exe" --path "%PROJ%"
