import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/model/gift/gift.dart';

part 'state.freezed.dart';

@freezed
sealed class WheelState with _$WheelState {
  const factory WheelState.idle({
    double? savedDegrees,
  }) = WheelIdle;

  const factory WheelState.spinning() = WheelSpinning;

  const factory WheelState.landing({
    required Gift targetGift,
  }) = WheelLanding;

  const factory WheelState.stopped({
    required Gift wonGift,
  }) = WheelStopped;

  const factory WheelState.failure({
    required String message,
  }) = WheelFailure;
}
