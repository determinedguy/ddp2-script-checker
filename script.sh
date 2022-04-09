#!/bin/bash
# Copyright (C) 2022 Muhammad Athallah

# This free document is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# REV06 Sun 10 Apr 2022 00:00:00 WIB
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
    read -p "Masukkan jenis uji kasus (Masukkan 1 untuk Java-based testcase, 2 untuk text-based testcase): " MODE
    read -p "Masukkan nama folder tugas pemrograman (contohnya 'assignment1'): " PROJECTNAME
    read -p "Masukkan nama folder uji kasus (jangan gunakan spasi!): " TESTCASEFOLDER
    if [[ $MODE -eq 1 ]]
    then
        echo "Copying new testcases to each mahasiswa's repository folder..."
        # Copy testcases to each mahasiswa's folder
        cat accountmahasiswa.txt | while read line
        do
            if [ -d code/$line ] 
            then
                # Make report folder
                mkdir -p report/$line/$PROJECTNAME
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
                echo "Done testing testcases in $line folder."
            else
                echo ""
                echo "$(tput setaf 1)ERROR: Directory $line does not exist.$(tput sgr 0)"
            fi
        done
    elif [[ $MODE -eq 2 ]]
    then
        # read -p "Masukkan nama main class dari $PROJECTNAME: " MAINCLASSFILE
        echo "Copying new testcases to each mahasiswa's repository folder..."
        # Copy testcases to each mahasiswa's folder
        cat accountmahasiswa.txt | while read line
        do
            if [ -d code/$line ] 
            then
                # Make report folder
                mkdir -p report/$line/$PROJECTNAME
                # Make testcase folder for in-out from TA
                mkdir -p code/$line/$PROJECTNAME/testcases/in-out-asdos
                mkdir -p code/$line/$PROJECTNAME/testcases/out-expected-asdos
                mkdir -p code/$line/$PROJECTNAME/testcases/diff
                cd testcase/$TESTCASEFOLDER
                echo ""
                for testcasefile in *
                do
                    echo "Copying $testcasefile to $line folder..."
                    cp $testcasefile ../../code/$line/$PROJECTNAME/testcases/in-out-asdos/$testcasefile
                done
                echo ""
                echo "Testing testcases in $line folder..."
                echo ""
                cd ../../code/$line
                # Solve issue for macOS
                chmod +x gradlew
                # Count testcase file
                TESTCASEAMTRAW=`ls $PROJECTNAME/testcases/in-out-asdos | wc -l`
                TESTCASEAMT=$((TESTCASEAMTRAW / 2))
                # Run main class, input the testcase, and store the output to the output file
                for (( i=1; i<=$TESTCASEAMT; i++ ))
                do
                    ./gradlew -q :$PROJECTNAME:run < $PROJECTNAME/testcases/in-out-asdos/in$i.txt | tee $PROJECTNAME/testcases/out-expected-asdos/out$i.txt  >> /dev/null
                    echo "Perbedaan yang ada pada uji kasus ke-$i:"
                    diff -s --strip-trailing-cr $PROJECTNAME/testcases/in-out-asdos/out$i.txt $PROJECTNAME/testcases/out-expected-asdos/out$i.txt | tee $PROJECTNAME/testcases/diff/out$i.txt
                    echo ""
                done
                cd ../..
                echo "$(tput setaf 2)Done testing testcases in $line folder.$(tput sgr 0)"
            else
                echo ""
                echo "$(tput setaf 1)ERROR: Directory $line does not exist.$(tput sgr 0)"
            fi
        done
    else
        echo "Masukan mode jenis uji kasus tidak valid."
    fi
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
