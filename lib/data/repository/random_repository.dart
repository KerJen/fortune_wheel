import 'dart:math';

import 'package:injectable/injectable.dart';

import '../source/network/random_network_source.dart';

abstract class RandomRepository {
  Future<int> getRandomNumber(int max);
}

@Injectable(as: RandomRepository)
class RandomRepositoryImpl implements RandomRepository {
  final RandomNetworkSource _networkSource;
  final _random = Random();

  RandomRepositoryImpl(this._networkSource);

  static const _minDelay = Duration(seconds: 2);

  @override
  Future<int> getRandomNumber(int max) async {
    final stopwatch = Stopwatch()..start();
    int value;
    try {
      value = (await _networkSource.getRandomNumber(max)).clamp(0, max - 1);
    } catch (_) {
      value = _random.nextInt(max);
    }
    final elapsed = stopwatch.elapsed;
    if (elapsed < _minDelay) {
      await Future.delayed(_minDelay - elapsed);
    }
    return value;
  }
}
