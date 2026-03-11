import 'package:injectable/injectable.dart';

import '../exception/network_exception.dart';
import '../source/network/random_network_source.dart';

abstract class RandomRepository {
  Future<int> getRandomNumber(int max);
}

@Injectable(as: RandomRepository)
class RandomRepositoryImpl implements RandomRepository {
  static const _batchSize = 5;

  final RandomNetworkSource _networkSource;
  final List<int> _cache = [];
  int? _cachedMax;

  RandomRepositoryImpl(this._networkSource);

  @override
  Future<int> getRandomNumber(int max) async {
    if (_cache.isNotEmpty && _cachedMax == max) return _cache.removeAt(0);

    try {
      final numbers = await _networkSource.getRandomNumbers(max, _batchSize);
      _cachedMax = max;
      _cache
        ..clear()
        ..addAll(numbers);
      return _cache.removeAt(0);
    } on TooManyRequestsException {
      rethrow;
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}
