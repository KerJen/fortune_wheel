import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
sealed class BalanceState with _$BalanceState {
  const factory BalanceState({
    required int balance,
  }) = _BalanceState;
}
