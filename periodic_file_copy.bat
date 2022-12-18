@echo off

set /p "srcpath=Enter directory to backup: "
set /p "ext=Enter file extension to backup: "

:: uncomment for testing
::SET srcpath=C:\tmp
::SET ext=txt
::echo %srcpath%

cd %srcpath%
mkdir backups

:infiloop

cd %srcpath%

::Get DATE
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
:: uncomment for testing
::echo datestamp: "%datestamp%"
::echo timestamp: "%timestamp%"
::echo fullstamp: "%fullstamp%"

:: loop to announce following actions
for /f %%f in ('dir /b *.%ext%') do echo will copy %%f to %%f-%fullstamp%.bkp

:: loop copy all files with given extension
for /f %%f in ('dir /b *.%ext%') do copy %%f %srcpath%/backups/%%f-%fullstamp%.bkp

:: Information of completed loop iteration
echo Creation of %fullstamp% backups is done

:: timeout time is in seconds
echo Will sleep 10 minutes
timeout /t 600 > nul

:: horrible way to loop with labels :)
goto infiloop
