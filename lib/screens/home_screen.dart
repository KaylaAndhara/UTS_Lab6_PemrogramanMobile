import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_routes.dart';
import '../core/utils/responsive.dart';
import '../data/questions_data.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/history_tile.dart';
import '../widgets/info_chip.dart';
import '../widgets/primary_button.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman 1: input nama + mulai kuis.
/// StatefulWidget karena memiliki TextEditingController & Form.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: context.read<QuizProvider>().userName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context.read<QuizProvider>().startQuiz(_nameController.text);
    Navigator.pushNamed(context, AppRoutes.quiz);
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Nama tidak boleh kosong';
    if (name.length < 2) return 'Nama minimal 2 karakter';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;
    final history = context.watch<QuizProvider>().history;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: r.maxContentWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(r.sp(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ---- top bar ----
                  Row(
                    children: [
                      AppLogo(size: r.sp(40)),
                      SizedBox(width: r.sp(10)),
                      Text(
                        'Quizzy',
                        style: TextStyle(
                          fontSize: r.sp(20),
                          fontWeight: FontWeight.w700,
                          color: scheme.primary,
                        ),
                      ),
                      const Spacer(),
                      const ThemeToggleButton(),
                    ],
                  ),
                  SizedBox(height: r.sp(16)),

                  // ---- banner ----
                  ClipRRect(
                    borderRadius: BorderRadius.circular(r.sp(24)),
                    child: AspectRatio(
                      aspectRatio: 1200 / 560,
                      child: Image.asset(AppAssets.hero, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: r.sp(20)),

                  Text(
                    'Siap menguji pengetahuanmu?',
                    style: TextStyle(
                      fontSize: r.sp(22),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: r.sp(6)),
                  Text(
                    'Masukkan namamu, jawab semua pertanyaan, '
                    'lalu lihat skor akhirmu.',
                    style: TextStyle(
                      fontSize: r.sp(14),
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: r.sp(12)),
                  Wrap(
                    spacing: r.sp(8),
                    runSpacing: r.sp(8),
                    children: [
                      InfoChip(
                        icon: Icons.quiz_rounded,
                        label: '${QuestionsData.all.length} Soal',
                      ),
                      const InfoChip(
                        icon: Icons.checklist_rounded,
                        label: 'Pilihan Ganda',
                      ),
                      const InfoChip(
                        icon: Icons.shuffle_rounded,
                        label: 'Soal Diacak',
                      ),
                    ],
                  ),
                  SizedBox(height: r.sp(24)),

                  // ---- form nama ----
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      validator: _validateName,
                      onFieldSubmitted: (_) => _startQuiz(),
                      style: TextStyle(fontSize: r.sp(16)),
                      decoration: InputDecoration(
                        labelText: 'Nama kamu',
                        hintText: 'Contoh: Budi Santoso',
                        prefixIcon: const Icon(Icons.person_rounded),
                        filled: true,
                        fillColor: scheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(r.sp(16)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: r.sp(16)),
                  PrimaryButton(
                    label: 'Mulai Kuis',
                    icon: Icons.play_arrow_rounded,
                    onPressed: _startQuiz,
                  ),

                  // ---- riwayat ----
                  if (history.isNotEmpty) ...[
                    SizedBox(height: r.sp(28)),
                    Text(
                      'Riwayat Skor',
                      style: TextStyle(
                        fontSize: r.sp(16),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: r.sp(10)),
                    for (final item in history) HistoryTile(result: item),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
