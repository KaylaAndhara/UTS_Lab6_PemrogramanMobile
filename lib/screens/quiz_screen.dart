import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_routes.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress_bar.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman 2: menjawab pertanyaan. Seluruh soal ditampilkan dengan SATU
/// halaman yang sama (konten diganti berdasarkan index), bukan satu file
/// per soal.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  /// Dialog konfirmasi keluar; bila setuju, progres dihapus & kembali ke beranda.
  Future<void> _handleExit(BuildContext context) async {
    final navigator = Navigator.of(context);
    final quiz = context.read<QuizProvider>();

    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres jawabanmu akan hilang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Lanjut Kuis'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (leave == true) {
      quiz.reset();
      navigator.pop();
    }
  }

  void _onNextPressed(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    if (quiz.isLastQuestion) {
      quiz.finish();
      Navigator.pushReplacementNamed(context, AppRoutes.result);
    } else {
      quiz.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final quiz = context.watch<QuizProvider>();

    if (!quiz.hasQuestions) {
      return Scaffold(
        body: Center(
          child: PrimaryButton(
            label: 'Kembali ke Beranda',
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            ),
          ),
        ),
      );
    }

    final question = quiz.currentQuestion;

    final questionPart = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QuizProgressBar(
          current: quiz.currentIndex + 1,
          total: quiz.total,
          answered: quiz.answeredCount,
        ),
        SizedBox(height: r.sp(16)),
        QuestionCard(number: quiz.currentIndex + 1, text: question.text),
      ],
    );

    final optionsPart = Column(
      children: [
        for (var i = 0; i < question.options.length; i++)
          OptionTile(
            label: String.fromCharCode(65 + i), // A, B, C, D
            text: question.options[i],
            selected: quiz.selectedAnswer == i,
            onTap: () => context.read<QuizProvider>().selectAnswer(i),
          ),
      ],
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleExit(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: r.maxContentWidth),
              child: Column(
                children: [
                  // ---- top bar ----
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: r.sp(12),
                      vertical: r.sp(4),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: 'Keluar',
                          iconSize: r.sp(26),
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => _handleExit(context),
                        ),
                        Expanded(
                          child: Text(
                            'Halo, ${quiz.userName}!',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: r.sp(16),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const ThemeToggleButton(),
                      ],
                    ),
                  ),

                  // ---- konten soal (scrollable, anti-overflow) ----
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: SingleChildScrollView(
                        key: ValueKey(quiz.currentIndex),
                        padding: EdgeInsets.symmetric(
                          horizontal: r.sp(20),
                          vertical: r.sp(8),
                        ),
                        child: r.isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: questionPart),
                                  SizedBox(width: r.sp(20)),
                                  Expanded(child: optionsPart),
                                ],
                              )
                            : Column(
                                children: [
                                  questionPart,
                                  SizedBox(height: r.sp(16)),
                                  optionsPart,
                                ],
                              ),
                      ),
                    ),
                  ),

                  // ---- tombol navigasi soal ----
                  Padding(
                    padding: EdgeInsets.all(r.sp(16)),
                    child: Row(
                      children: [
                        if (!quiz.isFirstQuestion) ...[
                          Expanded(
                            child: PrimaryButton(
                              label: 'Sebelumnya',
                              icon: Icons.arrow_back_rounded,
                              outlined: true,
                              onPressed: () =>
                                  context.read<QuizProvider>().previous(),
                            ),
                          ),
                          SizedBox(width: r.sp(12)),
                        ],
                        Expanded(
                          child: PrimaryButton(
                            label: quiz.isLastQuestion ? 'Selesai' : 'Lanjut',
                            icon: quiz.isLastQuestion
                                ? Icons.flag_rounded
                                : Icons.arrow_forward_rounded,
                            onPressed: quiz.selectedAnswer == null
                                ? null
                                : () => _onNextPressed(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
