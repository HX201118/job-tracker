@echo off
setlocal
cd /d "%~dp0"

set "PYEXE="
for %%P in (python.exe) do if not defined PYEXE set "PYEXE=%%~$PATH:P"
if not defined PYEXE (
  where py >nul 2>nul && set "PYEXE=py"
)
if not defined PYEXE (
  for %%D in (
    "D:\python.dow"
    "C:\Users\HX\.workbuddy\binaries\python\versions\3.13.12"
    "%LOCALAPPDATA%\Programs\Python"
    "C:\Python313" "C:\Python312" "C:\Python311" "C:\Python310" "C:\Python39" "C:\Python38"
    "D:\Python313" "D:\Python312" "D:\Python311" "D:\Python310" "D:\Python39"
    "C:\Program Files\Python313" "C:\Program Files\Python312" "C:\Program Files\Python311"
  ) do (
    if not defined PYEXE if exist "%%~D\python.exe" set "PYEXE=%%~D\python.exe"
  )
)
if not defined PYEXE (
  for /d %%V in ("%LOCALAPPDATA%\Programs\Python\Python3*") do (
    if not defined PYEXE if exist "%%~V\python.exe" set "PYEXE=%%~V\python.exe"
  )
)

if not defined PYEXE (
  echo ============================================================
  echo  [ERROR] Python 3 was not found on this computer.
  echo  1^) Install Python 3: https://www.python.org/downloads/
  echo     ^(remember to tick "Add python.exe to PATH"^)
  echo  2^) Or open this file with Notepad and add your python.exe
  echo     path to the list above, then run it again.
  echo ============================================================
  echo.
  pause
  exit /b 1
)

echo ============================================================
echo   Job Tracker - local server for SYSTEM NOTIFICATIONS
echo   Python : %PYEXE%
echo   Address: http://127.0.0.1:8765/job-tracker.html
echo   Close this window (or Ctrl+C) to stop. Your data is safe.
echo ============================================================
echo.
"%PYEXE%" "%~dp0serve.py"
echo.
pause
