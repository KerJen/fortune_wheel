import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import '../../../../data/model/gift/gift.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../l10n/gift_l10n.dart';
import '../../../dimens.dart';
import '../../widgets/gift_image.dart';
import '../../inventory/widgets/rarity_frame.dart';
import 'confetti_layer.dart';

class GiftRevealOverlay extends StatefulWidget {
  final Gift wonGift;
  final VoidCallback onCollect;

  const GiftRevealOverlay({
    super.key,
    required this.wonGift,
    required this.onCollect,
  });

  @override
  State<GiftRevealOverlay> createState() => _GiftRevealOverlayState();
}

class _GiftRevealOverlayState extends State<GiftRevealOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final bool _hasCelebration = widget.wonGift.rarity != GiftRarity.common;

  late final ConfettiController? _leftCannonController;
  late final ConfettiController? _rightCannonController;
  late final ConfettiController? _rainLeftController;
  late final ConfettiController? _rainCenterController;
  late final ConfettiController? _rainRightController;

  Future<AudioSource>? _bangSource;
  late final Future<AudioSource> _winSource = SoLoud.instance.loadAsset(widget.wonGift.rarity.soundAsset);

  bool _dismissing = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    if (_hasCelebration) {
      _leftCannonController = ConfettiController(duration: const Duration(milliseconds: 100));
      _rightCannonController = ConfettiController(duration: const Duration(milliseconds: 100));
      _rainLeftController = ConfettiController(duration: const Duration(seconds: 3));
      _rainCenterController = ConfettiController(duration: const Duration(seconds: 3));
      _rainRightController = ConfettiController(duration: const Duration(seconds: 3));
      _bangSource = SoLoud.instance.loadAsset('assets/sounds/bang.mp3');
    } else {
      _leftCannonController = null;
      _rightCannonController = null;
      _rainLeftController = null;
      _rainCenterController = null;
      _rainRightController = null;
    }

    _fadeController.forward();

    if (_hasCelebration) {
      _playCelebration();
    } else {
      _winSource.then(SoLoud.instance.play);
    }
  }

  void _playCelebration() {
    _bangSource?.then(SoLoud.instance.play);
    _winSource.then(SoLoud.instance.play);
    _leftCannonController?.play();
    _rightCannonController?.play();
    _rainLeftController?.play();
    _rainCenterController?.play();
    _rainRightController?.play();
  }

  Future<void> _onCollect() async {
    if (_dismissing) return;
    _dismissing = true;

    await _fadeController.reverse();
    widget.onCollect();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _leftCannonController?.dispose();
    _rightCannonController?.dispose();
    _rainLeftController?.dispose();
    _rainCenterController?.dispose();
    _rainRightController?.dispose();
    _bangSource?.then(SoLoud.instance.disposeSource);
    _winSource.then(SoLoud.instance.disposeSource);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rarityColor = RarityConfig.from(widget.wonGift.rarity).color;

    return FadeTransition(
      opacity: _fadeController,
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              Container(color: Colors.black87),
              if (_hasCelebration)
                RepaintBoundary(
                  child: ConfettiLayer(
                    leftCannon: _leftCannonController!,
                    rightCannon: _rightCannonController!,
                    rainLeft: _rainLeftController!,
                    rainCenter: _rainCenterController!,
                    rainRight: _rainRightController!,
                  ),
                ),
              Center(
                child:
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 280,
                          height: 280,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (widget.wonGift.rarity != GiftRarity.common) ...[
                                CustomPaint(
                                  size: const Size(280, 280),
                                  painter: _RaysPainter(
                                    color: rarityColor,
                                    rayCount: 14,
                                    opacity: 0.25,
                                  ),
                                ).animate(onPlay: (c) => c.repeat()).rotate(duration: const Duration(seconds: 16)),
                                CustomPaint(
                                      size: const Size(260, 260),
                                      painter: _RaysPainter(
                                        color: rarityColor,
                                        rayCount: 10,
                                        opacity: 0.4,
                                      ),
                                    )
                                    .animate(onPlay: (c) => c.repeat())
                                    .rotate(
                                      begin: 0,
                                      end: -1,
                                      duration: const Duration(seconds: 10),
                                    ),
                              ],
                              RarityFrame(
                                rarity: widget.wonGift.rarity,
                                borderRadius: 20,
                                child: _GiftDisplay(gift: widget.wonGift),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: spacing15),
                        _GiftName(name: widget.wonGift.localizedName(context)),
                        const SizedBox(height: 4),
                        _RarityLabel(
                          rarity: widget.wonGift.rarity,
                          color: rarityColor,
                        ),
                        const SizedBox(height: spacing25),
                        _CollectButton(onPressed: _onCollect, color: rarityColor),
                      ],
                    ).animate().scale(
                      begin: const Offset(0, 0),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                      delay: 150.ms,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RaysPainter extends CustomPainter {
  final Color color;
  final int rayCount;
  final double opacity;

  _RaysPainter({
    required this.color,
    required this.rayCount,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.9;
    final sectorAngle = 2 * pi / rayCount;

    for (var i = 0; i < rayCount; i++) {
      final startAngle = i * sectorAngle;
      final endAngle = startAngle + sectorAngle;
      final alpha = i.isEven ? opacity : opacity * 0.4;

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(
          center.dx + radius * cos(startAngle),
          center.dy + radius * sin(startAngle),
        )
        ..lineTo(
          center.dx + radius * cos(endAngle),
          center.dy + radius * sin(endAngle),
        )
        ..close();

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            color.withValues(alpha: alpha),
            color.withValues(alpha: alpha * 0.3),
            color.withValues(alpha: 0),
          ],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RaysPainter old) => old.color != color || old.rayCount != rayCount || old.opacity != opacity;
}

class _GiftDisplay extends StatelessWidget {
  final Gift gift;

  const _GiftDisplay({required this.gift});

  List<Color> _shimmerColors(Color base) {
    final dark = Color.lerp(base, Colors.black, 0.3)!;
    final mid = base;
    final light = Color.lerp(base, Colors.white, 0.6)!;
    return [dark, mid, light, mid, dark];
  }

  @override
  Widget build(BuildContext context) {
    final rarityColor = RarityConfig.from(gift.rarity).color;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color.lerp(rarityColor, Colors.white, 0.7),
                borderRadius: BorderRadius.circular(20),
              ),
            )
            .animate(onPlay: (c) => c.repeat())
            .shimmer(
              duration: 2500.ms,
              colors: _shimmerColors(rarityColor),
            ),
        GiftImage(
          gift: gift,
          size: 120,
          borderRadius: 20,
        ),
      ],
    );
  }
}

class _GiftName extends StatelessWidget {
  final String name;

  const _GiftName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _RarityLabel extends StatelessWidget {
  final GiftRarity rarity;
  final Color color;

  const _RarityLabel({required this.rarity, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      rarity.name.toUpperCase(),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    );
  }
}

class _CollectButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;

  const _CollectButton({required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    final light = Color.lerp(color, Colors.white, 0.3)!;
    final dark = Color.lerp(color, Colors.black, 0.2)!;

    return SizedBox(
      width: 200,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [dark, light]),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: onPressed,
          child: Text(
            S.of(context).collect,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
