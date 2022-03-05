@echo off
rem Copyright (C) 2022 Muhammad Athallah

rem This free document is distributed in the hope that it will be
rem useful, but WITHOUT ANY WARRANTY; without even the implied
rem warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

rem REV03 Sun 6 Mar 2022 01:13:10 WIB
rem REV02 Sun 6 Mar 2022 00:00:00 WIB
rem REV01 Sat 5 Mar 2022 17:07:07 WIB
rem START Sat 5 Mar 2022 10:17:30 WIB

rem Import/source credentials script file
call credentials.bat

echo Selamat datang di program penilaian DDP 2!
echo.
echo Pilihan yang dapat dilakukan:
echo 1. Clone repositori mahasiswa
echo 2. Git pull repositori mahasiswa
echo 3. Uji kasus dari tim asisten dosen
echo 4. Hapus kode mahasiswa
echo.
set /p OPT=Apa yang ingin kamu lakukan? (masukkan angka pilihan) 

IF /i "%OPT%"=="1" goto option1
IF /i "%OPT%"=="2" goto option2
IF /i "%OPT%"=="3" goto option3
IF /i "%OPT%"=="4" goto option4

echo Masukan tidak valid.
goto endprogram

:option1
echo Cloning mahasiswa's repository inside 'code' folder...
for /F "usebackq tokens=*" %%i in ("accountmahasiswa.txt") do (
    echo.
    rem Just in case the folder is not created yet!
    if not exist "code\" mkdir code
    git clone https://%USERNAME%:%PASSWORD%@gitlab.com/%%i/assignments.git code/%%i
)
goto endprogram

:option2
echo Pulling mahasiswa's repository inside 'code' folder...
for /F "usebackq tokens=*" %%i in ("accountmahasiswa.txt") do (
    echo.
    if exist "code\%%i\" (
        cd code\%%i
        git pull https://%USERNAME%:%PASSWORD%@gitlab.com/%%i/assignments.git
        cd ..\..
    ) else (
        echo ERROR: Directory %%i does not exist.
    )
)
goto endprogram

:option3
echo Pastikan folder uji kasus dari tim asisten dosen berada di folder 'testcase'!
rem Just in case the folder is not created yet!
if not exist "testcase\" mkdir testcase
set /p PROJECTNAME=Masukkan nama folder tugas pemrograman (contohnya 'assignment1'): 
set /p TESTCASEFOLDER=Masukkan nama folder uji kasus (jangan gunakan spasi!): 
echo Copying new testcases to each mahasiswa's repository folder...
rem Copy testcases to each mahasiswa's folder
for /F "usebackq tokens=*" %%i in ("accountmahasiswa.txt") do (
    if exist "code\%%i\" (
        rem Make report folder
        if not exist "report\%%i\%PROJECTNAME%" mkdir report\%%i\%PROJECTNAME%
        cd testcase\%TESTCASEFOLDER%
        echo.
        for /r %%j in (*) do (
            echo Copying %%j to %%i folder...
            copy %%j ..\..\code\%%i\%PROJECTNAME%\src\test\java\assignments\%PROJECTNAME%\%%~nxj
        )
        echo.
        echo Testing testcases in %%i folder...
        cd ..\..\code\%%i
        if exist "..\..\report\%%i\%PROJECTNAME%\output.txt" del /f "..\..\report\%%i\%PROJECTNAME%\output.txt"
        for /f "delims=" %%k in ('call gradlew.bat :%PROJECTNAME%:test') do (
            echo %%k
            echo %%k >> ..\..\report\%%i\%PROJECTNAME%\output.txt
        )
        cd ..\..
        echo Done testing testcases in %%i folder.
    ) else (
        echo.
        echo ERROR: Directory %%i does not exist.
    )
)
goto endprogram

:option4
set /p STATUS=Apakah kamu yakin? (Y/N) 

if /i "%STATUS%"=="Y" (
    for /F "usebackq tokens=*" %%i in ("accountmahasiswa.txt") do (
        rd /s /q "code\%%i"
    )
    echo Penghapusan sukses.
    echo Jangan lupa untuk menjalankan cloning kembali!
) else (
    echo Penghapusan dibatalkan.
)
goto endprogram

:endprogram
echo.
echo Terima kasih telah menggunakan skrip ini! Selamat mencari cuan.