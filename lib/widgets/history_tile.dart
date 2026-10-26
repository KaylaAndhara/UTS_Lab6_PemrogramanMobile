import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';
import '../data/models/quiz_result.dart';

/// Satu baris riwayat skor di halaman beranda.
class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.result});

  final QuizResult result;

  String _formatTime(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}  ${two(d.hour)}:${two(d.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: r.sp(8)),
      padding: EdgeInsets.all(r.sp(12)),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(r.sp(14)),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.emoji_events_rounded, size: r.sp(26), color: scheme.primary),
          SizedBox(width: r.sp(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.userName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: r.sp(14),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  _formatTime(result.date),
                  style: TextStyle(
                    fontSize: r.sp(11),
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${result.score}/${result.total}',
            style: TextStyle(
              fontSize: r.sp(16),
              fontWeight: FontWeight.w700,
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
