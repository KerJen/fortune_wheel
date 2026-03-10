import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/gift/gift.dart';
import '../../../data/model/inventory_item/inventory_item.dart';
import '../../../injection.dart';
import '../../colors.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widgets/rarity_frame.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InventoryCubit>(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Center(child: _Title()),
            ),
            const SizedBox(height: 16),
            const Expanded(child: _InventoryBody()),
          ],
        ),
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

class _InventoryBody extends StatelessWidget {
  const _InventoryBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        return switch (state) {
          InventoryLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          InventoryLoaded(:final items) => items.isEmpty ? const _EmptyState() : _ItemList(items: items),
        };
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Пока пусто — крути колесо!',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: hint),
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  final List<InventoryItem> items;

  const _ItemList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _ItemCard(item: items[index])
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

class _ItemCard extends StatelessWidget {
  final InventoryItem item;

  const _ItemCard({required this.item});

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
            rarity: item.gift.rarity,
            child: _GiftImage(
              imagePath: switch (item.gift) {
                RegularGift(:final imagePath) => imagePath,
                CoinGift() => null,
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.gift.name,
              style: textTheme.bodyLarge,
            ),
          ),
          Text(
            'x${item.count}',
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
