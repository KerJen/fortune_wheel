import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../data/model/gift/gift.dart';
import '../../../colors.dart';

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

class FortuneWheelController {
  _FortuneWheelState? _state;

  VoidCallback? onSpin;
  void Function(double degrees)? onSpinComplete;

  void startFreeSpin() {
    _state?._startFreeSpin();
  }

  void spinTo(Gift gift, double velocity) {
    _state?._spinTo(gift, velocity);
  }

  void _attach(_FortuneWheelState state) => _state = state;
  void _detach() => _state = null;
}

class FortuneWheel extends StatefulWidget {
  final List<Gift> gifts;
  final FortuneWheelController controller;
  final double initialAngle;

  const FortuneWheel({
    super.key,
    required this.gifts,
    required this.controller,
    this.initialAngle = 0,
  });

  @override
  State<FortuneWheel> createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheel> with TickerProviderStateMixin {
  late final AnimationController _flowerController;
  late final AnimationController _spinController;
  late final AnimationController _petalScaleController;

  late final Ticker _physicsTicker;

  late double _wheelAngle = widget.initialAngle;
  double _previousAngle = 0;
  bool _isSpinning = false;
  bool _flowerReversed = false;
  Size _widgetSize = Size.zero;

  double _arrowAngle = 0;
  double _arrowVelocity = 0;
  double _prevWheelAngle = 0;
  Duration _lastTickTime = Duration.zero;

  static const _arrowGravity = 40.0;
  static const _arrowDamping = 6.0;
  static const _maxArrowAngle = 0.4;
  static const _minFlingSpeed = 200.0;
  static const _freeSpinRevolutions = 100;
  static const _freeSpinDuration = Duration(seconds: 50);

  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
    _flowerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _spinController = AnimationController(
      vsync: this,
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
      value: widget.initialAngle,
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
  void didUpdateWidget(FortuneWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._detach();
      widget.controller._attach(this);
    }
  }

  @override
  void dispose() {
    widget.controller._detach();
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
      _arrowVelocity += (-_arrowGravity * sin(_arrowAngle) - _arrowDamping * _arrowVelocity) * dt;
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
    if (speed < _minFlingSpeed) return;

    final r = _lastPosition - _widgetSize.center(Offset.zero);
    _spinDirection = (r.dx * v.dy - r.dy * v.dx) >= 0 ? 1 : -1;
    widget.controller.onSpin?.call();
  }

  Offset _lastPosition = Offset.zero;
  int _spinDirection = 1;

  void _startFreeSpin() {
    _isSpinning = true;
    _petalScaleController.animateTo(1.0 / 1.5, curve: Curves.easeOutCubic);
    _flowerReversed = true;

    final direction = _spinDirection;
    final target = _wheelAngle + direction * _freeSpinRevolutions * 2 * pi;
    _spinController.animateTo(
      target,
      duration: _freeSpinDuration,
      curve: Curves.linear,
    );
  }

  static const _sectorPadding = 0.15;
  static const _easeOutCubicDerivativeAtZero = 3.0;
  static const _minLandingExtraSpins = 3;

  void _spinTo(Gift gift, double velocity) {
    final freeSpinSpeed = _freeSpinRevolutions * 2 * pi / _freeSpinDuration.inMilliseconds * 1000;

    _spinController.stop();
    _isSpinning = true;

    final giftIndex = widget.gifts.indexOf(gift);
    final segmentCount = widget.gifts.length;
    final segmentAngle = 2 * pi / segmentCount;
    final paddedRange = segmentAngle * (1 - 2 * _sectorPadding);
    final randomOffset = _sectorPadding * segmentAngle + Random().nextDouble() * paddedRange;
    final targetRadians = -(giftIndex * segmentAngle + randomOffset);

    final direction = _spinDirection;

    final currentNormalized = ((_wheelAngle % (2 * pi)) + 2 * pi) % (2 * pi);
    final targetNormalized = ((targetRadians % (2 * pi)) + 2 * pi) % (2 * pi);
    var offsetToTarget = targetNormalized - currentNormalized;
    if (direction >= 0) {
      if (offsetToTarget < 0) offsetToTarget += 2 * pi;
    } else {
      if (offsetToTarget > 0) offsetToTarget -= 2 * pi;
    }

    final totalDistance = direction * _minLandingExtraSpins * 2 * pi + offsetToTarget;
    final durationSeconds = totalDistance.abs() * _easeOutCubicDerivativeAtZero / freeSpinSpeed;
    final durationMs = (durationSeconds * 1000).round().clamp(2000, 10000);

    final targetAngle = _wheelAngle + totalDistance;

    _spinController
        .animateTo(
          targetAngle,
          duration: Duration(milliseconds: durationMs),
          curve: Curves.easeOutCubic,
        )
        .then((_) {
          _isSpinning = false;
          _petalScaleController.animateTo(1.0, curve: Curves.easeOutCubic);
          final normalizedDegrees = ((_wheelAngle % (2 * pi)) + 2 * pi) % (2 * pi) * 180 / pi;
          widget.controller.onSpinComplete?.call(normalizedDegrees);
        });
  }

  @override
  Widget build(BuildContext context) {
    final labels = widget.gifts.map((g) => g.name).toList();

    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          _widgetSize = Size(constraints.maxWidth, constraints.maxHeight);
          return GestureDetector(
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
                          painter: _WheelPainter(
                            colors: _wheelColors,
                            labels: labels,
                          ),
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
          );
        },
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final List<Color> colors;
  final List<String> labels;
  final double rimWidth;

  static const _shadowBlur = 5.0;
  static const _shadowSpread = 10.0;
  static final _shadowColor = Colors.black.withValues(alpha: 0.2);

  _WheelPainter({required this.colors, required this.labels, this.rimWidth = 16});

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

    for (var i = 0; i < sectorCount && i < labels.length; i++) {
      final midAngle = i * sweepAngle - pi / 2 + sweepAngle / 2;
      final textRadius = sectorRadius * 0.6;

      canvas.save();
      canvas.translate(
        center.dx + textRadius * cos(midAngle),
        center.dy + textRadius * sin(midAngle),
      );
      canvas.rotate(midAngle + pi / 2);

      final paragraph = _buildParagraph(labels[i], sectorRadius * 0.45);
      canvas.drawParagraph(
        paragraph,
        Offset(-paragraph.maxIntrinsicWidth / 2, -paragraph.height / 2),
      );
      canvas.restore();
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

  ui.Paragraph _buildParagraph(String text, double maxWidth) {
    final builder =
        ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.center,
              maxLines: 2,
              ellipsis: '…',
            ),
          )
          ..pushStyle(
            ui.TextStyle(
              color: bg,
              fontSize: 9,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w600,
            ),
          )
          ..addText(text);
    return builder.build()..layout(ui.ParagraphConstraints(width: maxWidth));
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) =>
      oldDelegate.colors != colors || oldDelegate.labels != labels || oldDelegate.rimWidth != rimWidth;
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
