@echo off
setlocal enableextensions enabledelayedexpansion
rem Copyright (C) 2022 Muhammad Athallah

rem This free document is distributed in the hope that it will be
rem useful, but WITHOUT ANY WARRANTY; without even the implied
rem warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

rem REV09 Tue 12 Apr 2022 14:03:32 WIB
rem START Tue 12 Apr 2022 13:47:15 WIB

echo Pastikan file uji kasus berada di folder tc pada parent directory bersama dengan folder kode mahasiswa dan skrip ini.

set /p ASDOSCODE=Masukkan kode asisten dosen kamu: 
set /p MAINCLASS=Masukkan nama file main class: 

rem Count testcase file
set /a TESTCASEAMTRAW=0
for /r tc %%X in (*.txt) do set /a TESTCASEAMTRAW+=1
set /a TESTCASEAMT=!TESTCASEAMTRAW!/2

rem Get current directory
set PWD=%cd%

rem For loop each student's directory
for /d %%i in (%PWD%\%ASDOSCODE%*\) do (
    echo Grading %%i...
    cd "%%i"

    echo Compiling files...
    javac *.java

    rem Make folder
    if not exist "out\" mkdir out
    if not exist "report\" mkdir report

    for /l %%j in (1, 1, %TESTCASEAMT%) do (
        echo Checking test case #%%j...
        type ..\tc\in%%j.txt | java %MAINCLASS% > out\out%%j.txt
        fc /w out\out%%j.txt ..\tc\out%%j.txt
        fc /w out\out%%j.txt ..\tc\out%%j.txt > report\testcase$i.txt
    )

    echo Done grading %%i.
    echo.

    cd ..
)
echo Press any key to continue . . . 
pause
echo.