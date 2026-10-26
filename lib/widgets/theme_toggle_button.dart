import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/theme_provider.dart';

/// Tombol untuk berganti Dark / Light mode.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return IconButton(
      tooltip: isDark ? 'Mode terang' : 'Mode gelap',
      iconSize: context.r.sp(26),
      icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
      onPressed: () => context.read<ThemeProvider>().toggle(brightness),
    );
  }
}
