# Panduan Commit GitHub (contoh urutan)

Soal mewajibkan commit **per fitur**, bukan upload di akhir. Contoh urutan:

```bash
git init
git branch -M main
git remote add origin https://github.com/<username>/<repo>.git

git add . && git commit -m "chore: inisialisasi proyek Flutter"
git add pubspec.yaml assets/ && git commit -m "feat: tambah aset gambar dan font Poppins"
git add lib/core/ && git commit -m "feat: tambah tema dark/light dan helper responsive"
git add lib/data/ && git commit -m "feat: tambah model dan data soal"
git add lib/providers/ && git commit -m "feat: tambah state management dengan Provider"
git add lib/widgets/ && git commit -m "feat: tambah reusable widgets"
git add lib/screens/home_screen.dart && git commit -m "feat: halaman beranda dengan input nama"
git add lib/screens/quiz_screen.dart && git commit -m "feat: halaman kuis"
git add lib/screens/result_screen.dart && git commit -m "feat: halaman hasil dan pembahasan"
git add README.md docs/ && git commit -m "docs: lengkapi README"
git push -u origin main
```
Idealnya commit dilakukan **sambil** mengerjakan (selisih waktu antar-commit terlihat), bukan sekaligus.
