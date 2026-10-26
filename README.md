# Quizzy – Aplikasi Kuis Pilihan Ganda

## 👤 Identitas Mahasiswa
| | |
|---|---|
| **Nama** | _(isi nama lengkap)_ |
| **NIM** | _(isi NIM)_ |
| **Lab** | Pemrograman Mobile – IKLC USU (PM _…_) |

## 📱 Informasi Aplikasi
**Nama Aplikasi:** Quizzy

**Deskripsi singkat:** Aplikasi kuis pilihan ganda tentang dasar-dasar Flutter. Pengguna memasukkan nama, menjawab 10 pertanyaan, lalu melihat skor akhir beserta pembahasan jawaban.

### Fitur
- Input nama pengguna dengan validasi form
- 10 soal pilihan ganda (data dummy lokal, tanpa database), urutan soal diacak setiap kuis
- Navigasi antar-halaman: **Beranda → Kuis → Hasil**
- Tombol Sebelumnya / Lanjut, jawaban bisa diubah sebelum menyelesaikan kuis
- Progress bar & penghitung soal
- Skor akhir beranimasi (persentase, benar, salah) + pesan sesuai nilai
- Pembahasan tiap soal (jawaban kamu, jawaban benar, penjelasan)
- Riwayat skor selama aplikasi berjalan
- Konfirmasi saat keluar kuis di tengah jalan
- **State management (Provider)** → progres tidak hilang saat rotasi / pindah halaman
- **Bonus:** Dark & Light mode (tombol di pojok kanan atas)
- **Bonus:** Adaptive & responsive (layout 1 kolom di ponsel, 2 kolom di tablet/landscape/web)

## 🧱 Struktur Proyek
```
lib/
├── main.dart                  # entry point + MultiProvider
├── app.dart                   # MaterialApp, tema, routes
├── core/
│   ├── constants/             # app_assets.dart, app_routes.dart
│   ├── theme/                 # app_colors.dart, app_theme.dart
│   └── utils/responsive.dart  # helper ukuran dinamis
├── data/
│   ├── models/                # question.dart, quiz_result.dart
│   └── questions_data.dart    # kumpulan soal (1 file)
├── providers/                 # quiz_provider.dart, theme_provider.dart
├── screens/                   # home_screen, quiz_screen, result_screen
└── widgets/                   # reusable widgets (1 widget = 1 file)
assets/
├── fonts/                     # Poppins
└── images/                    # logo, hero, trophy
```

## 📚 Dokumentasi
### Credit Aset
- **Font Poppins** – Indian Type Foundry, lisensi SIL Open Font License 1.1 (https://fonts.google.com/specimen/Poppins)
- **Ikon** – Material Icons bawaan Flutter (Google, Apache 2.0)
- **Gambar (logo.png, hero.png, trophy.png)** – dibuat sendiri _(sesuaikan dengan asetmu)_

### Screenshot
| Beranda | Kuis | Hasil |
|---|---|---|
| _(tambahkan)_ | _(tambahkan)_ | _(tambahkan)_ |

> Simpan screenshot di folder `docs/screenshots/` lalu tautkan di sini.

### Mockup / Prototype
_(tempel link Figma di sini)_

## ▶️ Cara Menjalankan
```bash
flutter pub get
flutter run
```
