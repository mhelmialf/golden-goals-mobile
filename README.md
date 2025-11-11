# ✨ GOLDEN GOALS MOBILE VERSION ✨
## *Where Football Dreams Become Yours*

#### Name      : Muhammad Helmi Alfarissi
#### NPM       : 2406402416
#### Class     : PBP D

### History Tugas
- [**Tugas 7 - PBP 2025/2026**](https://github.com/mhelmialf/golden-goals-mobile/wiki/Tugas-7-%E2%80%90-PBP-2025-2026)

---

## Tugas 8 - PBP 2025/2026

## 🧭 Perbedaan Antara `Navigator.push()` dan `Navigator.pushReplacement()`
`Navigator.push()` dan `Navigator.pushReplacement()` adalah dua metode navigasi fundamental di Flutter, namun dengan tujuan yang sangat berbeda.

1. `Navigator.push()`
    - Cara Kerja: Metode ini menambahkan rute (halaman) baru ke atas tumpukan navigasi (navigation stack). Halaman sebelumnya tetap ada di dalam tumpukan, di bawah halaman yang baru.
    - Implikasi: Pengguna dapat menekan tombol "kembali" (baik fisik atau di AppBar) untuk kembali ke halaman sebelumnya.
    - Contoh Kasus di Golden Goals: Ini adalah metode navigasi yang paling umum digunakan.
    - Dari Halaman Utama -> klik Create Product -> push() ke Halaman form Create Product.
    - Dari Halaman Create Product -> klik Home -> push() ke Halaman Utama.
    - Pengguna dapat dengan mudah kembali dari Home -> Create Product.

2. `Navigator.pushReplacement()`
    - Cara Kerja: Metode ini mengganti rute saat ini dengan rute baru. Rute yang lama (halaman saat ini) akan dihapus dari tumpukan navigasi.
    - Implikasi: Pengguna tidak bisa kembali ke halaman yang baru saja diganti. Tombol "kembali" akan membawa mereka ke halaman sebelum halaman yang diganti.
    - Contoh Kasus di Golden Goals: Digunakan untuk alur kerja satu arah di mana kembali tidak lagi diinginkan.
    - Dari Halaman Create Product-> pushReplacement() ke Halaman Utama. (Kita tidak ingin pengguna kembali ke Create Product).

---

## 🏗️ Pemanfaatan Hierarchy Widget (Scaffold, AppBar, Drawer)
Widget Scaffold, AppBar, dan Drawer adalah fondasi untuk menciptakan struktur visual yang konsisten di seluruh aplikasi.
1. Scaffold: Ini adalah widget "kerangka" utama untuk setiap halaman. Scaffold menyediakan slot-slot standar seperti appBar, body, drawer, dan bottomNavigationBar. Dengan menggunakan Scaffold di setiap halaman, kita memastikan bahwa semua elemen berada di tempat yang seharusnya.
2. AppBar: AppBar ditempatkan di slot appBar milik Scaffold. Untuk konsistensi:
Kita bisa membuat widget AppBar kustom (misalnya MyCustomAppBar) yang selalu menampilkan logo toko dan ikon keranjang belanja. Dengan menggunakan AppBar ini di seluruh aplikasi, identitas brand dan akses ke keranjang belanja akan selalu ada di bagian atas, kecuali di halaman-halaman khusus (seperti login).
3. Drawer: Drawer (menu samping) adalah cara terbaik untuk navigasi utama yang konsisten.
Kita membuat satu widget Drawer kustom (misalnya MyNavigationDrawer) yang berisi link ke: Halaman Utama, Profil Pengguna, Riwayat Pesanan, Pengaturan, dan Logout. Widget Drawer ini kemudian di-passing ke properti drawer pada Scaffold di semua halaman utama. Hasilnya, tidak peduli pengguna ada di halaman mana, mereka selalu dapat mengakses menu navigasi yang sama persis.

---

## 📜 Kelebihan Layout Widget untuk Form (Padding, SingleChildScrollView, ListView)
Saat merancang form (misalnya untuk registrasi, login, atau checkout), widget layout ini sangat penting untuk fungsionalitas dan User Experience (UX).
1. Padding
- Kelebihan: Memberikan "ruang bernapas" (whitespace) di sekitar elemen form. Tanpa Padding, TextField atau tombol akan menempel langsung ke tepi layar atau menempel satu sama lain, membuat UI terlihat sempit, berantakan, dan tidak profesional.
- Contoh Penggunaan: Membungkus seluruh Column yang berisi TextField (Email, Password) dengan Padding(all: 16.0) agar form tidak menempel di tepi layar.

2. SingleChildScrollView
- Kelebihan: Ini adalah widget krusial untuk form. Saat pengguna mengetik di TextField, keyboard virtual akan muncul dan menutupi sebagian layar. Jika form terlalu panjang, SingleChildScrollView memastikan pengguna dapat men-scroll ke bawah untuk melihat dan mengisi semua field. Tanpa ini, pengguna mungkin tidak dapat melihat apa yang mereka ketik atau tidak dapat mengakses tombol "Submit".
- Contoh Penggunaan: Membungkus Column yang berisi Padding dan semua TextField form checkout (Nama, Alamat, No. HP, Metode Pembayaran) dengan SingleChildScrollView.

3. ListView
- Kelebihan: Mirip dengan SingleChildScrollView, ListView juga menyediakan kemampuan scrolling. Kelebihan utamanya muncul jika form bersifat dinamis (misalnya, pengguna bisa menambah banyak alamat pengiriman). Namun, untuk form statis (login/register), ListView juga sering digunakan sebagai pengganti SingleChildScrollView yang dikombinasikan dengan Column.
- Contoh Penggunaan: Menggunakan ListView untuk membungkus TextField registrasi. Ini secara otomatis memberikan kemampuan scroll dan (jika digunakan dengan benar) bisa lebih efisien dalam me-render elemen.

---

## 🎨 Menyesuaikan Warna Tema dan Identitas Visual
Untuk memastikan aplikasi Football Shop memiliki identitas visual yang konsisten, kita memanfaatkan sistem theming bawaan Flutter melalui ThemeData.
Penetapan Tema Global: Di dalam widget MaterialApp (widget root aplikasi), kita mendefinisikan properti theme.

    ```Dart
    MaterialApp(
    title: 'Golden Goals',
    theme: ThemeData(
        // Tentukan skema warna utama
        colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green, // Warna utama brand, misal hijau rumput
        primary: Colors.green[700], // Warna primer untuk tombol
        secondary: Colors.amber, // Warna aksen untuk diskon/promo
        surface: Colors.grey[100], // Warna latar belakang halaman
        ),

        // Atur tema khusus untuk AppBar
        appBarTheme: AppBarTheme(
        backgroundColor: Colors.green[700], // Samakan dengan warna primer
        foregroundColor: Colors.white, // Warna teks di AppBar (putih)
        ),

        // Atur tema untuk tombol
        elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700], // Tombol pakai warna primer
            foregroundColor: Colors.white, // Teks di tombol
        ),
        ),

        // Atur jenis font jika ada
        fontFamily: 'Poppins', 
    ),
    home: HomePage(),
    );
    ```
- Kelebihan: Dengan mendefinisikan tema di satu tempat (ThemeData), semua widget di dalam aplikasi (AppBar, ElevatedButton, FloatingActionButton, dll.) akan secara otomatis mewarisi warna dan gaya ini. Kita tidak perlu lagi mengatur warna AppBar atau tombol secara manual di setiap halaman. Ini menjamin konsistensi total dan sangat memudahkan jika suatu saat brand ingin berganti warna—kita hanya perlu mengubahnya di satu file.