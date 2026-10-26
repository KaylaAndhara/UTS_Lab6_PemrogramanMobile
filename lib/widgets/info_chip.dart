import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.sp(12),
        vertical: r.sp(8),
      ),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(r.sp(30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: r.sp(18), color: scheme.onPrimaryContainer),
          SizedBox(width: r.sp(6)),
          Text(
            label,
            style: TextStyle(
              fontSize: r.sp(12),
              fontWeight: FontWeight.w500,
              color: scheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
