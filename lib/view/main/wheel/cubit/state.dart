import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
sealed class WheelState with _$WheelState {
  const factory WheelState.idle() = WheelIdle;
  const factory WheelState.spinning({required double targetDegrees}) = WheelSpinning;
  const factory WheelState.stopped({required double targetDegrees}) = WheelStopped;
}
