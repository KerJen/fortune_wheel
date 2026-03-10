import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../data/model/gift/gift.dart';
import '../../../colors.dart';

sealed class RarityConfig {
  final Color color;
  final double glowBlur;
  final double glowOpacity;
  final double strokeWidth;
  final int particleCount;
  final int shimmerDurationMs;
  final bool animated;

  const RarityConfig({
    required this.color,
    required this.glowBlur,
    required this.glowOpacity,
    required this.strokeWidth,
    required this.particleCount,
    required this.shimmerDurationMs,
    required this.animated,
  });

  factory RarityConfig.from(GiftRarity rarity) {
    return switch (rarity) {
      GiftRarity.common => const CommonConfig(),
      GiftRarity.rare => const RareConfig(),
      GiftRarity.epic => const EpicConfig(),
      GiftRarity.legendary => const LegendaryConfig(),
    };
  }

  double glowAtProgress(double progress) => glowBlur;
}

class CommonConfig extends RarityConfig {
  const CommonConfig()
    : super(
        color: rarityCommon,
        glowBlur: 0,
        glowOpacity: 0,
        strokeWidth: 1.5,
        particleCount: 0,
        shimmerDurationMs: 0,
        animated: false,
      );
}

class RareConfig extends RarityConfig {
  const RareConfig()
    : super(
        color: rarityRare,
        glowBlur: 8,
        glowOpacity: 0.4,
        strokeWidth: 3,
        particleCount: 0,
        shimmerDurationMs: 2500,
        animated: true,
      );
}

class EpicConfig extends RarityConfig {
  const EpicConfig()
    : super(
        color: rarityEpic,
        glowBlur: 12,
        glowOpacity: 0.5,
        strokeWidth: 2,
        particleCount: 5,
        shimmerDurationMs: 2500,
        animated: true,
      );
}

class LegendaryConfig extends RarityConfig {
  const LegendaryConfig()
    : super(
        color: rarityLegendary,
        glowBlur: 16,
        glowOpacity: 0.6,
        strokeWidth: 2.5,
        particleCount: 10,
        shimmerDurationMs: 1500,
        animated: true,
      );

  @override
  double glowAtProgress(double progress) {
    return glowBlur + 4 * sin(progress * 2 * pi);
  }
}

class RarityFrame extends StatefulWidget {
  final GiftRarity rarity;
  final Widget child;
  final double borderRadius;

  const RarityFrame({
    super.key,
    required this.rarity,
    required this.child,
    this.borderRadius = 12,
  });

  @override
  State<RarityFrame> createState() => _RarityFrameState();
}

class _RarityFrameState extends State<RarityFrame> with SingleTickerProviderStateMixin {
  late final RarityConfig _config = RarityConfig.from(widget.rarity);
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _config.shimmerDurationMs.clamp(1, 99999)),
    );
    if (_config.animated) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clippedChild = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: widget.child,
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _buildGlow(),
          ),
          child: CustomPaint(
            painter: _BorderPainter(
              config: _config,
              progress: _controller.value,
              borderRadius: widget.borderRadius,
            ),
            foregroundPainter: _config.particleCount > 0
                ? _ParticlePainter(
                    config: _config,
                    progress: _controller.value,
                    borderRadius: widget.borderRadius,
                  )
                : null,
            child: child,
          ),
        );
      },
      child: clippedChild,
    );
  }

  List<BoxShadow> _buildGlow() {
    if (_config.glowBlur <= 0) return [];
    return [
      BoxShadow(
        color: _config.color.withValues(alpha: _config.glowOpacity),
        blurRadius: _config.glowAtProgress(_controller.value),
        spreadRadius: 1,
      ),
    ];
  }
}

class _BorderPainter extends CustomPainter {
  final RarityConfig config;
  final double progress;
  final double borderRadius;

  _BorderPainter({
    required this.config,
    required this.progress,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.strokeWidth;

    if (config.animated) {
      _applyShimmerShader(paint, rect);
    } else {
      paint.color = config.color.withValues(alpha: 0.5);
    }

    canvas.drawRRect(rrect, paint);
  }

  void _applyShimmerShader(Paint paint, Rect rect) {
    final angle = progress * 2 * pi;
    final gradient = SweepGradient(
      colors: [
        config.color,
        config.color.withValues(alpha: 0.6),
        Colors.transparent,
        Colors.transparent,
        config.color.withValues(alpha: 0.6),
        config.color,
      ],
      stops: const [0.0, 0.1, 0.3, 0.7, 0.9, 1.0],
      transform: GradientRotation(angle),
    );
    paint.shader = gradient.createShader(rect);
  }

  @override
  bool shouldRepaint(covariant _BorderPainter old) => old.progress != progress;
}

class _ParticlePainter extends CustomPainter {
  final RarityConfig config;
  final double progress;
  final double borderRadius;

  _ParticlePainter({
    required this.config,
    required this.progress,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final rx = center.dx + 4;
    final ry = center.dy + 4;

    for (int i = 0; i < config.particleCount; i++) {
      final baseAngle = (i / config.particleCount) * 2 * pi;
      final angle = baseAngle + progress * 2 * pi;
      final wobble = sin(progress * 4 * pi + i * 1.7) * 3;

      final x = center.dx + (rx + wobble) * cos(angle);
      final y = center.dy + (ry + wobble) * sin(angle);

      final opacity = 0.4 + 0.6 * ((sin(progress * 2 * pi + i * 2.3) + 1) / 2);
      final radius = 1.5 + 1.0 * ((sin(progress * 3 * pi + i * 1.5) + 1) / 2);

      final paint = Paint()
        ..color = config.color.withValues(alpha: opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => old.progress != progress;
}
