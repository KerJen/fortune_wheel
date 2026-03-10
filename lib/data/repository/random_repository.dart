import 'package:injectable/injectable.dart';

import '../exception/network_exception.dart';
import '../source/network/random_network_source.dart';

abstract class RandomRepository {
  Future<int> getRandomNumber(int max);
}

@Injectable(as: RandomRepository)
class RandomRepositoryImpl implements RandomRepository {
  final RandomNetworkSource _networkSource;

  RandomRepositoryImpl(this._networkSource);

  @override
  Future<int> getRandomNumber(int max) async {
    try {
      return (await _networkSource.getRandomNumber(max));
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}
