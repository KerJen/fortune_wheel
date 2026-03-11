import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../l10n/app_localizations.dart';
import '../colors.dart';
import 'credits/credits_screen.dart';
import 'inventory/inventory_screen.dart';
import 'wheel/wheel_screen.dart';
import 'widgets/bottom_bar.dart';

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
        children: const [
          WheelScreen(),
          InventoryScreen(),
          CreditsScreen(),
        ],
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomBarItemData(
            icon: SvgPicture.asset('assets/icons/wheel.svg', width: 24, height: 24),
            title: S.of(context).tabWheel,
          ),
          BottomBarItemData(
            icon: const Icon(Symbols.inventory_2_rounded),
            title: S.of(context).tabGifts,
          ),
          BottomBarItemData(
            icon: const Icon(Symbols.stylus_fountain_pen_rounded),
            title: S.of(context).tabCredits,
          ),
        ],
      ),
    );
  }
}
