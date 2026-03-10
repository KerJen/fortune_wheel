import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../data/model/gift/gift.dart';
import '../../../injection.dart';
import '../../colors.dart';
import '../balance/balance.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widgets/fortune_wheel.dart';
import 'widgets/gift_reveal_overlay.dart';

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
  OverlayEntry? _revealOverlay;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = context.read<WheelCubit>();
    _wheelController
      ..onSpin = cubit.spin
      ..onSpinComplete = (degrees) => cubit.onSpinComplete(degrees);
    _wheelController.onLongPressCenter = cubit.resetBalance;
  }

  @override
  void dispose() {
    _revealOverlay?.remove();
    super.dispose();
  }

  void _showGiftReveal(Gift gift) {
    _revealOverlay?.remove();
    _revealOverlay = OverlayEntry(
      builder: (_) => GiftRevealOverlay(
        wonGift: gift,
        onCollect: _dismissReveal,
      ),
    );
    Overlay.of(context).insert(_revealOverlay!);
  }

  void _dismissReveal() {
    _revealOverlay?.remove();
    _revealOverlay = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WheelCubit, WheelState>(
      listener: (context, state) {
        if (state is WheelSpinning) {
          _wheelController.startFreeSpin();
        } else if (state is WheelLanding) {
          _wheelController.spinTo(state.targetGift, 1000);
        } else if (state is WheelStopped) {
          _showGiftReveal(state.wonGift);
        } else if (state is WheelFailure) {
          _wheelController.stopSpin();
          showDialog(
            context: context,
            barrierColor: Colors.black87,
            builder: (_) => _FailureDialog(message: state.message),
          );
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
              const Balance(),
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

class _SpinButton extends StatelessWidget {
  const _SpinButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WheelCubit, WheelState>(
      builder: (context, state) {
        final isSpinning = state is WheelSpinning || state is WheelLanding || state is WheelStopped;

        return AnimatedOpacity(
          opacity: isSpinning ? 0.5 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            width: 200,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [primary, secondary]),
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onPressed: isSpinning ? null : () => context.read<WheelCubit>().spin(),
                child: Text(
                  'Spin!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: bg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FailureDialog extends StatelessWidget {
  final String message;

  const _FailureDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: hint, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Symbols.error_rounded, color: primary, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(colors: [primary, secondary]),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: bg,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ],
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
