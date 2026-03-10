import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

abstract class RandomNetworkSource {
  Future<int> getRandomNumber(int max);
}

@Singleton(as: RandomNetworkSource)
class RandomNetworkSourceImpl implements RandomNetworkSource {
  final Client _client;

  RandomNetworkSourceImpl(this._client);

  @override
  Future<int> getRandomNumber(int max) async {
    final uri = Uri.parse(
      'https://www.randomnumberapi.com/api/v1.0/random?min=0&max=$max&count=1',
    );
    final response = await _client.get(uri).timeout(const Duration(seconds: 5));
    if (response.statusCode != 200) throw Exception('API error: ${response.statusCode}');
    final list = jsonDecode(response.body) as List;
    return list[0] as int;
  }
}
