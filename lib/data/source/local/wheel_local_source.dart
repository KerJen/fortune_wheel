import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/gift/gift.dart';

abstract class WheelLocalSource {
  double? getSavedDegrees();
  Gift? getSavedWonGift();
  Future<void> saveState(double degrees, Gift wonGift);
}

@Singleton(as: WheelLocalSource)
class WheelLocalSourceImpl implements WheelLocalSource {
  static const _degreesKey = 'wheel_degrees';
  static const _wonGiftKey = 'wheel_won_gift';

  final SharedPreferences _prefs;

  WheelLocalSourceImpl(this._prefs);

  @override
  double? getSavedDegrees() => _prefs.getDouble(_degreesKey);

  @override
  Gift? getSavedWonGift() {
    final raw = _prefs.getString(_wonGiftKey);
    if (raw == null) return null;
    return Gift.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> saveState(double degrees, Gift wonGift) async {
    await _prefs.setDouble(_degreesKey, degrees);
    await _prefs.setString(_wonGiftKey, jsonEncode(wonGift.toJson()));
  }
}
