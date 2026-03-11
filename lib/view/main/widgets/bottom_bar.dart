import 'dart:ui';

import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../dimens.dart';

const double bottomBarTotalHeight = 70;

class BottomBarItemData {
  final Widget icon;
  final String title;

  const BottomBarItemData({required this.icon, required this.title});
}

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomBarItemData> items;

  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

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
            height: bottomBarTotalHeight,
            padding: const EdgeInsets.symmetric(horizontal: spacing10),
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

            final child = AnimatedContainer(
              duration: _duration,
              decoration: BoxDecoration(
                color: isSelected ? surface.withValues(alpha: 0.5) : Colors.transparent,
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
            );

            if (!isSelected) return child;

            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
