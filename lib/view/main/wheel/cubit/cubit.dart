import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/exception/network_exception.dart';
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

  static const spinCost = 10;

  List<Gift> get wheelGifts => _giftRepository.getWheelGifts();

  WheelCubit(
    this._giftRepository,
    this._balanceRepository,
    this._wheelLocalSource,
    this._randomRepository,
  ) : super(const WheelState.idle()) {
    _init();
  }

  void _init() {
    final savedDegrees = _wheelLocalSource.getSavedDegrees();
    emit(WheelState.idle(savedDegrees: savedDegrees));
  }

  Future<void> spin() async {
    if (state is WheelSpinning || state is WheelLanding) return;

    final success = await _balanceRepository.spendCoins(spinCost);
    if (!success) {
      _emitFailure('Недостаточно монет для вращения');
      return;
    }

    emit(const WheelState.spinning());

    try {
      final gifts = _giftRepository.getWheelGifts();
      final totalWeight = gifts.fold<int>(0, (sum, g) => sum + g.rarity.weight);

      final randomValue = await _randomRepository.getRandomNumber(totalWeight);

      if (isClosed || state is! WheelSpinning) return;

      final targetGift = gifts[_selectByWeight(gifts, randomValue)];

      emit(WheelState.landing(targetGift: targetGift));
    } on NetworkException {
      await _balanceRepository.addCoins(spinCost);
      if (isClosed) return;
      _emitFailure('Нет связи с сервером. Монеты возвращены');
    } catch (_) {
      await _balanceRepository.addCoins(spinCost);
      if (isClosed) return;
      _emitFailure('Ошибка при вращении. Монеты возвращены');
    }
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

    emit(WheelState.stopped(wonGift: wonGift));

    try {
      await _giftRepository.claimGift(wonGift);
      await _wheelLocalSource.saveState(degrees, wonGift);
    } catch (_) {
      emit(
        const WheelState.failure(
          message: 'Не удалось сохранить подарок',
        ),
      );
      return;
    }

    if (isClosed) return;
    emit(WheelState.idle(savedDegrees: degrees));
  }

  Future<void> resetBalance() async {
    await _balanceRepository.resetBalance();
  }

  void _emitFailure(String message) {
    final savedDegrees = _wheelLocalSource.getSavedDegrees();
    emit(WheelState.failure(message: message));
    emit(WheelState.idle(savedDegrees: savedDegrees));
  }
}
