import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BalanceLocalSource {
  int getBalance();
  Stream<int> watchBalance();
  Future<void> addCoins(int amount);
  Future<bool> spendCoins(int amount);
}

@Singleton(as: BalanceLocalSource)
class BalanceLocalSourceImpl implements BalanceLocalSource {
  static const _key = 'balance';
  static const _initialBalance = 100;

  final SharedPreferences _prefs;
  final _controller = StreamController<int>.broadcast();

  BalanceLocalSourceImpl(this._prefs) {
    _prefs.setInt(_key, _initialBalance);
  }

  @override
  int getBalance() => _prefs.getInt(_key) ?? _initialBalance;

  @override
  Stream<int> watchBalance() => _controller.stream.asBroadcastStream()..drain().ignore();

  @override
  Future<void> addCoins(int amount) async {
    final current = getBalance();
    await _prefs.setInt(_key, current + amount);
    _controller.add(getBalance());
  }

  @override
  Future<bool> spendCoins(int amount) async {
    final current = getBalance();
    if (current < amount) return false;
    await _prefs.setInt(_key, current - amount);
    _controller.add(getBalance());
    return true;
  }
}
