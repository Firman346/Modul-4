# Laporan Praktikum Modul 04: Future & REST API Dasar

## Identitas

* **Nama:** Yudista Aprilio Rami Firmansyah
* **NIM:** 362558302045
* **Kelas / Prodi:** 2C / Sarjana Terapan TRPL
* **Mata Kuliah:** Pemrograman Perangkat Bergerak

---

## Judul Praktikum

**Future & REST API Dasar — Portal Pengumuman TRPL**

---

## 1. Tujuan Praktikum

Praktikum Modul 04 bertujuan untuk memahami dasar pengambilan data dari REST API menggunakan Flutter dengan konsep asynchronous programming.

Tujuan yang dicapai dalam praktikum ini meliputi:

1. Memahami penggunaan `Future` pada Flutter.
2. Menggunakan `FutureBuilder` untuk menangani proses asynchronous.
3. Mengambil data dari REST API menggunakan package `http`.
4. Melakukan parsing JSON ke dalam model Dart.
5. Menampilkan data hasil REST API ke dalam aplikasi.
6. Membuat filter kategori secara lokal tanpa melakukan request baru ke server.
7. Membuat halaman detail pengumuman.
8. Menangani kondisi loading, error, empty, dan success.
9. Menerapkan fitur retry dan pull-to-refresh.
10. Mengelola `http.Client` dengan benar dan menutupnya ketika widget dihapus.

---

## 2. Deskripsi Aplikasi

Aplikasi yang dibuat adalah **Portal Pengumuman TRPL**, yaitu aplikasi Flutter sederhana untuk menampilkan daftar pengumuman mahasiswa.

Data pengumuman diperoleh dari REST API:

```text
https://jsonplaceholder.typicode.com/posts?_limit=10
```

Data dari API kemudian dipetakan ke dalam model `Announcement` dan ditampilkan dalam bentuk daftar kartu.

Aplikasi terdiri dari dua halaman utama:

* **Halaman Daftar Pengumuman**
* **Halaman Detail Pengumuman**

---

## 3. Teknologi yang Digunakan

* Flutter
* Dart
* Material 3
* REST API
* JSON
* Package `http`
* JSONPlaceholder
* VS Code

---

## 4. Struktur Data

Data dari REST API dipetakan ke model `Announcement`.

Model memiliki beberapa atribut:

| Atribut     | Tipe     | Keterangan          |
| ----------- | -------- | ------------------- |
| `id`        | `int`    | ID pengumuman       |
| `title`     | `String` | Judul pengumuman    |
| `content`   | `String` | Isi pengumuman      |
| `author`    | `String` | Penulis pengumuman  |
| `category`  | `String` | Kategori pengumuman |
| `date`      | `String` | Tanggal pengumuman  |
| `readCount` | `int`    | Jumlah pembaca      |

---

## 5. Implementasi Future

Pengambilan data REST API dilakukan menggunakan `Future`.

Method utama yang digunakan adalah:

```dart
Future<List<Announcement>> ambilPengumuman()
```

Method tersebut melakukan request HTTP menggunakan package `http`, kemudian:

1. Mengirim request GET ke REST API.
2. Menunggu response menggunakan `Future`.
3. Memeriksa status response.
4. Melakukan parsing JSON.
5. Memetakan data JSON menjadi objek `Announcement`.
6. Mengembalikan daftar pengumuman.

Pada praktikum ini digunakan timeout untuk menghindari aplikasi menunggu response terlalu lama.

---

## 6. Implementasi FutureBuilder

`FutureBuilder` digunakan pada halaman daftar pengumuman untuk menangani empat kondisi utama:

### 6.1 Loading

Ketika data masih dalam proses diambil dari server, aplikasi menampilkan:

* `CircularProgressIndicator`
* teks **"Sedang memuat pengumuman..."**

### 6.2 Error

Apabila request gagal, aplikasi menampilkan:

* ikon koneksi gagal
* pesan kesalahan
* tombol **Coba Lagi**

Tombol **Coba Lagi** akan membuat request baru ke API.

### 6.3 Empty

Apabila hasil filter tidak memiliki data, aplikasi menampilkan:

* ikon inbox
* pesan bahwa belum ada pengumuman pada kategori yang dipilih.

### 6.4 Success

Apabila data berhasil diperoleh, daftar pengumuman ditampilkan menggunakan `ListView`.

---

## 7. Filter Kategori

Aplikasi menyediakan filter kategori:

* Semua
* Akademik
* Beasiswa
* Kegiatan
* Prestasi

Filter dilakukan **secara lokal di sisi aplikasi** menggunakan data yang sudah diperoleh dari REST API.

Contoh proses filtering:

```dart
final tampil = _kategoriTerpilih == 'Semua'
    ? data
    : data
        .where(
          (announcement) =>
              announcement.category == _kategoriTerpilih,
        )
        .toList();
```

Dengan demikian, ketika pengguna mengganti kategori, aplikasi **tidak melakukan request API baru**.

---

## 8. Navigasi Detail

Setiap kartu pengumuman dapat ditekan untuk membuka halaman detail.

Halaman detail menampilkan:

* Kategori
* Judul
* Penulis
* Tanggal
* Jumlah pembaca
* Isi pengumuman

Data pengumuman dikirim langsung dari halaman daftar ke halaman detail menggunakan object `Announcement`.

---

## 9. Retry dan Pull-to-Refresh

Aplikasi menyediakan dua mekanisme untuk mengambil kembali data.

### Retry

Pada kondisi error tersedia tombol:

**Coba Lagi**

Tombol tersebut akan memanggil kembali method:

```dart
_api.ambilPengumuman()
```

### Pull-to-Refresh

Pada kondisi success, pengguna dapat melakukan swipe dari atas ke bawah untuk melakukan refresh data menggunakan `RefreshIndicator`.

Selain itu, tersedia tombol refresh pada `AppBar`.

---

# 10. Bukti Hasil Running

## 10.1 Kondisi Loading

Pada saat aplikasi pertama kali mengambil data, ditampilkan indikator loading dan informasi bahwa data sedang dimuat.

![Loading - Portal Pengumuman TRPL](images/Loading.png)

---

## 10.2 Kondisi Error

Ketika terjadi kegagalan koneksi atau server tidak dapat diakses, aplikasi menampilkan halaman error beserta tombol **Coba Lagi**.

![Gagal - Portal Pengumuman TRPL](images/Gagal.png)

---

## 10.3 Kondisi Empty

Ketika kategori yang dipilih tidak memiliki data, aplikasi menampilkan kondisi empty dengan ikon inbox dan pesan bahwa belum terdapat pengumuman.

![Kosong - Portal Pengumuman TRPL](images/Kosong.png)

---

## 10.4 Kondisi Success

Ketika data berhasil diperoleh dari REST API, aplikasi menampilkan daftar 10 pengumuman TRPL.

![Berhasil - Portal Pengumuman TRPL](images/Berhasil.png)

---

# 11. Struktur Folder

Struktur project Modul 04:

```text
C:\flutter\modul
│
├── README.md
│
├── images
│   ├── 1.png
│   ├── 2.png
│   ├── Berhasil.png
│   ├── Gagal.png
│   ├── Kosong.png
│   └── Loading.png
│
├── lib
│   └── modul_04
│       ├── main.dart
│       ├── app.dart
│       │
│       ├── models
│       │   └── announcement.dart
│       │
│       ├── services
│       │   └── announcement_api.dart
│       │
│       ├── screens
│       │   ├── announcement_list_screen.dart
│       │   └── announcement_detail_screen.dart
│       │
│       └── widgets
│           └── announcement_card.dart
│
└── test
    └── modul_04_test.dart
```

---

# 12. Cara Menjalankan Aplikasi

Pastikan berada pada folder project:

```powershell
cd C:\flutter\modul
```

Kemudian jalankan aplikasi Modul 04:

```powershell
flutter run -d chrome -t lib/modul_04/main.dart
```

---

# 13. Mode Simulasi Loading

Untuk membuktikan kondisi loading secara lebih mudah digunakan mode simulasi:

```powershell
flutter run -d chrome -t lib/modul_04/main.dart --dart-define=SIMULASI=true
```

Mode simulasi memberikan jeda selama satu detik sehingga indikator loading dapat terlihat dengan jelas.

Mode simulasi hanya digunakan untuk kebutuhan pembuktian kondisi loading dan tidak mengubah implementasi utama REST API.

---

# 14. Pengujian

Pemeriksaan analyzer:

```powershell
flutter analyze
```

Pengujian Modul 04:

```powershell
flutter test test/modul_04_test.dart
```

Aplikasi diharapkan tidak memiliki error pada analyzer dan seluruh test Modul 04 berhasil dijalankan.

---

# 15. Pengelolaan HTTP Client

Aplikasi menggunakan:

```dart
http.Client
```

Client dibuat pada service `AnnouncementApi`.

Apabila client dibuat oleh `AnnouncementApi`, client akan ditutup melalui method:

```dart
void tutup()
```

Method tersebut dipanggil pada `dispose()` halaman:

```dart
@override
void dispose() {
  _api.tutup();
  super.dispose();
}
```

Hal ini dilakukan agar resource HTTP client tidak tetap terbuka setelah halaman tidak digunakan.

---

# 16. Batasan Fase A

Praktikum ini merupakan implementasi **Fase A**.

Pada Fase A digunakan:

* `Future`
* `FutureBuilder`
* `http.Client`
* REST API
* Model Dart
* Local filtering
* Navigation
* Retry
* Pull-to-refresh

Teknologi berikut **belum digunakan pada Fase A** karena akan dibahas pada fase berikutnya:

* Dio
* Repository Pattern
* Riverpod
* `ProviderScope`

Dengan demikian implementasi tetap mengikuti ruang lingkup Fase A praktikum.

---

# 17. Kesimpulan

Pada Modul 04 telah dibuat aplikasi **Portal Pengumuman TRPL** menggunakan Flutter yang mengambil data dari REST API.

Implementasi yang telah dilakukan mencakup penggunaan `Future`, `FutureBuilder`, package `http`, parsing JSON ke model Dart, filtering data secara lokal, navigasi halaman detail, retry, pull-to-refresh, serta penanganan kondisi loading, error, empty, dan success.

Melalui praktikum ini, konsep dasar komunikasi aplikasi Flutter dengan REST API dan pengelolaan proses asynchronous dapat diterapkan secara langsung dalam sebuah aplikasi sederhana.
