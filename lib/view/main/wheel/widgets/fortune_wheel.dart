import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../colors.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

const _rimColor = Color(0xFFFFDA9A);
const _pegRadius = 5.0;
const _pegInset = 50.0;

const _wheelColors = [
  Color(0xFFFFB3BA),
  Color(0xFFFFDFBA),
  Color(0xFFFFFBBA),
  Color(0xFFBAFFC9),
  Color(0xFFBAE1FF),
  Color(0xFFD5BAFF),
  Color(0xFFFFBAE1),
  Color(0xFFC9FFE5),
];

class FortuneWheel extends StatefulWidget {
  const FortuneWheel({super.key});

  @override
  State<FortuneWheel> createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheel> with TickerProviderStateMixin {
  late final AnimationController _flowerController;
  late final AnimationController _spinController;
  late final AnimationController _petalScaleController;

  late final Ticker _physicsTicker;

  double _wheelAngle = 0;
  double _previousAngle = 0;
  bool _isSpinning = false;
  bool _flowerReversed = false;
  Size _widgetSize = Size.zero;

  double _arrowAngle = 0;
  double _arrowVelocity = 0;
  double _prevWheelAngle = 0;
  Duration _lastTickTime = Duration.zero;

  static const _gravity = 40.0;
  static const _damping = 6.0;
  static const _maxArrowAngle = 0.4;

  @override
  void initState() {
    super.initState();
    _flowerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _spinController = AnimationController(
      vsync: this,
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
      value: 0,
    );
    _spinController.addListener(() {
      setState(() {
        _wheelAngle = _spinController.value;
      });
    });
    _petalScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: 1.0,
      lowerBound: 1.0 / 1.5,
      upperBound: 1.0,
    );
    _physicsTicker = createTicker(_tick)..start();
  }

  @override
  void dispose() {
    _physicsTicker.dispose();
    _flowerController.dispose();
    _spinController.dispose();
    _petalScaleController.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    if (_lastTickTime == Duration.zero) {
      _lastTickTime = elapsed;
      return;
    }
    final dt = (elapsed - _lastTickTime).inMicroseconds / 1000000.0;
    _lastTickTime = elapsed;
    if (dt <= 0 || dt > 0.1) return;

    final wheelOmega = -(_wheelAngle - _prevWheelAngle) / dt;
    _prevWheelAngle = _wheelAngle;

    if (_pegTouching() && wheelOmega.abs() > 0.01) {
      final target = wheelOmega.sign * _maxArrowAngle;
      _arrowAngle += (target - _arrowAngle) * (1 - exp(-15 * dt));
      _arrowVelocity = 0;
    } else {
      _arrowVelocity += (-_gravity * sin(_arrowAngle) - _damping * _arrowVelocity) * dt;
      _arrowAngle += _arrowVelocity * dt;
    }

    _arrowAngle = _arrowAngle.clamp(-_maxArrowAngle, _maxArrowAngle);

    if (_arrowAngle.abs() > 0.0001 || _arrowVelocity.abs() > 0.0001) {
      setState(() {});
    }
  }

  bool _pegTouching() {
    if (_widgetSize == Size.zero) return false;
    final radius = _widgetSize.width / 2;
    final pegCenterRadius = radius - _pegInset + _pegRadius;
    final threshold = (_pegRadius + 3) / pegCenterRadius;
    final sweepAngle = 2 * pi / _wheelColors.length;
    final normalized = (_wheelAngle % sweepAngle + sweepAngle) % sweepAngle;
    return normalized < threshold || normalized > sweepAngle - threshold;
  }

  double _angleTo(Offset position) {
    final center = _widgetSize.center(Offset.zero);
    return atan2(position.dy - center.dy, position.dx - center.dx);
  }

  void _panStart(DragStartDetails details) {
    if (_isSpinning) return;
    _previousAngle = _angleTo(details.localPosition);
  }

  void _panUpdate(DragUpdateDetails details) {
    if (_isSpinning) return;
    final currentAngle = _angleTo(details.localPosition);
    var delta = currentAngle - _previousAngle;
    if (delta > pi) delta -= 2 * pi;
    if (delta < -pi) delta += 2 * pi;
    _lastPosition = details.localPosition;
    setState(() {
      _wheelAngle += delta;
    });
    _spinController.value = _wheelAngle;
    _previousAngle = currentAngle;
  }

  void _panEnd(DragEndDetails details) {
    if (_isSpinning) return;

    final v = details.velocity.pixelsPerSecond;
    final speed = v.distance;
    if (speed < 200) return;

    final r = _lastPosition - _widgetSize.center(Offset.zero);
    _spinDirection = (r.dx * v.dy - r.dy * v.dx) >= 0 ? 1 : -1;
    _lastVelocity = speed;
    context.read<WheelCubit>().spin();
  }

  double _lastVelocity = 0;
  Offset _lastPosition = Offset.zero;
  int _spinDirection = 1;

  void _spinTo(double targetDegrees, double velocity) {
    _isSpinning = true;
    _petalScaleController.animateTo(1.0 / 1.5, curve: Curves.easeOutCubic);
    _flowerReversed = true;

    final targetRadians = targetDegrees * pi / 180;
    final direction = _spinDirection;

    final currentNormalized = ((_wheelAngle % (2 * pi)) + 2 * pi) % (2 * pi);
    var offsetToTarget = targetRadians - currentNormalized;
    if (direction >= 0) {
      if (offsetToTarget < 0) offsetToTarget += 2 * pi;
    } else {
      if (offsetToTarget > 0) offsetToTarget -= 2 * pi;
    }

    final extraSpins = (3 + (velocity / 1000).clamp(0, 5)).toInt();
    final targetAngle = _wheelAngle + direction * extraSpins * 2 * pi + offsetToTarget;

    final duration = Duration(milliseconds: (3000 + (velocity * 2).clamp(0, 3000)).toInt());

    _spinController
        .animateTo(
          targetAngle,
          duration: duration,
          curve: Curves.easeOutCubic,
        )
        .then((_) {
          _isSpinning = false;
          _petalScaleController.animateTo(1.0, curve: Curves.easeOutCubic);
          context.read<WheelCubit>().onSpinComplete();
        });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          _widgetSize = Size(constraints.maxWidth, constraints.maxHeight);
          return BlocListener<WheelCubit, WheelState>(
            listener: (context, state) {
              if (state is WheelSpinning) {
                _spinTo(state.targetDegrees, _lastVelocity);
              }
            },
            child: GestureDetector(
              onPanStart: _panStart,
              onPanUpdate: _panUpdate,
              onPanEnd: _panEnd,
              child: AnimatedBuilder(
                animation: Listenable.merge([_flowerController, _petalScaleController]),
                builder: (context, child) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: Transform.rotate(
                          angle: _wheelAngle,
                          child: CustomPaint(
                            painter: _WheelPainter(colors: _wheelColors),
                            foregroundPainter: _FlowerPainter(
                              progress: _flowerController.value,
                              petalScale: _petalScaleController.value,
                              reversed: _flowerReversed,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _ArrowPainter(tiltAngle: _arrowAngle),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final List<Color> colors;
  final double rimWidth;

  static const _shadowBlur = 5.0;
  static const _shadowSpread = 10.0;
  static final _shadowColor = Colors.black.withValues(alpha: 0.2);

  _WheelPainter({required this.colors, this.rimWidth = 16});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = min(size.width, size.height) / 2;
    final sectorRadius = outerRadius - rimWidth;
    final sectorRect = Rect.fromCircle(center: center, radius: sectorRadius);
    final sectorCount = colors.length;
    final sweepAngle = 2 * pi / sectorCount;

    final shadowPaint = Paint()
      ..color = _shadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _shadowBlur);

    canvas.drawCircle(center, outerRadius + _shadowSpread, shadowPaint);

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final sectorStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = bg
      ..strokeWidth = 3;

    for (var i = 0; i < sectorCount; i++) {
      final startAngle = i * sweepAngle - pi / 2;
      fillPaint.color = colors[i];
      canvas.drawArc(sectorRect, startAngle, sweepAngle, true, fillPaint);
    }

    for (var i = 0; i < sectorCount; i++) {
      final startAngle = i * sweepAngle - pi / 2;
      canvas.drawArc(sectorRect, startAngle, sweepAngle, true, sectorStrokePaint);
    }

    canvas.save();
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: center, radius: sectorRadius)),
    );
    final innerShadowPaint = Paint()
      ..color = _shadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _shadowBlur)
      ..style = PaintingStyle.stroke
      ..strokeWidth = _shadowSpread * 2;
    canvas.drawCircle(center, sectorRadius, innerShadowPaint);
    canvas.restore();

    final rimPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = _rimColor
      ..strokeWidth = rimWidth;
    canvas.drawCircle(center, outerRadius - rimWidth / 2, rimPaint);

    final pegCenterRadius = outerRadius - _pegInset + _pegRadius;
    final pegFill = Paint()
      ..style = PaintingStyle.fill
      ..color = _rimColor;
    final pegStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = bg
      ..strokeWidth = 2;

    for (var i = 0; i < sectorCount; i++) {
      final angle = i * sweepAngle - pi / 2;
      final pegCenter = Offset(
        center.dx + pegCenterRadius * cos(angle),
        center.dy + pegCenterRadius * sin(angle),
      );
      canvas.drawCircle(pegCenter, _pegRadius, pegFill);
      canvas.drawCircle(pegCenter, _pegRadius, pegStroke);
    }
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) => oldDelegate.colors != colors || oldDelegate.rimWidth != rimWidth;
}

class _FlowerPainter extends CustomPainter {
  final double progress;
  final double petalScale;
  final bool reversed;

  static const _petalCount = 6;
  static const _petalColor = Color(0xFFE88B8B);
  static const _centerColor = Color(0xFFFFF176);

  _FlowerPainter({required this.progress, this.petalScale = 1.0, this.reversed = false});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = min(size.width, size.height) / 2;
    final baseRadius = outerRadius * 0.22;
    final centerRadius = outerRadius * 0.1;

    final rotation = (reversed ? -progress : progress) * 2 * pi;
    final animatedScale = petalScale * (1.0 + 0.1 * sin(progress * 2 * pi));

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    final petalFill = Paint()
      ..style = PaintingStyle.fill
      ..color = _petalColor;
    final petalStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = bg
      ..strokeWidth = 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    final anchorOffset = centerRadius / 2;

    for (var i = 0; i < _petalCount; i++) {
      final angle = i * 2 * pi / _petalCount;
      final petalHeight = baseRadius * 1.5 * animatedScale;
      final petalWidth = baseRadius * 0.7 * animatedScale;

      canvas.save();
      canvas.rotate(angle);

      final petalRect = Rect.fromCenter(
        center: Offset(0, -anchorOffset - petalHeight / 2),
        width: petalWidth,
        height: petalHeight,
      );
      final shadowRect = petalRect.shift(const Offset(0, 4));

      canvas.drawOval(shadowRect, shadowPaint);
      canvas.drawOval(petalRect, petalFill);
      canvas.drawOval(petalRect, petalStroke);
      canvas.restore();
    }

    final centerFill = Paint()
      ..style = PaintingStyle.fill
      ..color = _centerColor;
    final centerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = bg
      ..strokeWidth = 2;

    canvas.drawCircle(const Offset(0, 4), centerRadius, shadowPaint);
    canvas.drawCircle(Offset.zero, centerRadius, centerFill);
    canvas.drawCircle(Offset.zero, centerRadius, centerStroke);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _FlowerPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.petalScale != petalScale || oldDelegate.reversed != reversed;
}

class _ArrowPainter extends CustomPainter {
  final double tiltAngle;

  static const _arrowWidth = 46.0;
  static const _arrowHeight = 70.0;
  static const _pivotRadius = 5.0;

  _ArrowPainter({this.tiltAngle = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = min(size.width, size.height) / 2;
    final rimTop = center.dy - outerRadius;

    final arrowTop = rimTop - 20;
    final pivotY = arrowTop + _arrowHeight * 0.25;

    canvas.save();
    canvas.translate(center.dx, pivotY);
    canvas.rotate(tiltAngle);
    canvas.translate(-center.dx, -pivotY);

    final arrowBottom = arrowTop + _arrowHeight;

    final topLeft = Offset(center.dx - _arrowWidth / 2, arrowTop);
    final topRight = Offset(center.dx + _arrowWidth / 2, arrowTop);
    final tip = Offset(center.dx, arrowBottom);

    final gradient =
        const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [secondary, primary],
        ).createShader(
          Rect.fromLTWH(topLeft.dx, arrowTop, _arrowWidth, _arrowHeight),
        );

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = bg
      ..strokeWidth = 2.5;

    final arrowPath = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..lineTo(tip.dx, tip.dy)
      ..close();
    canvas.drawPath(arrowPath, fillPaint);
    canvas.drawPath(arrowPath, strokePaint);

    final pivotFill = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(Offset(center.dx, pivotY), _pivotRadius, pivotFill);
    canvas.drawCircle(Offset(center.dx, pivotY), _pivotRadius, strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) => oldDelegate.tiltAngle != tiltAngle;
}
