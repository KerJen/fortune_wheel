import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../exception/network_exception.dart';

abstract class RandomNetworkSource {
  Future<List<int>> getRandomNumbers(int max, int count);
}

@Singleton(as: RandomNetworkSource)
class RandomNetworkSourceImpl implements RandomNetworkSource {
  final Client _client;

  RandomNetworkSourceImpl(this._client);

  @override
  Future<List<int>> getRandomNumbers(int max, int count) async {
    final uri = Uri.parse(
      'https://www.randomnumberapi.com/api/v1.0/random?min=0&max=$max&count=$count',
    );
    final response = await _client.get(uri).timeout(const Duration(seconds: 5));
    if (response.statusCode == 429) throw const TooManyRequestsException();
    if (response.statusCode != 200) {
      throw Exception('API error: ${response.statusCode}');
    }
    final list = jsonDecode(response.body) as List;
    return list.cast<int>();
  }
}
