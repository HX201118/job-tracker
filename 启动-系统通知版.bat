@echo off
cd /d "%~dp0"
echo ============================================================
echo   Job Tracker - local server for SYSTEM NOTIFICATIONS
echo   Opening via http://localhost so the browser allows popups.
echo   Close this window (or Ctrl+C) to stop. Your data is safe.
echo ============================================================
echo.
where python >nul 2>nul
if %errorlevel%==0 (
  python "%~dp0serve.py"
  goto :done
)
where py >nul 2>nul
if %errorlevel%==0 (
  py "%~dp0serve.py"
  goto :done
)
echo [ERROR] Python 3 not found in PATH.
echo         Install Python 3 first, then run this file again.
echo         Download: https://www.python.org/downloads/
:done
echo.
pause
