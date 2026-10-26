import 'package:flutter/foundation.dart';

import '../data/models/question.dart';
import '../data/models/quiz_result.dart';
import '../data/questions_data.dart';

/// State management kuis (Provider + ChangeNotifier).
///
/// State disimpan di luar widget, sehingga progres jawaban TIDAK hilang
/// ketika layar dirotasi atau pengguna berpindah halaman.
class QuizProvider extends ChangeNotifier {
  String _userName = '';
  List<Question> _questions = [];
  final Map<int, int> _answers = {}; // index soal -> index opsi terpilih
  int _currentIndex = 0;
  bool _isFinished = false;
  final List<QuizResult> _history = [];

  // ---- getters ----
  String get userName => _userName;
  List<Question> get questions => List.unmodifiable(_questions);
  bool get hasQuestions => _questions.isNotEmpty;
  int get total => _questions.length;
  int get currentIndex => _currentIndex;
  bool get isFinished => _isFinished;
  List<QuizResult> get history => List.unmodifiable(_history);

  Question get currentQuestion => _questions[_currentIndex];
  int? get selectedAnswer => _answers[_currentIndex];
  int? answerAt(int questionIndex) => _answers[questionIndex];
  bool get isLastQuestion => _currentIndex == _questions.length - 1;
  bool get isFirstQuestion => _currentIndex == 0;
  int get answeredCount => _answers.length;

  int get score {
    var result = 0;
    _answers.forEach((qIndex, option) {
      if (_questions[qIndex].correctIndex == option) result++;
    });
    return result;
  }

  int get wrongCount => total - score;
  double get percentage => total == 0 ? 0 : score / total * 100;

  // ---- actions ----
  void startQuiz(String name) {
    _userName = name.trim();
    _questions = List<Question>.of(QuestionsData.all)..shuffle();
    _answers.clear();
    _currentIndex = 0;
    _isFinished = false;
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (!isLastQuestion) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (!isFirstQuestion) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void finish() {
    if (_isFinished) return;
    _isFinished = true;
    _history.insert(
      0,
      QuizResult(
        userName: _userName,
        score: score,
        total: total,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  /// Menghapus progres kuis berjalan (riwayat skor tetap disimpan).
  void reset() {
    _questions = [];
    _answers.clear();
    _currentIndex = 0;
    _isFinished = false;
    notifyListeners();
  }
}
