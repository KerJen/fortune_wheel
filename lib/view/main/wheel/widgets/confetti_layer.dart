import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

const confettiColors = [
  Color(0xFFFFB3BA),
  Color(0xFFFFDFBA),
  Color(0xFFFFFBBA),
  Color(0xFFBAFFC9),
  Color(0xFFBAE1FF),
  Color(0xFFD5BAFF),
  Color(0xFFFFBAE1),
  Color(0xFFC9FFE5),
];

class ConfettiLayer extends StatelessWidget {
  final ConfettiController leftCannon;
  final ConfettiController rightCannon;
  final ConfettiController rainLeft;
  final ConfettiController rainCenter;
  final ConfettiController rainRight;

  const ConfettiLayer({
    super.key,
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
              colors: confettiColors,
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
              colors: confettiColors,
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
              colors: confettiColors,
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
              colors: confettiColors,
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
              colors: confettiColors,
            ),
          ),
        ],
      ),
    );
  }
}
