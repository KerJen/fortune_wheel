import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/model/gift/gift.dart';
import '../../../../data/repository/balance_repository.dart';
import '../../../../data/repository/gift_repository.dart';
import '../../../../data/repository/random_repository.dart';
import '../../../../data/source/local/wheel_local_source.dart';
import 'state.dart';

@injectable
class WheelCubit extends Cubit<WheelState> {
  final GiftRepository _giftRepository;
  final BalanceRepository _balanceRepository;
  final WheelLocalSource _wheelLocalSource;
  final RandomRepository _randomRepository;
  StreamSubscription? _balanceSubscription;

  static const spinCost = 10;

  List<Gift> get wheelGifts => _giftRepository.getWheelGifts();

  WheelCubit(
    this._giftRepository,
    this._balanceRepository,
    this._wheelLocalSource,
    this._randomRepository,
  ) : super(WheelState.idle(balance: 0)) {
    _init();
  }

  void _init() {
    final balance = _balanceRepository.getBalance();
    final savedDegrees = _wheelLocalSource.getSavedDegrees();

    emit(WheelState.idle(balance: balance, savedDegrees: savedDegrees));

    _balanceSubscription = _balanceRepository.watchBalance().listen((balance) {
      emit(
        switch (state) {
          WheelIdle(:final savedDegrees) => WheelState.idle(balance: balance, savedDegrees: savedDegrees),
          WheelSpinning() => WheelState.spinning(balance: balance),
          WheelLanding(:final targetGift) => WheelState.landing(balance: balance, targetGift: targetGift),
          WheelStopped(:final wonGift) => WheelState.stopped(balance: balance, wonGift: wonGift),
        },
      );
    });
  }

  Future<void> spin() async {
    if (state is WheelSpinning || state is WheelLanding) return;
    final success = await _balanceRepository.spendCoins(spinCost);
    if (!success) return;

    emit(WheelState.spinning(balance: _balanceRepository.getBalance()));

    final gifts = _giftRepository.getWheelGifts();
    final totalWeight = gifts.fold<int>(0, (sum, g) => sum + g.rarity.weight);

    final randomValue = await _randomRepository.getRandomNumber(totalWeight);

    if (isClosed || state is! WheelSpinning) return;

    final targetGift = gifts[_selectByWeight(gifts, randomValue)];

    emit(
      WheelState.landing(
        balance: _balanceRepository.getBalance(),
        targetGift: targetGift,
      ),
    );
  }

  int _selectByWeight(List<Gift> gifts, int randomValue) {
    var cumulative = 0;
    for (var i = 0; i < gifts.length; i++) {
      cumulative += gifts[i].rarity.weight;
      if (randomValue < cumulative) return i;
    }
    return gifts.length - 1;
  }

  Future<void> onSpinComplete(double degrees) async {
    final currentState = state;
    if (currentState is! WheelLanding) return;

    final wonGift = currentState.targetGift;

    emit(
      WheelState.stopped(
        balance: _balanceRepository.getBalance(),
        wonGift: wonGift,
      ),
    );

    await _giftRepository.claimGift(wonGift);
    await _wheelLocalSource.saveState(degrees, wonGift);
  }

  @override
  Future<void> close() {
    _balanceSubscription?.cancel();
    return super.close();
  }
}
