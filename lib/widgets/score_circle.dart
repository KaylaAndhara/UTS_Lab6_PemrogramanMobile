import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Lingkaran skor beranimasi (StatefulWidget karena memakai AnimationController).
class ScoreCircle extends StatefulWidget {
  const ScoreCircle({
    super.key,
    required this.score,
    required this.total,
    required this.size,
  });

  final int score;
  final int total;
  final double size;

  @override
  State<ScoreCircle> createState() => _ScoreCircleState();
}

class _ScoreCircleState extends State<ScoreCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;
    final target = widget.total == 0 ? 0.0 : widget.score / widget.total;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final value = target * _animation.value;
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: value,
                strokeWidth: widget.size * 0.09,
                backgroundColor: scheme.surfaceContainerHighest,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(value * 100).round()}%',
                      style: TextStyle(
                        fontSize: widget.size * 0.24,
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                      ),
                    ),
                    Text(
                      '${widget.score} / ${widget.total} benar',
                      style: TextStyle(
                        fontSize: r.sp(12),
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
