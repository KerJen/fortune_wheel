import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../data/model/inventory_item/inventory_item.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/gift_l10n.dart';
import '../../colors.dart';
import '../../di/injection.dart';
import '../../dimens.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/gift_image.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widgets/rarity_frame.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InventoryCubit>(),
      child: const SafeArea(
        bottom: false,
        child: Column(
          children: [
            _InventoryHeader(),
            SizedBox(height: spacing15),
            Expanded(child: _InventoryBody()),
          ],
        ),
      ),
    );
  }
}

class _InventoryHeader extends StatelessWidget {
  const _InventoryHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: spacing15, left: spacing25, right: spacing25),
      child: Row(
        children: [
          const SizedBox(width: spacing50),
          Expanded(
            child: Center(
              child: Text(
                S.of(context).inventoryTitle,
                style: const TextStyle(
                  color: secondary,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          BlocBuilder<InventoryCubit, InventoryState>(
            builder: (context, state) {
              final hasItems = state is InventoryLoaded && state.items.isNotEmpty;
              return IconButton(
                onPressed: hasItems ? () => context.read<InventoryCubit>().clearInventory() : null,
                icon: Icon(Symbols.delete_rounded, color: hasItems ? hint : hint.withValues(alpha: 0.3)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InventoryBody extends StatefulWidget {
  const _InventoryBody();

  @override
  State<_InventoryBody> createState() => _InventoryBodyState();
}

class _InventoryBodyState extends State<_InventoryBody> {
  static const _itemDuration = 250;
  static const _staggerDelay = 80;

  List<InventoryItem> _displayItems = [];
  bool _isClearing = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryCubit, InventoryState>(
      listener: (context, state) {
        if (state is! InventoryLoaded) return;
        if (state.items.isEmpty && _displayItems.isNotEmpty && !_isClearing) {
          _animateClear();
        }
      },
      builder: (context, state) {
        if (state is InventoryLoaded && !_isClearing) {
          _displayItems = List.of(state.items);
        }
        if (_displayItems.isEmpty && !_isClearing) {
          return const _EmptyState();
        }
        return _ItemList(
          items: _displayItems,
          isClearing: _isClearing,
        );
      },
    );
  }

  void _animateClear() {
    setState(() => _isClearing = true);
    final totalMs = _displayItems.length * _staggerDelay + _itemDuration;
    Future.delayed(Duration(milliseconds: totalMs), () {
      if (mounted) {
        setState(() {
          _displayItems = [];
          _isClearing = false;
        });
      }
    });
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).inventoryEmpty,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: hint),
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  final List<InventoryItem> items;
  final bool isClearing;

  const _ItemList({
    required this.items,
    required this.isClearing,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: spacing20, right: spacing20, bottom: spacing20 + bottomBarTotalHeight + spacing20),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: spacing10),
      itemBuilder: (context, index) {
        final card = _ItemCard(key: ValueKey(items[index].gift.name), item: items[index]);
        if (!isClearing) return card;
        return card
            .animate(target: 1)
            .slideX(
              begin: 0,
              end: -1.5,
              duration: 250.ms,
              curve: Curves.easeInBack,
              delay: (index * 80).ms,
            )
            .fadeOut(duration: 250.ms, delay: (index * 80).ms);
      },
    );
  }
}

class _ItemCard extends StatelessWidget {
  final InventoryItem item;

  const _ItemCard({
    required super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: hint, width: 1),
      ),
      padding: const EdgeInsets.all(spacing10),
      child: Row(
        children: [
          RarityFrame(
            rarity: item.gift.rarity,
            child: GiftImage(gift: item.gift),
          ),
          const SizedBox(width: spacing10),
          Expanded(
            child: Text(
              item.gift.localizedName(context),
              style: textTheme.bodyLarge,
            ),
          ),
          Text(
            'x${item.count}',
            style: textTheme.bodyLarge?.copyWith(color: hint),
          ),
          const SizedBox(width: spacing10),
        ],
      ),
    );
  }
}
