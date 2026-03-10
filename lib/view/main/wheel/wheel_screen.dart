import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../injection.dart';
import '../../colors.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widgets/fortune_wheel.dart';

class WheelScreen extends StatelessWidget {
  const WheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WheelCubit>(),
      child: const _WheelBody(),
    );
  }
}

class _WheelBody extends StatefulWidget {
  const _WheelBody();

  @override
  State<_WheelBody> createState() => _WheelBodyState();
}

class _WheelBodyState extends State<_WheelBody> {
  final _wheelController = FortuneWheelController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = context.read<WheelCubit>();
    _wheelController
      ..onSpin = cubit.spin
      ..onSpinComplete = (degrees) => cubit.onSpinComplete(degrees);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WheelCubit, WheelState>(
      listener: (context, state) {
        if (state is WheelSpinning) {
          _wheelController.startFreeSpin();
        } else if (state is WheelLanding) {
          _wheelController.spinTo(state.targetGift, 1000);
        }
      },
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const _Logo(),
              const Spacer(),
              BlocBuilder<WheelCubit, WheelState>(
                buildWhen: (prev, curr) => false,
                builder: (context, state) {
                  final initialDegrees = switch (state) {
                    WheelIdle(:final savedDegrees) => savedDegrees ?? 0.0,
                    _ => 0.0,
                  };
                  return SizedBox(
                    width: 300,
                    height: 300,
                    child: FortuneWheel(
                      gifts: context.read<WheelCubit>().wheelGifts,
                      controller: _wheelController,
                      initialAngle: initialDegrees * pi / 180,
                    ),
                  );
                },
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
    return BlocBuilder<WheelCubit, WheelState>(
      buildWhen: (prev, curr) => prev.balance != curr.balance,
      builder: (context, state) {
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
                '${state.balance}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
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
          onPressed: () => context.read<WheelCubit>().spin(),
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
          '${WheelCubit.spinCost}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: hint),
        ),
      ],
    );
  }
}
