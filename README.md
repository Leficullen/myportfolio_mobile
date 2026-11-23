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


## Tugas 7

### Pertanyaan Reflketif

#### 1. Widget Tree dan Hubungan Parent-Child
Di Flutter hampir semua yang tampil merupakan widget. Widget disusun  bersarang sehingga membentuk pohon, itulah yang dinamakan Widget Tree. Widget yang membungkus Widget lain disebut parent, parent yang memili 1 anak disebut child, sedangkan parent yang memiliki banyak anak disebut children: […]. Untuk bagaimana bekerja antar-widget, parent memberikan aturan ke anak, anak sendiri juga dapat memilih aturan yang hanya berlaku di anak dan anak dari anak tersebut. Aturan parent dapat memengaruhi anak, tapi aturan anak tidak dapat memengaruhi parent.

#### 2. Widget yang dipakai pada proyek ini:

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
   
#### 3. ⁠Fungsi MaterialApp dan mengapa umumnya digunakan sebagai root widget
MaterialApp adalah widget yang menyiapkan semua hal dasar aplikasi yang bergaya Material Design, seperti theme, home, navigasi/routing, dan dukungan bahasa. Biasanya digunakan sebagai root karena semua widget Material di bawahanya membutuhkan konteks yang disediakan MaterialApp.

#### 4. Stateless Widget vs Stateful Widget
Stateless widget adalah widget yang statenya tetap, sedangkan Stateful widget statenya dapat berubah kapan saja.  Stateless widget digunakan saat tampilannya hanya bergantung pada data tetap yang didefinisikan di aplikasi, sedangkan Stateful widget digunakan ketika diperlukan interaksi yang dapat berubah dari waktu ke waktu, contohnya itu seperti counter bawaan flutter saat baru memulai project,

#### 5. BuildContext dan penggunaannya dalam method build
BuildContext adalah penunjuk lokasi widget di dalam widget tree. Lewat context, sebuah widget bisa “melihat ke atas” ke parent-parentnya untuk mengambil informasi. Di build(BuildContext context), context yang diterima adalah lokasi widget itu sendiri. Karena itu of(context) mengambil data dari ancestor-nya, bukan dari tempat lain.

#### 6. Hot Reload dan perbedaannya dengan Hot Restart
Hot Reload bekerja dengan membangun ulang widget tree saat ada perubahan kode baru. Bedanya dengan Hot Restart, Hot Reload tetap memertahakan state yang masih tersimpan pada aplikasi preview kita, sedangkan kalau Hot Restart itu akan menghilangkan state dan mengembalikannya seperti semula. Hot Reload tidak cukup ketika kita ingin menguji aplikasi kita mulai dari state awal, jadi diperlukan Hot Restart, Full Restart melakukan perubahan native, digunakan saat kita ingin membangun aplikasi dari awal.

## AI Disclosure
Dalam mengerjakan Tugas ini saya banyak meminta bantuan Claude AI sebagai teman belajar, bukans sebagai code generator. Semua kode pada repo ini merupakan hasil tangan saya sendiri, Claude AI hanya membantu saat saya kesulitan mencari penyebab error dan saat ingin menambahkan fitur baru Claude AI memberikan arahan.

## Tugas 8

### 1. Perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop()
Navigator.push() menambahkan halaman baru ke stack navigasi. Halaman sebelumnya tetap ada sehingga pengguna dapat kembali dengan tombol Back. Pada kartu aksi Tambah Experience, aplikasi menggunakan Navigator.push() untuk membuka ExperienceFormPage.
Navigator.pushReplacement() mengganti rute aktif dengan rute baru. Opsi Home di drawer menggunakan metode ini untuk membuka MyHomePage dan menggantikan halaman yang sedang aktif. Rute lain yang sudah ada sebelumnya dalam tumpukan tidak otomatis dihapus.
Navigator.pop() menutup rute teratas dan kembali ke rute di bawahnya. Pada formulir experience, metode ini digunakan untuk menutup dialog setelah pengguna menekan OK.
### 2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten
Scaffold menyediakan kerangka halaman, termasuk tempat untuk AppBar, Drawer, dan isi halaman. AppBar menampilkan judul dan akses ke drawer, sedangkan LeftDrawer digunakan kembali di beberapa halaman sehingga pilihan navigasinya konsisten.
Tema didefinisikan di main.dart dengan warna utama hitam. Contohnya, colorScheme.primary digunakan sebagai warna AppBar pada formulir experience dan formulir proyek, serta sebagai warna teks pada header drawer. Hal ini membantu halaman-halaman tersebut memiliki identitas visual yang sama.
### 3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.
Formulir menggunakan Column agar kolom nama, deskripsi, kategori, dan status tersusun secara vertikal dan mudah diikuti. Setiap field dibungkus dengan Padding sebesar 8 piksel agar tidak terlalu rapat dan lebih nyaman dibaca maupun disentuh.
SingleChildScrollView memungkinkan isi formulir digulir saat tinggi layar terbatas atau papan ketik muncul. Dengan demikian, pengguna tetap dapat menjangkau field dan tombol Save. Isi dialog hasil juga menggunakan widget penggulir agar tetap dapat dibaca ketika ruangnya terbatas.
### 4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan?
GlobalKey<FormState> menghubungkan kode dengan keadaan Form. Ketika tombol Save ditekan, _formKey.currentState!.validate() menjalankan validator pada field yang memilikinya. Jika ada nilai yang tidak valid, pesan kesalahan ditampilkan dan dialog hasil tidak dibuka. Jika seluruh validasi berhasil, aplikasi menampilkan dialog berisi data yang dimasukkan.
Contohnya, Experience Name yang kosong atau hanya berisi spasi ditolak karena validator memeriksa value.trim().isEmpty. Jenis input atau papan ketik saja belum cukup karena keduanya hanya membantu pengguna memasukkan data; keduanya tidak menjamin bahwa nilai tersebut terisi dan memenuhi aturan aplikasi.

## AI Disclosure
Dalam mengerjakan tugas ini, saya tidak menggnakan bantuan AI apapun, karena mostly materinya sudah tercover di Tutorial 9. Jika saya mendapati kesulitan, saya membuka kembali codebase Tutorial 9 dan mencari kesalahannya sendiri.
