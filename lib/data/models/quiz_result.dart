class QuizResult {
  const QuizResult({
    required this.userName,
    required this.score,
    required this.total,
    required this.date,
  });

  final String userName;
  final int score;
  final int total;
  final DateTime date;

  double get percentage => total == 0 ? 0 : score / total * 100;
}
