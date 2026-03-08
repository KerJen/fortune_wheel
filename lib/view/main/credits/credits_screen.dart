import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../colors.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 24, top: 16),
            child: _Title(),
          ),
          const Expanded(
            child: Center(
              child: _CreditsList(),
            ),
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
          'CREDITS',
          style: TextStyle(
            color: secondary,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, curve: Curves.easeOut)
        .slideX(
          begin: -0.1,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }
}

class _CreditsList extends StatelessWidget {
  const _CreditsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:
          [
                _CreditEntry(
                  role: 'Разработка и UX/UI',
                  name: 'Антон Янкин',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 32),
                _CreditEntry(
                  role: 'Графика',
                  name: 'Владислава Гусейнова',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ]
              .animate(interval: 200.ms)
              .fadeIn(duration: 500.ms, curve: Curves.easeOut)
              .slideY(
                begin: 0.15,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOut,
              ),
    );
  }
}

class _CreditEntry extends StatelessWidget {
  final String role;
  final String name;
  final TextStyle? style;

  const _CreditEntry({required this.role, required this.name, this.style});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          role,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: hint),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: style ?? Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
