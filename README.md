# DDP 2 Script Checker

> **LAST REVISION**: `REV06 Sun 10 Apr 2022 00:00:00 WIB`

Sebuah skrip otomatis untuk _clone_, _pull_, menghapus file kode, dan menjalankan Gradle secara otomatis dari repositori mahasiswa Dasar-Dasar Pemrograman 2 (DDP 2).

Program Git wajib terinstal sebelum menjalankan skrip ini. Versi _batch script_ (\*.bat) dibuat untuk sistem operasi Windows, sedangkan versi _shell script_ (\*.sh) dibuat untuk sistem operasi *nix.

> Copyright (C) 2022 Muhammad Athallah

## CHANGELOG

### REV06
- Menambah dukungan untuk uji kasus berbasis teks (_text-based testcases_) pada versi _shell script_.

### REV05
- Mengganti mekanisme penyalinan file pada Windows dari `copy` dengan `xcopy`.

### REV04
- Menambahkan peringatan untuk menggunakan _double percentage symbol_ pada file `credentials.bat`.

### REV03
- Mengubah cara pembuatan folder `report`.

### REV02
- Membuat skrip versi _batch script_ untuk Windows.

### REV01
- Mengubah cara menyimpan keluaran Gradle agar bisa digunakan di macOS.
- Menambah perintah `chmod +x gradle` agar file Gradle bisa dijalankan di macOS.

### START
- Membuat skrip _shell script_ yang dapat digunakan untuk _clone_, _pull_, menghapus file kode, dan menjalankan Gradle secara otomatis dari repositori mahasiswa.

## Tata Cara Penggunaan

1. _Clone_ repositori ini dengan menggunakan:<br>
    ```
    git clone https://github.com/determinedguy/ddp2-script-checker
    ```
2. Isikan kredensial kamu di file `credentials.sh` (atau `credentials.bat`).
    - Apabila kata sandimu mengandung simbol atau karakter khusus, harap dikonversi dengan mengacu kepada URL Encoding Format.<br> Kamu dapat membaca [HTML URL Encoding Reference](https://www.w3schools.com/tags/ref_urlencode.asp) sebagai referensi.
    - Apabila kamu pengguna Windows, kamu harus menambahkan simbol persen (`%`) sebelum mengetikkan simbol atau karakter khusus yang telah dikonversi mengikuti URL Encoding Format.
3. Jalankan program dan masukkan masukan sesuai dengan apa yang diminta.
4. Voila! Program akan menjalankan perintah (_one at a time_) sesuai dengan apa yang kamu mau.

## Struktur Direktori

Terdapat tiga file wajib, yakni:
- `accountmahasiswa.txt`, berisikan daftar akun GitLab mahasiswa.
- `credentials.sh` (atau `credentials.bat`), berisikan kredensial akun GitLab kamu **(pastikan kamu telah memiliki akses ke repositori mahasiswa)**.
- `script.sh` (atau `script.bat`), berisikan program skrip DDP 2 Checker.

Tiga folder baru akan dibuat (satu folder harus dibuat dari awal), yakni:
- `code`, berisikan kode dari repositori mahasiswa.
- `testcase`, berisikan uji kasus dari tim asisten dosen **(pastikan kamu telah mengunduh uji kasus _(testcase)_ dari tim asisten dosen dan menaruhnya di dalam folder tersebut)**.
- `report`, berisikan hasil pemeriksaan Gradle dari setiap mahasiswa.

## Lisensi

Kode skrip ini memiliki lisensi [AGPL-3.0 License](LICENSE).
 
