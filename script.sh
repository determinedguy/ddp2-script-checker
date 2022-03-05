#!/bin/bash
# Copyright (C) 2022 Muhammad Athallah

# This free document is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# REV01 Sat 5 Mar 2022 17:07:07 WIB
# START Sat 5 Mar 2022 10:17:30 WIB

# Import/source credentials script file
source credentials.sh

# Color for terminal text: https://stackoverflow.com/a/20983251

echo "Selamat datang di program penilaian DDP 2!"
echo ""
echo "Pilihan yang dapat dilakukan:"
echo "1. Clone repositori mahasiswa"
echo "2. Git pull repositori mahasiswa"
echo "3. Uji kasus dari tim asisten dosen"
echo "4. Hapus kode mahasiswa"
echo ""
read -p "Apa yang ingin kamu lakukan? (masukkan angka pilihan) " OPT

if [[ $OPT -eq 1 ]]
then
    echo "Cloning mahasiswa's repository inside 'code' folder..."
    # Clone for each mahasiswa in each mahasiswa's folder
    cat accountmahasiswa.txt | while read line 
    do
        echo ""
        mkdir -p code
        git clone https://$USERNAME:$PASSWORD@gitlab.com/$line/assignments.git code/$line
    done
    cd ..
elif [[ $OPT -eq 2 ]]
then
    echo "Pulling mahasiswa's repository inside 'code' folder..."
    # Do git pull for each mahasiswa in each mahasiswa's folder
    cat accountmahasiswa.txt | while read line 
    do
        echo ""
        if [ -d code/$line ] 
        then
            cd code/$line
            git pull https://$USERNAME:$PASSWORD@gitlab.com/$line/assignments.git
            cd ../..
        else
            echo "$(tput setaf 1)ERROR: Directory $line does not exist.$(tput sgr 0)"
        fi
    done
    cd ..
elif [[ $OPT -eq 3 ]]
then
    echo "Pastikan folder uji kasus dari tim asisten dosen berada di folder 'testcase'!"
    # Just in case the folder is not created yet!
    mkdir -p testcase
    read -p "Masukkan nama folder tugas pemrograman (contohnya 'assignment1'): " PROJECTNAME
    read -p "Masukkan nama folder uji kasus (jangan gunakan spasi!): " TESTCASEFOLDER
    echo "Copying new testcases to each mahasiswa's repository folder..."
    # Copy testcases to each mahasiswa's folder
    cat accountmahasiswa.txt | while read line
    do
        # Make report folder
        mkdir -p report/$line/$PROJECTNAME
        if [ -d code/$line ] 
        then
            cd testcase/$TESTCASEFOLDER
            echo ""
            for testcasefile in *
            do
                echo "Copying $testcasefile to $line folder..."
                cp $testcasefile ../../code/$line/$PROJECTNAME/src/test/java/assignments/$PROJECTNAME/$testcasefile
            done
            echo ""
            echo "Testing testcases in $line folder..."
            cd ../../code/$line
            # UPDATE REV01: Fix for macOS
            chmod +x gradlew
            # The solution of the bug: https://stackoverflow.com/a/60499489
            # Output the Gradle message while saving it to report file
            ./gradlew :$PROJECTNAME:test  < /dev/null 2>&1 | tee ../../report/$line/$PROJECTNAME/output.txt
            cd ../..
        else
            echo ""
            echo "$(tput setaf 1)ERROR: Directory $line does not exist.$(tput sgr 0)"
        fi
    done
elif [[ $OPT -eq 4 ]]
then
    read -p "$(tput setaf 1)Apakah kamu yakin? (Y/N)$(tput sgr 0) " STATUS
    if [[ $STATUS == *"Y"* || $STATUS == *"y"* ]]
    then
        # Delete each mahasiswa's folder
        cat accountmahasiswa.txt | while read line 
        do
            rm -rf code/$line
        done
        echo "Penghapusan sukses."
        echo "Jangan lupa untuk menjalankan cloning kembali!"
    else
        echo "Penghapusan dibatalkan."
    fi
else
  echo "Masukan tidak valid."
fi

echo ""
echo "Terima kasih telah menggunakan skrip ini! $(tput setaf 2)Selamat mencari cuan~$(tput sgr 0)"
