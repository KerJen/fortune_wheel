import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../data/model/gift.dart';
import '../../colors.dart';
import 'widgets/rarity_frame.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  static const _mockGifts = [
    Gift(name: 'Букет Эустом', rarity: GiftRarity.common, count: 1),
    Gift(name: 'Духи', rarity: GiftRarity.rare, count: 2),
    Gift(name: 'Плюшевый мишка', rarity: GiftRarity.epic, count: 1),
    Gift(name: 'Кольцо', rarity: GiftRarity.legendary, count: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(child: _Title()),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _GiftList(gifts: _mockGifts),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'INVENTORY',
      style: TextStyle(
        color: secondary,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
    ).animate().fadeIn(duration: 400.ms, curve: Curves.easeOut).slideX(begin: -0.1, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}

class _GiftList extends StatelessWidget {
  final List<Gift> gifts;

  const _GiftList({required this.gifts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: gifts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _GiftCard(gift: gifts[index])
            .animate()
            .fadeIn(
              duration: 400.ms,
              delay: (100 * index).ms,
              curve: Curves.easeOut,
            )
            .slideY(
              begin: 0.1,
              end: 0,
              duration: 400.ms,
              delay: (100 * index).ms,
              curve: Curves.easeOut,
            );
      },
    );
  }
}

class _GiftCard extends StatelessWidget {
  final Gift gift;

  const _GiftCard({required this.gift});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: hint, width: 1),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          RarityFrame(
            rarity: gift.rarity,
            child: _GiftImage(imagePath: gift.imagePath),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              gift.name,
              style: textTheme.bodyLarge,
            ),
          ),
          Text(
            'x${gift.count}',
            style: textTheme.bodyMedium?.copyWith(color: hint),
          ),
        ],
      ),
    );
  }
}

class _GiftImage extends StatelessWidget {
  final String? imagePath;

  const _GiftImage({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 60,
        height: 60,
        color: Colors.transparent,
        child: imagePath != null ? Image.asset(imagePath!, fit: BoxFit.cover) : null,
      ),
    );
  }
}
