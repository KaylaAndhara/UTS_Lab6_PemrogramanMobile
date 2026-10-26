import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../data/models/question.dart';

/// Pembahasan satu soal pada halaman hasil.
class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.number,
    required this.question,
    required this.selectedIndex,
  });

  final int number;
  final Question question;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;
    final isCorrect = selectedIndex == question.correctIndex;
    final color = isCorrect ? AppColors.success : AppColors.danger;
    final yourAnswer =
        selectedIndex == null ? 'Tidak dijawab' : question.options[selectedIndex!];

    return Container(
      margin: EdgeInsets.only(bottom: r.sp(10)),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(r.sp(16)),
        border: Border.all(color: color.withAlpha(120)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: color,
            size: r.sp(26),
          ),
          title: Text(
            '$number. ${question.text}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: r.sp(13), fontWeight: FontWeight.w500),
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            r.sp(16),
            0,
            r.sp(16),
            r.sp(14),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jawabanmu: $yourAnswer',
              style: TextStyle(fontSize: r.sp(13), color: color),
            ),
            if (!isCorrect)
              Text(
                'Jawaban benar: ${question.correctAnswer}',
                style: TextStyle(
                  fontSize: r.sp(13),
                  color: AppColors.success,
                  fontWeight: FontWeight.w500,
                ),
              ),
            SizedBox(height: r.sp(6)),
            Text(
              question.explanation,
              style: TextStyle(
                fontSize: r.sp(12),
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
