import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../colors.dart';
import 'credits/credits_screen.dart';
import 'inventory/inventory_screen.dart';
import 'wheel/wheel_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final _screens = const [WheelScreen(), InventoryScreen(), CreditsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: _BottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            _BottomBarItemData(
              icon: SvgPicture.asset('assets/icons/wheel.svg', width: 24, height: 24),
              label: 'Wheel',
            ),
            const _BottomBarItemData(icon: Icon(Symbols.inventory_2_rounded), label: 'Inventory'),
            const _BottomBarItemData(icon: Icon(Symbols.stylus_fountain_pen_rounded), label: 'Credits'),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItemData {
  final Widget icon;
  final String label;

  const _BottomBarItemData({required this.icon, required this.label});
}

class _BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<_BottomBarItemData> items;

  const _BottomBar({required this.currentIndex, required this.onTap, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: hint, width: 1),
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return Flexible(
              child: _BottomBarItem(
                icon: items[index].icon,
                label: items[index].label,
                isSelected: index == currentIndex,
                onTap: () => onTap(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  static const _iconSize = 24.0;
  static const _gap = 8.0;
  static const _paddingH = 20.0;

  static const _duration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final targetColor = isSelected ? primary : hint;

    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(end: targetColor),
        duration: _duration,
        curve: Curves.fastOutSlowIn,
        builder: (context, color, _) {
          final c = color ?? targetColor;

          return AnimatedContainer(
            duration: _duration,
            decoration: BoxDecoration(
              color: isSelected ? surface : surface.withValues(alpha: 0),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: _paddingH),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final showLabel = constraints.maxWidth >= _iconSize + _gap + 20;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconTheme(
                      data: IconThemeData(color: c, size: _iconSize),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
                        child: icon,
                      ),
                    ),
                    if (showLabel) ...[
                      const SizedBox(width: _gap),
                      Flexible(
                        child: Text(
                          label,
                          style: TextStyle(color: c, fontSize: 16, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
