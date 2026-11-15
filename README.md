# PBP - Portfolio Mobile

### 👤 Student Information

| Information    | Details                                                                               |
| -------------- | ------------------------------------------------------------------------------------- |
| **Name**       | Muh. Alfi Rizqy                                                                       |
| **NPM**        | 2506550721                                                                            |
| **Class**      | PBP F                                                                                 |

---

## 📌 Progress Status

| Task                  | Status |
| --------------------- | :----: |
| Tutorial 8            |    ✅  |
| Individual Assignment 7            |    ✅  |



---


## Pertanyaan Reflektif

### 1. Widget Tree dan Hubungan Parent-Child
Di Flutter hampir semua yang tampil merupakan widget. Widget disusun  bersarang sehingga membentuk pohon, itulah yang dinamakan Widget Tree. Widget yang membungkus Widget lain disebut parent, parent yang memili 1 anak disebut child, sedangkan parent yang memiliki banyak anak disebut children: […]. Untuk bagaimana bekerja antar-widget, parent memberikan aturan ke anak, anak sendiri juga dapat memilih aturan yang hanya berlaku di anak dan anak dari anak tersebut. Aturan parent dapat memengaruhi anak, tapi aturan anak tidak dapat memengaruhi parent.

### 2. Widget yang dipakai pada proyek ini:

| No | Widget | Fungsi |
|---|---|---|
| 1 | `MaterialApp` | Root aplikasi. Menyiapkan tema (`theme`), judul, dan halaman awal (`home`) bergaya Material Design. |
| 2 | `Scaffold` | Kerangka dasar halaman. Menyediakan `appBar`, `body`, dan `backgroundColor`. |
| 3 | `AppBar` | Bar judul di bagian atas halaman, berisi teks "MyPortfolio". |
| 4 | `Text` | Menampilkan teks (judul section, isi `InfoCard`, nama tombol). |
| 5 | `TextStyle` | Mengatur gaya teks: ketebalan, ukuran, dan warna. |
| 6 | `Icon` | Menampilkan ikon pada tombol menu (`ItemCard`). |
| 7 | `Card` | Kotak dengan bayangan dan sudut membulat, dipakai pada `InfoCard`. |
| 8 | `Material` | Permukaan Material yang dapat diberi warna dan bentuk, dipakai sebagai latar `ItemCard`. |
| 9 | `Container` | Kotak serbaguna untuk memberi padding, lebar, atau dekorasi pada anaknya. |
| 10 | `Column` | Menyusun widget secara vertikal (atas ke bawah). |
| 11 | `Row` | Menyusun widget secara horizontal (kiri ke kanan). |
| 12 | `Padding` | Memberi jarak di sekeliling widget anak. |
| 13 | `Center` | Menempatkan anak di tengah ruang yang tersedia. |
| 14 | `Align` | Menempatkan anak pada posisi tertentu, misalnya rata kiri. |
| 15 | `Expanded` | Membuat anak mengisi sisa ruang di dalam `Row` atau `Column`, sehingga lebar dibagi rata. |
| 16 | `IntrinsicHeight` | Menyamakan tinggi semua anak dengan tinggi anak yang paling tinggi, dipakai agar ketiga `InfoCard` sama tinggi. |
| 17 | `SizedBox` | Kotak kosong berukuran tetap, dipakai sebagai jarak antar widget. |
| 18 | `GridView.count` | Menampilkan item dalam susunan grid dengan jumlah kolom tetap (2 kolom per section). |
| 19 | `InkWell` | Membuat widget dapat disentuh dan memberi efek ripple saat ditekan. |
| 20 | `ElevatedButton` | Tombol dengan bayangan (tombol Logout). |
| 21 | `RoundedRectangleBorder` | Bentuk sudut membulat untuk tombol. |
| 22 | `ScaffoldMessenger` | Mengelola dan menampilkan `SnackBar` pada `Scaffold` terdekat. |
| 23 | `SnackBar` | Pesan singkat di bagian bawah layar saat tombol menu ditekan. |
| 24 | `ThemeData` | Menyimpan pengaturan tema aplikasi (warna, Material 3). |
| 25 | `ColorScheme` | Kumpulan warna tema (`primary`, `secondary`) yang dibuat dengan `ColorScheme.fromSeed`. |
| 26 | `MyApp` | Widget buatan sendiri (`StatelessWidget`). Root yang membungkus `MaterialApp` dan mengatur tema. |
| 27 | `MyHomePage` | Widget buatan sendiri (`StatelessWidget`). Halaman utama berisi kartu profil, tombol Logout, serta section Projects dan Experience. |
| 28 | `InfoCard` | Widget buatan sendiri (`StatelessWidget`). Kartu kecil untuk menampilkan data profil (Name, NPM, Class). |
| 29 | `ItemCard` | Widget buatan sendiri (`StatelessWidget`). Tombol menu berwarna berisi ikon dan nama, memunculkan `SnackBar` saat ditekan. |
   
### 3. ⁠Fungsi MaterialApp dan mengapa umumnya digunakan sebagai root widget
MaterialApp adalah widget yang menyiapkan semua hal dasar aplikasi yang bergaya Material Design, seperti theme, home, navigasi/routing, dan dukungan bahasa. Biasanya digunakan sebagai root karena semua widget Material di bawahanya membutuhkan konteks yang disediakan MaterialApp.

### 4. Stateless Widget vs Stateful Widget
Stateless widget adalah widget yang statenya tetap, sedangkan Stateful widget statenya dapat berubah kapan saja.  Stateless widget digunakan saat tampilannya hanya bergantung pada data tetap yang didefinisikan di aplikasi, sedangkan Stateful widget digunakan ketika diperlukan interaksi yang dapat berubah dari waktu ke waktu, contohnya itu seperti counter bawaan flutter saat baru memulai project,

### 5. BuildContext dan penggunaannya dalam method build
BuildContext adalah penunjuk lokasi widget di dalam widget tree. Lewat context, sebuah widget bisa “melihat ke atas” ke parent-parentnya untuk mengambil informasi. Di build(BuildContext context), context yang diterima adalah lokasi widget itu sendiri. Karena itu of(context) mengambil data dari ancestor-nya, bukan dari tempat lain.

### 6. Hot Reload dan perbedaannya dengan Hot Restart
Hot Reload bekerja dengan membangun ulang widget tree saat ada perubahan kode baru. Bedanya dengan Hot Restart, Hot Reload tetap memertahakan state yang masih tersimpan pada aplikasi preview kita, sedangkan kalau Hot Restart itu akan menghilangkan state dan mengembalikannya seperti semula. Hot Reload tidak cukup ketika kita ingin menguji aplikasi kita mulai dari state awal, jadi diperlukan Hot Restart, Full Restart melakukan perubahan native, digunakan saat kita ingin membangun aplikasi dari awal.

## AI Disclosure
Dalam mengerjakan Tugas ini saya banyak meminta bantuan Claude AI sebagai teman belajar, bukans sebagai code generator. Semua kode pada repo ini merupakan hasil tangan saya sendiri, Claude AI hanya membantu saat saya kesulitan mencari penyebab error dan saat ingin menambahkan fitur baru Claude AI memberikan arahan.
