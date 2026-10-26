import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return Container(
      padding: EdgeInsets.all(r.sp(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r.sp(24)),
        gradient: const LinearGradient(
          colors: [AppColors.seed, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.seed.withAlpha(80),
            blurRadius: r.sp(16),
            offset: Offset(0, r.sp(6)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: r.sp(12),
              vertical: r.sp(4),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(r.sp(20)),
            ),
            child: Text(
              'Pertanyaan $number',
              style: TextStyle(
                color: Colors.white,
                fontSize: r.sp(12),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: r.sp(14)),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: r.sp(18),
              height: 1.45,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
