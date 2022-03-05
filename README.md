# DDP 2 Script Checker

> **LAST REVISION**: `REV03 Sun 6 Mar 2022 01:13:10 WIB`

Sebuah skrip otomatis untuk _clone_, _pull_, hapus, dan menjalankan Gradle secara otomatis dari repositori mahasiswa Dasar-Dasar Pemrograman 2 (DDP 2).

Program Git wajib terinstal sebelum menjalankan skrip ini. Versi batch script dibuat untuk sistem operasi Windows, sedangkan versi shell script dibuat untuk sistem operasi *nix.

> Copyright (C) 2022 Muhammad Athallah

## CHANGELOG

### REV03
- Mengubah cara pembuatan folder report.

### REV02
- Membuat skrip versi _batch script_ untuk Windows.

### REV01
- Mengubah cara menyimpan keluaran Gradle agar bisa digunakan di macOS.
- Menambah perintah `chmod +x gradle` agar file Gradle bisa dijalankan di macOS.

### START
- Membuat skrip yang dapat digunakan untuk _clone_, _pull_, hapus, dan menjalankan Gradle secara otomatis dari repositori mahasiswa.

## Tata Cara Penggunaan

1. _Clone_ repositori ini dengan menggunakan:<br>
    ```
    git clone https://github.com/determinedguy/ddp2-script-checker
    ```
2. Isikan kredensial kamu di file `credentials.sh` (atau `credentials.sh`).
3. Jalankan program dan masukkan masukan sesuai dengan apa yang diminta.
4. Voila! Program akan menjalankan perintah (_one at a time_) sesuai dengan apa yang kamu mau.

## Struktur Direktori

Terdapat tiga file wajib, yakni:
- `accountmahasiswa.txt`, berisikan daftar akun GitLab mahasiswa.
- `credentials.sh`, berisikan kredensial akun GitLab kamu **(pastikan kamu telah memiliki akses ke repositori mahasiswa)**.
- `script.sh`, berisikan program skrip DDP 2.

Tiga folder baru akan dibuat (satu folder harus dibuat dari awal), yakni:
- `code`, berisikan kode dari repositori mahasiswa.
- `testcase`, berisikan uji kasus dari tim asisten dosen **(pastikan kamu telah mengunduh uji kasus (testcase) dari tim asisten dosen dan menaruhnya di dalam folder tersebut)**.
- `report`, berisikan hasil pemeriksaan Gradle dari setiap mahasiswa.

## Lisensi

Kode skrip ini memiliki lisensi [AGPL-3.0 License](LICENSE).
 
