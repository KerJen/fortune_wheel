import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'state.dart';

@injectable
class WheelCubit extends Cubit<WheelState> {
  WheelCubit() : super(const WheelState.idle());

  final _random = Random();

  void spin() {
    if (state is WheelSpinning) return;
    final targetDegrees = _random.nextDouble() * 360;
    emit(WheelState.spinning(targetDegrees: targetDegrees));
  }

  void onSpinComplete() {
    if (state is WheelSpinning) {
      emit(
        WheelState.stopped(
          targetDegrees: (state as WheelSpinning).targetDegrees,
        ),
      );
    }
  }
}
