@ECHO OFF
C:
CD\
CLS

:MENU
CLS

ECHO ============= Power Scheme Imp/Exp =============
ECHO -------------------------------------
ECHO 1.  Import and Activate
ECHO 2.  Export 
ECHO ============= Power Scheme Imp/Exp =============

SET INPUT=
SET /P INPUT=Please select a number:

IF /I '%INPUT%'=='1' GOTO Selection1
IF /I '%INPUT%'=='2' GOTO Selection2

CLS

ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu [1-1] or select 'Q' to quit.
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU

:Selection1

powercfg -restoredefaultschemes
POWERCFG -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
POWERCFG -DELETE a1841308-3541-4fab-bc81-f71556f20b4a
pause
POWERCFG -IMPORT C:\exported_power_scheme.pow a1841308-3541-4fab-bc81-f71556f20b4a
del C:\exported_power_scheme.pow
POWERCFG -SETACTIVE a1841308-3541-4fab-bc81-f71556f20b4a
msg * Power Scheme Installed
pause
POWERCFG -list
pause

:Selection2

@echo off
setlocal EnableDelayedExpansion

echo Available power schemes:
echo/

set i=0
set "options="
for /F "tokens=2,3 delims=:()" %%a in ('powercfg /list') do if "%%b" neq "" (
   set /A i+=1
   set "options=!options!!i!"
   echo !i!. %%b
   set "scheme[!i!]=%%a"
)

echo/
choice /C %options% /N /M "Select desired scheme to be exported: "
powercfg /export C:\exported_power_scheme.pow !scheme[%errorlevel%]!
echo/
echo Power scheme Exported
msg * Power Scheme Exported
pause