import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../colors.dart';
import '../dimens.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const WheelScreen(),
          InventoryScreen(key: UniqueKey()),
          CreditsScreen(key: UniqueKey()),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: _BottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            _BottomBarItemData(
              icon: SvgPicture.asset('assets/icons/wheel.svg', width: 24, height: 24),
              title: 'Wheel',
            ),
            const _BottomBarItemData(
              icon: Icon(Symbols.inventory_2_rounded),
              title: 'Gifts',
            ),
            const _BottomBarItemData(
              icon: Icon(Symbols.stylus_fountain_pen_rounded),
              title: 'Credits',
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItemData {
  final Widget icon;
  final String title;

  const _BottomBarItemData({required this.icon, required this.title});
}

class _BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<_BottomBarItemData> items;

  const _BottomBar({required this.currentIndex, required this.onTap, required this.items});

  static const _radius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: _radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: bg.withValues(alpha: 0.6),
              borderRadius: _radius,
              border: Border.all(color: hint, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(items.length, (index) {
                return Flexible(
                  child: _BottomBarItem(
                    icon: items[index].icon,
                    title: items[index].title,
                    isSelected: index == currentIndex,
                    onTap: () => onTap(index),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  static const double _iconSize = 24;

  static const _duration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final targetColor = isSelected ? primary : hint;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: targetColor),
          duration: _duration,
          curve: Curves.fastOutSlowIn,
          builder: (context, color, _) {
            final accentColor = color ?? targetColor;

            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: isSelected ? ImageFilter.blur(sigmaX: 20, sigmaY: 20) : ImageFilter.blur(),
                child: AnimatedContainer(
                  duration: _duration,
                  decoration: BoxDecoration(
                    color: isSelected ? surface.withValues(alpha: 0.5) : surface.withValues(alpha: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconTheme(
                        data: IconThemeData(color: accentColor, size: _iconSize),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(accentColor, BlendMode.srcIn),
                          child: icon,
                        ),
                      ),
                      const SizedBox(width: spacing10),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
