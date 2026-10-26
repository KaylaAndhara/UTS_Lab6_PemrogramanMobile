import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:quizzy/app.dart';
import 'package:quizzy/providers/quiz_provider.dart';
import 'package:quizzy/providers/theme_provider.dart';

void main() {
  testWidgets('Halaman beranda menampilkan tombol Mulai Kuis', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuizProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const QuizApp(),
      ),
    );

    expect(find.text('Mulai Kuis'), findsOneWidget);
  });
}
