import 'package:flutter/material.dart';

import '../../../data/model/gift/gift.dart';

const _placeholder = 'assets/images/icon.png';

class GiftImage extends StatelessWidget {
  final Gift gift;
  final double size;
  final double borderRadius;

  const GiftImage({
    super.key,
    required this.gift,
    this.size = 60,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final path = gift.imagePath;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          path ?? _placeholder,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
