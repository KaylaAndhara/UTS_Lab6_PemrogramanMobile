import 'models/question.dart';

/// Data soal dummy (lokal, tanpa database). Semua soal berada dalam satu file.
class QuestionsData {
  QuestionsData._();

  static const List<Question> all = [
    Question(
      text: 'Bahasa pemrograman yang digunakan untuk membangun aplikasi Flutter adalah...',
      options: ['Kotlin', 'Dart', 'Swift', 'JavaScript'],
      correctIndex: 1,
      explanation: 'Flutter menggunakan bahasa Dart yang dikembangkan oleh Google.',
    ),
    Question(
      text: 'Semua elemen UI pada Flutter disebut dengan...',
      options: ['Component', 'View', 'Widget', 'Element'],
      correctIndex: 2,
      explanation: 'Di Flutter, "everything is a widget".',
    ),
    Question(
      text: 'Widget yang tampilannya tidak berubah setelah dibuat adalah...',
      options: ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'AnimatedWidget'],
      correctIndex: 1,
      explanation: 'StatelessWidget tidak menyimpan state yang berubah.',
    ),
    Question(
      text: 'Method yang dipanggil untuk memperbarui tampilan pada State adalah...',
      options: ['refresh()', 'update()', 'setState()', 'rebuild()'],
      correctIndex: 2,
      explanation: 'setState() memberi tahu framework bahwa state berubah dan UI perlu dibangun ulang.',
    ),
    Question(
      text: 'File yang digunakan untuk mendaftarkan aset dan font pada Flutter adalah...',
      options: ['main.dart', 'AndroidManifest.xml', 'pubspec.yaml', 'build.gradle'],
      correctIndex: 2,
      explanation: 'Aset, font, dan dependensi didaftarkan di pubspec.yaml.',
    ),
    Question(
      text: 'Widget yang menyusun anak-anaknya secara vertikal adalah...',
      options: ['Row', 'Stack', 'Column', 'ListTile'],
      correctIndex: 2,
      explanation: 'Column menyusun widget ke bawah (sumbu vertikal), Row ke samping.',
    ),
    Question(
      text: 'Fungsi yang digunakan untuk berpindah ke halaman baru adalah...',
      options: ['Navigator.push()', 'Navigator.open()', 'Page.goto()', 'Route.start()'],
      correctIndex: 0,
      explanation: 'Navigator.push() menambahkan route baru di atas tumpukan navigasi.',
    ),
    Question(
      text: 'Class yang sering dipakai pada package Provider agar UI dapat diberi tahu saat data berubah adalah...',
      options: ['ChangeNotifier', 'FutureBuilder', 'TextEditingController', 'GlobalKey'],
      correctIndex: 0,
      explanation: 'ChangeNotifier memanggil notifyListeners() untuk memberi tahu listener.',
    ),
    Question(
      text: 'Agar ukuran UI menyesuaikan layar perangkat, class yang dapat digunakan untuk membaca ukuran layar adalah...',
      options: ['MediaQuery', 'Navigator', 'Theme', 'Scaffold'],
      correctIndex: 0,
      explanation: 'MediaQuery.of(context).size memberikan lebar dan tinggi layar.',
    ),
    Question(
      text: 'Perintah untuk menjalankan aplikasi Flutter dari terminal adalah...',
      options: ['flutter start', 'flutter run', 'flutter build run', 'dart launch'],
      correctIndex: 1,
      explanation: '`flutter run` membangun dan menjalankan aplikasi pada perangkat/emulator.',
    ),
  ];
}
