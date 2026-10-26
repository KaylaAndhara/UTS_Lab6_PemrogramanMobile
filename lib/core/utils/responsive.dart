import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Helper ukuran dinamis. Semua ukuran (font, padding, tinggi tombol, dll.)
/// dihitung dari ukuran layar sehingga tidak ada nilai yang di-hardcode
/// untuk satu perangkat saja.
class Responsive {
  Responsive._(this.size);

  factory Responsive.of(BuildContext context) =>
      Responsive._(MediaQuery.sizeOf(context));

  final Size size;

  /// Lebar desain acuan (ponsel). Skala = sisi terpendek layar / acuan,
  /// sehingga rotasi ponsel tidak membuat tampilan membesar berlebihan.
  static const double _referenceShortestSide = 390;

  double get scale =>
      (size.shortestSide / _referenceShortestSide).clamp(0.85, 1.4).toDouble();

  /// Skala ukuran (font, padding, radius, ikon, dst).
  double sp(double value) => value * scale;

  /// Persentase lebar / tinggi layar (0-100).
  double wp(double percent) => size.width * percent / 100;
  double hp(double percent) => size.height * percent / 100;

  bool get isCompact => size.width < 600;

  /// Lebar maksimum konten supaya tetap proporsional di tablet / web.
  double get maxContentWidth =>
      isCompact ? size.width : math.min(size.width * 0.9, 900);

  /// Layout dua kolom dipakai bila ruang cukup (tablet / landscape / web).
  bool get isWide => maxContentWidth >= 640;
}

extension ResponsiveContext on BuildContext {
  Responsive get r => Responsive.of(this);
}
