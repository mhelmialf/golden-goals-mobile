# ✨ GOLDEN GOALS MOBILE VERSION ✨
## *Where Football Dreams Become Yours*

#### Name      : Muhammad Helmi Alfarissi
#### NPM       : 2406402416
#### Class     : PBP D

## Tugas 7 - PBP 2025/2026

## 🌳 Widget Tree dan Hubungan Parent-Child

**Widget Tree (Pohon Widget)**
Widget Tree adalah struktur hierarki yang menggambarkan bagaimana seluruh antarmuka pengguna (UI) di Flutter tersusun dari berbagai widget. Semua widget saling berhubungan seperti pohon keluarga: ada satu widget akar (root) yang memiliki anak (children), dan anak-anak tersebut juga dapat memiliki anak lagi.

**Analogi:** Seperti struktur HTML — `<body>` sebagai induk yang berisi `<div>`, lalu di dalamnya terdapat `<p>` dan `<img>`. Contoh struktur di Flutter:
`Scaffold -> Padding -> Column -> Row -> InfoCard`.

**Hubungan Parent-Child (Induk-Anak)**

* **Parent (Induk):** Widget yang membungkus atau berisi widget lain. Induk menentukan bagaimana anak-anaknya ditampilkan (misalnya ukuran, tata letak, dan posisi).
* **Child (Anak):** Widget yang ditempatkan di dalam induk dan memberikan informasi ukuran yang diinginkannya, tetapi tampilan akhir ditentukan oleh induknya.

Contoh: Widget `Column` sebagai induk menata anak-anaknya (`Row`, `SizedBox`, `Center`) secara vertikal.

---

## 🧾 Daftar Widget yang Digunakan dalam Proyek

### Widget Struktur & Halaman

* **Scaffold:** Kerangka dasar halaman berbasis Material Design, tempat meletakkan `AppBar`, `body`, dan komponen utama lainnya.
* **AppBar:** Bilah aplikasi di bagian atas layar yang biasanya berisi judul dan tombol aksi.

### Widget Layout (Tata Letak)

* **Padding:** Memberikan ruang kosong di sekeliling anaknya.
* **Column:** Menata widget anak secara vertikal.
* **Row:** Menata widget anak secara horizontal.
* **SizedBox:** Kotak kosong dengan ukuran tertentu, biasanya digunakan untuk memberi jarak antar widget.
* **Center:** Menempatkan widget anak tepat di tengah ruang yang tersedia.
* **GridView:** Menampilkan widget anak dalam bentuk kisi-kisi (grid) yang dapat digulir.
* **Container:** Kotak serbaguna yang bisa diatur ukuran, padding, margin, dan dekorasinya.

### Widget Tampilan & Interaktif

* **Text:** Menampilkan teks dengan gaya tertentu.
* **Icon:** Menampilkan ikon dari Material Icons.
* **Card:** Panel dengan efek bayangan dan sudut membulat.
* **Material:** Dasar dari elemen bergaya Material Design.
* **InkWell:** Menambahkan efek responsif sentuhan (ripple effect).

### Widget Fungsional & Lainnya

* **ScaffoldMessenger:** Mengelola tampilan `SnackBar`.
* **SnackBar:** Pesan sementara di bagian bawah layar.
* **MediaQuery:** Memberikan informasi tentang ukuran layar perangkat.

### Widget Kustom

* **MyHomePage, InfoCard, ItemCard:** Widget buatan sendiri yang merupakan turunan dari `StatelessWidget`.

---

## 🏠 Fungsi Widget MaterialApp

`MaterialApp` adalah widget konfigurasi tingkat atas yang menjadi akar (root) dari aplikasi Flutter berbasis Material Design.

**Fungsinya:**

1. **Theming:** Menyediakan tema global (`ThemeData`) yang dapat diakses seluruh widget.
2. **Navigation:** Mengatur sistem navigasi antar halaman (`routes`).
3. **Localization:** Menangani bahasa dan teks default aplikasi.

**Mengapa Harus di Root:**
Widget seperti `Scaffold`, `AppBar`, dan `Card` bergantung pada konteks yang disediakan oleh `MaterialApp`. Tanpa itu, widget tersebut tidak dapat bekerja dengan baik.

**Analogi:** `MaterialApp` adalah fondasi dan sistem listrik dari rumah — sebelum memasang lampu (`AppBar`) atau perabot (`Scaffold`), fondasi dan sistemnya harus siap terlebih dahulu.

---

## ⚖️ Perbedaan StatelessWidget dan StatefulWidget

### StatelessWidget

* **Definisi:** Widget yang tidak memiliki state (data internal) yang dapat berubah. Semua propertinya bersifat final.
* **Siklus Hidup:** Hanya menjalankan metode `build()` ketika pertama kali dibuat atau ketika data dari induk berubah.
* **Analogi:** Seperti poster yang sudah dicetak—kontennya tidak berubah.
* **Contoh:** `MyHomePage`, `InfoCard`, dan `ItemCard`.

### StatefulWidget

* **Definisi:** Widget yang menyimpan dan mengelola data (state) yang bisa berubah seiring waktu.
* **Struktur:** Terdiri dari dua class — `StatefulWidget` dan `State`.
* **Siklus Hidup:** Perubahan data dilakukan dengan `setState()`, yang memicu pembaruan tampilan.
* **Analogi:** Seperti papan tulis digital yang bisa diubah kapan saja.
* **Contoh Penggunaan:** Checkbox, slider, form input, atau data yang diperbarui dari API.

---

## 📍 BuildContext

`BuildContext` adalah objek yang menunjukkan posisi suatu widget di dalam **widget tree**. Setiap widget memiliki `BuildContext` sendiri yang digunakan untuk berinteraksi dengan widget di atasnya (ancestor).

**Fungsinya:**

* Mengakses data dari ancestor widget seperti `Theme`, `MediaQuery`, dan `ScaffoldMessenger`.
* Diberikan secara otomatis pada metode `build(BuildContext context)`.

**Analogi:** `BuildContext` adalah alamat rumah sebuah widget. Untuk meminta layanan seperti “antar makanan” (`SnackBar`) atau “warna tema” (`Theme`), widget perlu tahu alamatnya di pohon widget.

**Contoh:**

* `Theme.of(context).colorScheme.primary`
* `ScaffoldMessenger.of(context).showSnackBar(...)`
* `MediaQuery.of(context).size.width`

---

## ⚡ Perbedaan Hot Reload dan Hot Restart

### Hot Reload

* **Proses:** Menyuntikkan kode baru ke aplikasi yang sedang berjalan tanpa me-restart.
* **State:** Tidak hilang — posisi dan data pengguna tetap sama.
* **Analogi:** Mengecat ulang dinding rumah tanpa keluar dari rumah.

### Hot Restart

* **Proses:** Menghentikan dan memulai ulang aplikasi dari awal.
* **State:** Dihapus sepenuhnya — aplikasi kembali ke halaman awal.
* **Analogi:** Keluar dari rumah dan masuk lagi dari pintu depan.

---
