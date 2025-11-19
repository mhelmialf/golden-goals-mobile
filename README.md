# ✨ GOLDEN GOALS MOBILE VERSION ✨
## *Where Football Dreams Become Yours*

#### Name      : Muhammad Helmi Alfarissi
#### NPM       : 2406402416
#### Class     : PBP D

### History Tugas
- [**Tugas 7 - PBP 2025/2026**](https://github.com/mhelmialf/golden-goals-mobile/wiki/Tugas-7-%E2%80%90-PBP-2025-2026)
- [**Tugas 8 - PBP 2025/2026**](https://github.com/mhelmialf/golden-goals-mobile/wiki/Tugas-8-%E2%80%90-PBP-2025-2026)

---

## Tugas 9 - PBP 2025/2026

## 🧭 Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model (terkait validasi tipe, null-safety, maintainability)?

Membuat model Dart (seperti kelas `Product`) sangat penting dalam pengembangan Flutter/Dart yang terhubung dengan API, terutama saat berurusan dengan data JSON. Model bertindak sebagai kontrak data yang mendefinisikan struktur dan tipe data yang diharapkan dari backend. Tanpa model eksplisit, kita hanya akan menerima data dalam bentuk `Map<String, dynamic>` atau `dynamic`.

Konsekuensinya jika kita langsung menggunakan `Map<String, dynamic>` (atau `dynamic`):

- **Validasi Tipe (Type Safety) & Null-Safety**: Dart adalah bahasa yang secara default null-safe. Jika kita menggunakan `Map<String, dynamic>`, compiler tidak dapat menjamin bahwa kunci ('price', 'stock', dll.) itu ada, atau bahwa nilainya memiliki tipe data yang benar (int, String, DateTime). Setiap kali kita mengakses data (misalnya data['price'] as int), kita harus selalu menggunakan as atau tryParse yang rentan terhadap runtime error jika data dari server berubah atau hilang.

- **Maintainability & Keterbacaan**: Mengakses properti melalui string literal (data['product_name']) sangat rentan terhadap kesalahan ketik (typo) dan sulit di-refactor. Model (seperti product.productName) membuat kode lebih mudah dibaca, lebih bersih, dan memungkinkan IDE mendeteksi kesalahan lebih awal (compile-time error) daripada runtime.

- **Otomatisasi & Serialisasi**: Model memungkinkan penggunaan library seperti json_serializable atau membuat metode fromJson secara eksplisit, yang mengubah data mentah JSON menjadi objek Dart yang dapat digunakan dengan mudah di seluruh UI.

---

## 🏗️ Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.

Dalam proyek ini, kedua package tersebut memiliki peran berbeda dalam menangani komunikasi jaringan:

- **`http` (Package HTTP Standar)**: Fungsi utamanya adalah menyediakan dasar-dasar untuk melakukan HTTP request (GET, POST, PUT, DELETE) di Flutter. Ini adalah cara umum untuk berkomunikasi dengan API. Namun, http tidak memiliki fitur bawaan untuk menangani Cookies, Session, atau CSRF Token secara otomatis.

- **`CookieRequest` (Package `pbp_django_auth`)**: CookieRequest adalah wrapper atau perpanjangan dari klien HTTP standar yang khusus dibuat untuk bekerja dengan otentikasi Django.
    - Peran `CookieRequest`: Secara otomatis mengelola Session Cookies. Setiap kali request berhasil dari Django (termasuk login), ia menangkap session cookie dan menyimpannya. Untuk setiap request berikutnya (misalnya mengambil daftar produk, membuat produk), CookieRequest secara otomatis menyertakan kembali cookie tersebut di header permintaan. Ini sangat penting untuk menjaga sesi pengguna agar Django tahu siapa yang sedang terautentikasi (`request.user`).

**Perbedaan Peran:** 
| Fitur | http (Standar) | CookieRequest | 
| :--- | :--- | :--- | 
| Fungsi Dasar | Melakukan request mentah (GET/POST). | Melakukan request dan mengelola sesi. | 
| Otentikasi | Manual. Pengembang harus mengambil, menyimpan, dan melampirkan cookie/token sendiri. | Otomatis. Mengelola, menyimpan, dan melampirkan session cookie ke setiap permintaan. | 
| Penggunaan | Untuk API publik atau API yang tidak memerlukan session. | Untuk API yang dilindungi oleh sistem otentikasi berbasis session seperti Django. |

---

## 📜 Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

Instance CookieRequest perlu dibagikan ke semua komponen aplikasi Flutter karena alasan utama: Konsistensi dan Persistensi Sesi.

1. **Menjaga Sesi (Session Persistence)**: Setelah pengguna login, CookieRequest menyimpan data sesi (cookie) yang membuktikan bahwa pengguna tersebut telah terotentikasi. Jika instance `CookieRequest` tidak dibagikan (misalnya, membuat instance baru di setiap widget), cookie tersebut akan hilang. Akibatnya, setiap request baru (misalnya, dari halaman List Product) akan dianggap sebagai pengguna anonim, dan Django akan menolak akses atau mengembalikan redirect ke halaman login.

2. **Akses Global (Global Access)**: Dengan membagikannya menggunakan Provider (seperti yang dilakukan di main.dart), setiap widget (baik itu `ProductFormPage`, `ProductEntryListPage`, maupun `LeftDrawer`) dapat dengan mudah mengakses satu sumber kebenaran (satu objek request) yang selalu membawa session cookie yang valid. Ini memastikan setiap interaksi dengan backend adalah interaksi yang terautentikasi.

---

## 🎨 Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?

Komunikasi antara Flutter dan Django membutuhkan konfigurasi konektivitas yang tepat di sisi frontend dan backend, terutama karena adanya perbedaan asal (origin) dan kebutuhan sesi.

**Konfigurasi Penting:**
| Konfigurasi | Lokasi & Tujuan | Mengapa Diperlukan? | 
| :--- | :--- | :--- | 
| `10.0.2.2` pada `ALLOWED_HOSTS` | Django (`settings.py`) | Ketika aplikasi Flutter dijalankan di Android Emulator, alamat localhost di emulator akan merujuk ke dirinya sendiri. Alamat `10.0.2.2` adalah alamat IP khusus yang diarahkan ke host machine (tempat Django server berjalan). Tanpa ini, Django akan menolak permintaan dari emulator. | 
| Mengaktifkan CORS | Django (`settings.py`) | Diperlukan jika Flutter dijalankan di Web (browser). CORS mencegah browser memblokir permintaan dari satu origin (misal Flutter Web di port 65172) ke origin lain (Django di port 8000 atau domain PBP). Konfigurasi `CORS_ALLOW_ALL_ORIGINS = True` memberikan izin akses ini. | 
| Pengaturan SameSite/Cookie | Django (settings.py) | Terkait keamanan cookie. Jika `CSRF_COOKIE_SAMESITE` atau `SESSION_COOKIE_SAMESITE` disetel terlalu ketat (Strict), browser modern (terutama Chrome) akan menolak mengirimkan cookie sesi, sehingga sesi login di Flutter akan gagal. Umumnya disetel ke Lax atau diabaikan agar cookie dapat ditransmisikan. |
| Izin Akses Internet | Flutter Android (`AndroidManifest.xml`) | Aplikasi Android perlu izin eksplisit untuk menggunakan jaringan. Tanpa baris `<uses-permission android:name="android.permission.INTERNET" />`, aplikasi tidak akan diizinkan membuat request HTTP, dan semua komunikasi akan gagal. |

**Konsekuensi Kegagalan Konfigurasi:**
| Kegagalan | Konsekuensi yang Terjadi |
| :--- | :--- |
| Lupa `10.0.2.2` | Connection Refused atau SocketException saat menjalankan di Android Emulator. |
| Lupa CORS | Request gagal di Flutter Web dengan error Access-Control-Allow-Origin atau Blocked by CORS Policy. |
| Lupa Izin Internet | SocketException atau error izin di Android, tombol tidak berfungsi sama sekali. |
| SameSite Salah | Login terlihat berhasil di server (log 200 OK), tetapi cookie tidak tersimpan/terkirim ke Flutter, sehingga user tetap dianggap anonim. |

---

## 📜 Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.

Mekanisme pengiriman dan pengambilan data, mulai dari pengguna memasukkan data hingga data tersebut ditampilkan kembali di list produk, melibatkan alur berikut:

1. Input Data (Frontend): Pengguna mengisi form di ProductFormPage. Data (`_name`, `_price`, `_description`, dll.) dikumpulkan dan disimpan dalam state widget.

2. Validasi & Serialisasi (Frontend): Saat tombol "Save" diklik, form divalidasi. Data dari state diserialisasi menjadi format JSON menggunakan jsonEncode(...). Data ini juga menyertakan `product.user` secara implisit karena `CookieRequest` akan mengirim Cookie Session pengguna.

3. Pengiriman Request (Frontend): Objek request (instance dari CookieRequest) digunakan untuk mengirim request POST ke endpoint Django (`/create-flutter/`).

4. Penerimaan & Validasi (Backend): Fungsi Django (`create_product_flutter`) menerima request POST. Data JSON di-deserialisasi (`json.loads(request.body)`), divalidasi (misal, price harus integer), dan divalidasi otentikasinya (`request.user` harus valid).

5. Penyimpanan Data (Backend): Data digunakan untuk membuat instance model Product baru, dan disimpan ke database (PostgreSQL/SQLite). Backend merespons dengan `JSON {"status": "success"}`.

6. Refresh List (Frontend): Setelah Flutter menerima respons sukses:
    - Pengguna dinavigasi ke `ProductEntryListPage`.
    - Halaman ini memanggil fungsi `fetchProduct` yang melakukan request GET ke `/json/`.

7. Pengambilan Data (Backend): Fungsi Django `show_json` mengambil semua data Product dari database, termasuk username dari relasi user, dan mengirimkannya kembali dalam format JSON.

8. Deserialisasi & Tampilan (Frontend): Flutter menerima JSON list produk. Data JSON tersebut di-deserialisasi dan diubah menjadi objek `List<Product>` menggunakan metode `Product.fromJson`. Objek list inilah yang kemudian ditampilkan di widget `ListView.builder` menggunakan `ProductEntryCard`.

---

## 📜 Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Mekanisme otentikasi dan manajemen sesi dalam proyek ini sepenuhnya mengandalkan sistem session-based authentication bawaan Django, yang di-handle di Flutter oleh `CookieRequest`.

1. **Registrasi (Register)**
    1. Input: Pengguna memasukkan data di form Register (Flutter).
    2. Pengiriman: Flutter mengirim request POST (tanpa cookie sesi) ke endpoint Django `/register/`.
    3. Validasi Backend: Fungsi register di Django memvalidasi form `UserCreationForm`.
    4. Penyimpanan: Jika valid, data disimpan ke tabel `auth_user` Django.
    5. Respon: Django merespons dengan `JSON {"status": "success"}`. Flutter menampilkan snackbar sukses.

2. **Login**
    1. Input: Pengguna memasukkan username dan password di form Login (Flutter).
    2. Pengiriman: Flutter mengirim request POST ke endpoint Django `/auth/login/`.
    3. Otentikasi Backend:
        - Fungsi `login_user` di Django menggunakan `AuthenticationForm` untuk memverifikasi kredensial.
        - Jika berhasil, fungsi login(request, user) dipanggil, yang membuat session baru di database dan menetapkan sessionid serta csrftoken ke header respon.
    4. Penyimpanan Session (Flutter): CookieRequest di Flutter secara otomatis menangkap dan menyimpan sessionid dan csrftoken yang dikirim Django.
    5. Akses Identitas: Django merespons dengan JSON yang juga menyertakan user.id dan user.username. Flutter menangkap data ini dan menyimpannya di `UserSession` (atau Provider) untuk filter di frontend.
    6. Transisi UI: Flutter menjalankan Navigator.pushReplacement ke `MyHomePage`. Pengguna dianggap terautentikasi.

3. **Akses Terautentikasi (Setiap Request)**
    1. Setiap kali Flutter memanggil request.get(...) (misal untuk `fetchProduct`), `CookieRequest` secara otomatis melampirkan sessionid yang tersimpan tadi ke header request.
    2. Django menerima request tersebut, memeriksa cookie, dan menetapkan request.user sebagai instance pengguna yang valid, bukan AnonymousUser.

4. **Logout**
    1. Aksi: Pengguna menekan tombol Logout (Flutter).
    2. Pengiriman: Flutter memanggil `request.logout()` ke endpoint Django `/auth/logout/`.
    3. Penghapusan Session (Backend): Fungsi `logout_user` di Django memanggil logout(request), yang menghancurkan sesi di database server.
    4. Pembersihan Cookie (Flutter): CookieRequest menghapus cookie yang tersimpan. Flutter menjalankan UserSession.clearSession().
    5. Transisi UI: Flutter menavigasi ke LoginPage.

---

## 📜 Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

Implementasi fokus pada integrasi Data Model, Otentikasi Berbasis Session, dan Logika Filter Frontend yang dinamis.

1. **Persiapan Django Backend (Data Model & JSON Endpoint)**
    1. Update Model JSON: Fungsi `show_json` di views.py dimodifikasi menggunakan `Product.objects.select_related('user').all()` untuk menghindari N+1 query. JSON Response diubah untuk menyertakan username (`'username': product.user.username`) selain user_id, agar Flutter bisa menampilkan nama creator produk.
    2. URL Flutter-Specific: Endpoint `create-flutter/` dibuat, menggunakan `@csrf_exempt` dan memanggil request.user untuk menetapkan pemilik produk.
    3. Login Response: Fungsi login_user di Django dimodifikasi untuk menyertakan id user dalam response JSON, yang krusial untuk filter dinamis di frontend.

2. **Konfigurasi Flutter untuk Konektivitas**
    1. Dependency: Package `pbp_django_auth` (untuk CookieRequest) ditambahkan ke pubspec.yaml.
    2. Provider Setup: `CookieRequest` didaftarkan di `main.dart` sebagai Provider untuk akses global, memastikan sesi tetap utuh di seluruh komponen.

3. **Manajemen Identitas (UserSession)**
    1. Global Session: Class `UserSession` (static/singleton) dibuat untuk menyimpan User ID dan Username setelah login.
    2. Login Logic: Di login.dart, setelah request.login sukses, data response['id'] dan response['username'] diambil dan disimpan ke UserSession.userId dan UserSession.username.
    3. Logout Logic: Di LeftDrawer (tombol Logout), request.logout dipanggil, dan `UserSession.clearSession()` dipanggil setelahnya untuk menghapus identitas user dari memori.

4. **Implementasi Tampilan Produk (List dan Detail)**
    1. Model Dart Update: Kelas Product di `product.dart` ditambahkan field username (String) dan dimodifikasi metode fromJson untuk memetakan data username dari JSON backend.
    2. Product List Page (`ProductEntryListPage`):
        - Struktur Scaffold diubah menjadi Column agar tombol filter bisa diletakkan di bagian atas.
        - Filter Logic (Frontend): Di dalam FutureBuilder, semua data produk (allProducts) diambil. Filtering dilakukan menggunakan:
        ```dart
        if (!_showAllProducts) {
            displayedProducts = allProducts.where((p) => p.username == UserSession.username).toList();
        }
        ```
        Logika ini menggunakan username dari sesi, sesuai permintaan untuk frontend-filtering yang dinamis.
    3. Product Detail Page (`ProductDetailPage`):
        - Tampilan Creator: Widget Row ditambahkan di halaman detail untuk menampilkan product.username, memastikan nama creator muncul dan bukan hanya ID.

5. **Implementasi Navigasi Dinamis**
    1. ProductEntryListPage Constructor: Di-update untuk menerima parameter filterUserProductsOnly. 
    Nilai ini digunakan di initState untuk menentukan nilai awal `_showAllProducts` (misal, `_showAllProducts = !widget.filterUserProductsOnly`).
    2. Homepage Navigation (ItemCard): Logic onTap di ItemCard diatur untuk mengirim parameter filter yang sesuai saat menuju list produk:
        - "All Products" $\rightarrow$ `ProductEntryListPage(filterUserProductsOnly: false)`
        - "My Products" $\rightarrow$ `ProductEntryListPage(filterUserProductsOnly: true)`

---

