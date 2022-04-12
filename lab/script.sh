#!/bin/bash
# Copyright (C) 2022 Muhammad Athallah

# This free document is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# START Tue 12 Apr 2022 12:23:13 WIB

echo "$(tput setaf 3)Pastikan file uji kasus berada di folder tc pada parent directory bersama dengan folder kode mahasiswa dan skrip ini.$(tput sgr 0)"

read -p "Masukkan kode asisten dosen kamu: " ASDOSCODE
read -p "Masukkan nama file main class: " MAINCLASS

# Count testcase file
TESTCASEAMTRAW=`ls tc/ | wc -l`
TESTCASEAMT=$((TESTCASEAMTRAW / 2))

# For loop each student's directory
for dir in $ASDOSCODE*/
do
    # Remove the trailing "/" from the directory path
    dir=${dir%*/}
    echo "$(tput setaf 6)Grading ${dir##*/}...$(tput sgr 0)"
    cd $dir
    
    echo "Compiling files..."
    javac *.java

    # Make folder
    mkdir -p out
    mkdir -p report

    for (( i=1; i<=$TESTCASEAMT; i++ ))
    do
        echo Checking test case \#$i...
        cat ../tc/in$i.txt | java $MAINCLASS > out/out$i.txt
        diff -s --strip-trailing-cr out/out$i.txt ../tc/out$i.txt | tee report/testcase$i.txt
        echo
    done
    
    echo "$(tput setaf 2)Done grading ${dir##*/}.$(tput sgr 0)"
    echo ""
    
    cd ..
done

read -n1 -rsp "Press any key to continue . . . " 
echo ""
