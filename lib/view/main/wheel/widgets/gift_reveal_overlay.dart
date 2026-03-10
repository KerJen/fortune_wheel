import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:fortune/view/dimens.dart';
import '../../../../data/model/gift/gift.dart';
import '../../../colors.dart';
import '../../../common/gift_image.dart';
import '../../inventory/widgets/rarity_frame.dart';

const _confettiColors = [
  Color(0xFFFFB3BA),
  Color(0xFFFFDFBA),
  Color(0xFFFFFBBA),
  Color(0xFFBAFFC9),
  Color(0xFFBAE1FF),
  Color(0xFFD5BAFF),
  Color(0xFFFFBAE1),
  Color(0xFFC9FFE5),
];

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

class _GiftRevealOverlayState extends State<GiftRevealOverlay> with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  final _leftCannonController = ConfettiController(duration: const Duration(milliseconds: 100));
  final _rightCannonController = ConfettiController(duration: const Duration(milliseconds: 100));
  final _rainLeftController = ConfettiController(duration: const Duration(seconds: 3));
  final _rainCenterController = ConfettiController(duration: const Duration(seconds: 3));
  final _rainRightController = ConfettiController(duration: const Duration(seconds: 3));

  late final Future<AudioSource> _bangSource = SoLoud.instance.loadAsset('assets/sounds/bang.mp3');
  late final Future<AudioSource> _winSource = SoLoud.instance.loadAsset(widget.wonGift.rarity.soundAsset);

  bool _dismissing = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      _scaleController.forward();
    });

    if (widget.wonGift.rarity != GiftRarity.common) {
      _playCelebration();
    } else {
      _winSource.then((source) => SoLoud.instance.play(source));
    }
  }

  void _playCelebration() {
    _bangSource.then((source) => SoLoud.instance.play(source));
    _winSource.then((source) => SoLoud.instance.play(source));
    _leftCannonController.play();
    _rightCannonController.play();
    _rainLeftController.play();
    _rainCenterController.play();
    _rainRightController.play();
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
    _scaleController.dispose();
    _leftCannonController.dispose();
    _rightCannonController.dispose();
    _rainLeftController.dispose();
    _rainCenterController.dispose();
    _rainRightController.dispose();
    _bangSource.then((source) => SoLoud.instance.disposeSource(source));
    _winSource.then((source) => SoLoud.instance.disposeSource(source));
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
              _ConfettiLayer(
                leftCannon: _leftCannonController,
                rightCannon: _rightCannonController,
                rainLeft: _rainLeftController,
                rainCenter: _rainCenterController,
                rainRight: _rainRightController,
              ),
              Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
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
                      _GiftName(name: widget.wonGift.name),
                      const SizedBox(height: 4),
                      _RarityLabel(
                        rarity: widget.wonGift.rarity,
                        color: rarityColor,
                      ),
                      const SizedBox(height: spacing25),
                      _CollectButton(onPressed: _onCollect),
                    ],
                  ),
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

    for (int i = 0; i < rayCount; i++) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GiftImage(
        gift: gift,
        size: 120,
        borderRadius: 20,
      ),
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

  const _CollectButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [primary, secondary]),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: onPressed,
          child: Text(
            'Получить',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: bg,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfettiLayer extends StatelessWidget {
  final ConfettiController leftCannon;
  final ConfettiController rightCannon;
  final ConfettiController rainLeft;
  final ConfettiController rainCenter;
  final ConfettiController rainRight;

  const _ConfettiLayer({
    required this.leftCannon,
    required this.rightCannon,
    required this.rainLeft,
    required this.rainCenter,
    required this.rainRight,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ConfettiWidget(
              confettiController: leftCannon,
              blastDirection: -7 * pi / 18,
              emissionFrequency: 0.02,
              numberOfParticles: 50,
              maxBlastForce: 120,
              minBlastForce: 80,
              gravity: 0.15,
              minimumSize: const Size(5, 5),
              maximumSize: const Size(10, 10),
              colors: _confettiColors,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ConfettiWidget(
              confettiController: rightCannon,
              blastDirection: -11 * pi / 18,
              emissionFrequency: 0.02,
              numberOfParticles: 50,
              maxBlastForce: 120,
              minBlastForce: 80,
              gravity: 0.15,
              minimumSize: const Size(5, 5),
              maximumSize: const Size(10, 10),
              colors: _confettiColors,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ConfettiWidget(
              confettiController: rainLeft,
              blastDirection: pi / 2,
              emissionFrequency: 0.15,
              numberOfParticles: 3,
              maxBlastForce: 5,
              minBlastForce: 2,
              gravity: 0.05,
              minimumSize: const Size(3, 3),
              maximumSize: const Size(6, 6),
              blastDirectionality: BlastDirectionality.directional,
              colors: _confettiColors,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: rainCenter,
              blastDirection: pi / 2,
              emissionFrequency: 0.15,
              numberOfParticles: 3,
              maxBlastForce: 5,
              minBlastForce: 2,
              gravity: 0.05,
              minimumSize: const Size(3, 3),
              maximumSize: const Size(6, 6),
              blastDirectionality: BlastDirectionality.directional,
              colors: _confettiColors,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
              confettiController: rainRight,
              blastDirection: pi / 2,
              emissionFrequency: 0.15,
              numberOfParticles: 3,
              maxBlastForce: 5,
              minBlastForce: 2,
              gravity: 0.05,
              minimumSize: const Size(3, 3),
              maximumSize: const Size(6, 6),
              blastDirectionality: BlastDirectionality.directional,
              colors: _confettiColors,
            ),
          ),
        ],
      ),
    );
  }
}
