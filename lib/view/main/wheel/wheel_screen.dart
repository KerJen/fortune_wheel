import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../injection.dart';
import '../../colors.dart';
import 'cubit/cubit.dart';
import 'widgets/fortune_wheel.dart';

class WheelScreen extends StatelessWidget {
  const WheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WheelCubit>(),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const _Logo(),
              const Spacer(),
              const SizedBox(
                width: 300,
                height: 300,
                child: FortuneWheel(),
              ),
              const SizedBox(height: 30),
              const _Balance(),
              const Spacer(),
              const _SpinButton(),
              const SizedBox(height: 10),
              const _SpinPrice(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: 64,
    );
  }
}

class _Balance extends StatelessWidget {
  const _Balance();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Symbols.favorite_rounded),
          const SizedBox(width: 10),
          Text(
            '100',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpinButton extends StatelessWidget {
  const _SpinButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [primary, secondary]),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: () {},
          child: Text(
            'Spin!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: bg,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _SpinPrice extends StatelessWidget {
  const _SpinPrice();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Symbols.favorite_rounded, color: hint, size: 16),
        const SizedBox(width: 4),
        Text(
          '10',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: hint),
        ),
      ],
    );
  }
}
