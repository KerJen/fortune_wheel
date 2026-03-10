import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../data/model/inventory_item/inventory_item.dart';
import '../../../injection.dart';
import '../../colors.dart';
import '../../dimens.dart';
import '../../common/gift_image.dart';
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
                'INVENTORY',
                style: TextStyle(
                  color: secondary,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => context.read<InventoryCubit>().clearInventory(),
            icon: const Icon(Symbols.delete_rounded, color: hint),
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

class _InventoryBodyState extends State<_InventoryBody> with TickerProviderStateMixin {
  static const _itemDuration = Duration(milliseconds: 250);
  static const _staggerDelay = Duration(milliseconds: 80);

  List<InventoryItem> _displayItems = [];
  AnimationController? _clearController;

  @override
  void dispose() {
    _clearController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryCubit, InventoryState>(
      listener: (context, state) {
        if (state is! InventoryLoaded) return;
        if (state.items.isEmpty && _displayItems.isNotEmpty && _clearController == null) {
          _animateClear();
        }
      },
      builder: (context, state) {
        if (state is InventoryLoaded && _clearController == null) {
          _displayItems = List.of(state.items);
        }
        if (_displayItems.isEmpty && _clearController == null) {
          return const _EmptyState();
        }
        return _ItemList(
          items: _displayItems,
          clearController: _clearController,
          staggerDelay: _staggerDelay,
          itemDuration: _itemDuration,
        );
      },
    );
  }

  void _animateClear() {
    final totalMs = _displayItems.length * _staggerDelay.inMilliseconds + _itemDuration.inMilliseconds;

    _clearController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalMs),
    );

    _clearController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _clearController?.dispose();
        _clearController = null;
        if (mounted) setState(() => _displayItems = []);
      }
    });

    setState(() {});
    _clearController!.forward();
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
  final AnimationController? clearController;
  final Duration staggerDelay;
  final Duration itemDuration;

  const _ItemList({
    required this.items,
    required this.clearController,
    required this.staggerDelay,
    required this.itemDuration,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: spacing20),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: spacing10),
      itemBuilder: (context, index) {
        final animation = clearController;
        if (animation == null) {
          return _ItemCard(item: items[index]);
        }

        final start = (index * staggerDelay.inMilliseconds) / animation.duration!.inMilliseconds;
        final end = start + (itemDuration.inMilliseconds / animation.duration!.inMilliseconds);

        final slide =
            Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.5, 0),
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(start.clamp(0, 1), end.clamp(0, 1), curve: Curves.easeInBack),
              ),
            );

        final fade = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(start.clamp(0, 1), end.clamp(0, 1)),
          ),
        );

        return SlideTransition(
          position: slide,
          child: FadeTransition(
            opacity: fade,
            child: _ItemCard(item: items[index]),
          ),
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
              item.gift.name,
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
