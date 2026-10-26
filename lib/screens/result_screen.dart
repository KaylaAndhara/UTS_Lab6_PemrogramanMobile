import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/review_tile.dart';
import '../widgets/score_circle.dart';
import '../widgets/stat_card.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman 3: skor akhir + pembahasan jawaban.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _message(double percentage) {
    if (percentage >= 80) return 'Luar biasa! Pemahamanmu sangat baik.';
    if (percentage >= 60) return 'Bagus! Sedikit lagi menjadi sempurna.';
    if (percentage >= 40) return 'Lumayan, ayo pelajari lagi materinya.';
    return 'Jangan menyerah, coba lagi ya!';
  }

  void _goHome(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
    quiz.reset();
  }

  void _retry(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    quiz.startQuiz(quiz.userName);
    Navigator.pushReplacementNamed(context, AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;
    final quiz = context.watch<QuizProvider>();

    if (!quiz.hasQuestions) {
      return Scaffold(
        body: Center(
          child: PrimaryButton(
            label: 'Kembali ke Beranda',
            onPressed: () => _goHome(context),
          ),
        ),
      );
    }

    final summary = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          AppAssets.trophy,
          height: r.sp(90),
          fit: BoxFit.contain,
        ),
        SizedBox(height: r.sp(8)),
        Text(
          'Selamat, ${quiz.userName}!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: r.sp(22), fontWeight: FontWeight.w700),
        ),
        SizedBox(height: r.sp(4)),
        Text(
          _message(quiz.percentage),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: r.sp(14),
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: r.sp(20)),
        Center(
          child: ScoreCircle(
            score: quiz.score,
            total: quiz.total,
            size: r.sp(170),
          ),
        ),
        SizedBox(height: r.sp(20)),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.check_circle_rounded,
                value: '${quiz.score}',
                label: 'Benar',
                color: AppColors.success,
              ),
            ),
            SizedBox(width: r.sp(12)),
            Expanded(
              child: StatCard(
                icon: Icons.cancel_rounded,
                value: '${quiz.wrongCount}',
                label: 'Salah',
                color: AppColors.danger,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(20)),
        PrimaryButton(
          label: 'Ulangi Kuis',
          icon: Icons.replay_rounded,
          onPressed: () => _retry(context),
        ),
        SizedBox(height: r.sp(10)),
        PrimaryButton(
          label: 'Kembali ke Beranda',
          icon: Icons.home_rounded,
          outlined: true,
          onPressed: () => _goHome(context),
        ),
      ],
    );

    final review = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pembahasan',
          style: TextStyle(fontSize: r.sp(16), fontWeight: FontWeight.w700),
        ),
        SizedBox(height: r.sp(10)),
        for (var i = 0; i < quiz.total; i++)
          ReviewTile(
            number: i + 1,
            question: quiz.questions[i],
            selectedIndex: quiz.answerAt(i),
          ),
      ],
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goHome(context);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Hasil Kuis',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.transparent,
          actions: const [ThemeToggleButton()],
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: r.maxContentWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(r.sp(20)),
                child: r.isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: summary),
                          SizedBox(width: r.sp(20)),
                          Expanded(child: review),
                        ],
                      )
                    : Column(
                        children: [
                          summary,
                          SizedBox(height: r.sp(24)),
                          review,
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
