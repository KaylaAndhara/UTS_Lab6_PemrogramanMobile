import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    super.key,
    required this.current,
    required this.total,
    required this.answered,
  });

  final int current; // mulai dari 1
  final int total;
  final int answered;

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Soal $current dari $total',
              style: TextStyle(
                fontSize: r.sp(14),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$answered terjawab',
              style: TextStyle(
                fontSize: r.sp(12),
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(r.sp(10)),
          child: LinearProgressIndicator(
            value: total == 0 ? 0 : current / total,
            minHeight: r.sp(10),
          ),
        ),
      ],
    );
  }
}
