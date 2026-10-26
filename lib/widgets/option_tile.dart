import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Satu pilihan jawaban (A, B, C, D).
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.label,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(r.sp(16));

    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(10)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected ? scheme.primaryContainer : scheme.surface,
          borderRadius: radius,
          border: Border.all(
            color: selected ? scheme.primary : scheme.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(r.sp(14)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: r.sp(16),
                    backgroundColor:
                        selected ? scheme.primary : scheme.surfaceContainerHighest,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: r.sp(14),
                        fontWeight: FontWeight.w700,
                        color: selected ? scheme.onPrimary : scheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(width: r.sp(12)),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: r.sp(15),
                        fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (selected)
                    Icon(
                      Icons.check_circle_rounded,
                      color: scheme.primary,
                      size: r.sp(24),
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
