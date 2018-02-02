@echo off

:: AboutBox
:-------------------------------------
cls
echo                             ~~~~ Hamachi Service Repair Script  ~~~~
echo Version: 1.1
echo Created by Tomeczekqq
echo https://github.com/Tomeczekqq/HamachiServiceRepairScript
pause

:: AdminRights
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo                         ~~~~ Script need administrator privileges... ~~~~
    echo Trying to run HSRS as admin
    pause
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    echo Cant start script.
    goto Script

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
    
::Script
:-------------------------------------
echo                             ~~~~ Starting Hamachi2Svc service...~~~~
echo ::Log
echo {
sc start Hamachi2Svc
echo }
echo                                         ~~~~ Info~~~~
echo If HSRS isnt helping you, check project site for help.
echo https://github.com/Tomeczekqq/HamachiServiceRepairScript
echo Created by Tomeczek 
pause
