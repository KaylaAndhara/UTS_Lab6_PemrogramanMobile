import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return Container(
      padding: EdgeInsets.all(r.sp(14)),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(r.sp(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: r.sp(30)),
          SizedBox(width: r.sp(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: r.sp(20),
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              Text(label, style: TextStyle(fontSize: r.sp(12))),
            ],
          ),
        ],
      ),
    );
  }
}
