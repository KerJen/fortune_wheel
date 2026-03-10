import 'package:injectable/injectable.dart';

import '../source/local/balance_local_source.dart';

abstract class BalanceRepository {
  int getBalance();
  Stream<int> watchBalance();
  Future<void> addCoins(int amount);
  Future<bool> spendCoins(int amount);
  Future<void> resetBalance();
}

@Injectable(as: BalanceRepository)
class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceLocalSource _source;

  BalanceRepositoryImpl(this._source);

  @override
  int getBalance() => _source.getBalance();

  @override
  Stream<int> watchBalance() => _source.watchBalance();

  @override
  Future<void> addCoins(int amount) => _source.addCoins(amount);

  @override
  Future<bool> spendCoins(int amount) => _source.spendCoins(amount);

  @override
  Future<void> resetBalance() => _source.resetBalance();
}
