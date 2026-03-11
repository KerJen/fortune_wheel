import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../data/model/gift/gift.dart';
import '../../../l10n/app_localizations.dart';
import '../../colors.dart';
import '../../di/injection.dart';
import '../balance/balance.dart';
import '../balance/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widgets/failure_dialog.dart';
import 'widgets/fortune_wheel.dart';
import 'widgets/gift_reveal_overlay.dart';

class WheelScreen extends StatelessWidget {
  const WheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<WheelCubit>()),
        BlocProvider(create: (_) => getIt<BalanceCubit>()),
      ],
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
      ..onSpinComplete = cubit.onSpinComplete
      ..onLongPressCenter = cubit.resetBalance;
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
          final message = switch (state.error) {
            WheelError.notEnoughCoins => S.of(context).errorNotEnoughCoins,
            WheelError.noConnection => S.of(context).errorNoConnection,
            WheelError.tooManyRequests => S.of(context).errorTooManyRequests,
            WheelError.spinError => S.of(context).errorSpin,
            WheelError.saveGiftError => S.of(context).errorSaveGift,
          };
          showDialog(
            context: context,
            barrierColor: Colors.black87,
            builder: (_) => FailureDialog(message: message),
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
                  S.of(context).spin,
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
