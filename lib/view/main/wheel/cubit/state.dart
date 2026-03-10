import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/model/gift/gift.dart';

part 'state.freezed.dart';

@freezed
sealed class WheelState with _$WheelState {
  const factory WheelState.idle({
    required int balance,
    double? savedDegrees,
  }) = WheelIdle;

  const factory WheelState.spinning({
    required int balance,
  }) = WheelSpinning;

  const factory WheelState.landing({
    required int balance,
    required Gift targetGift,
  }) = WheelLanding;

  const factory WheelState.stopped({
    required int balance,
    required Gift wonGift,
  }) = WheelStopped;
}
