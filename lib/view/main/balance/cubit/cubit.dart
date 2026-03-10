import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/repository/balance_repository.dart';
import 'state.dart';

@injectable
class BalanceCubit extends Cubit<BalanceState> {
  final BalanceRepository _balanceRepository;
  StreamSubscription? _subscription;

  BalanceCubit(this._balanceRepository)
      : super(const BalanceState(balance: 0)) {
    _init();
  }

  void _init() {
    emit(BalanceState(balance: _balanceRepository.getBalance()));

    _subscription = _balanceRepository.watchBalance().listen((balance) {
      emit(BalanceState(balance: balance));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
