import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/gift/gift.dart';
import '../../model/inventory_item/inventory_item.dart';

abstract class GiftLocalSource {
  static const wheelGifts = <Gift>[
    Gift.regular(name: 'Букет клевый крутой', imagePath: 'assets/images/icon.png', rarity: GiftRarity.rare),
    Gift.regular(name: 'Цветочек', imagePath: 'assets/images/icon.png', rarity: GiftRarity.common),
    Gift.regular(name: 'Духи', imagePath: 'assets/images/icon.png', rarity: GiftRarity.epic),
    Gift.regular(name: 'Коробка конфет', imagePath: 'assets/images/icon.png', rarity: GiftRarity.common),
    Gift.regular(name: 'Носок', imagePath: 'assets/images/icon.png', rarity: GiftRarity.common),
    Gift.regular(name: 'Машина', imagePath: 'assets/images/icon.png', rarity: GiftRarity.legendary),
    Gift.regular(name: 'Поцелуйчик', imagePath: 'assets/images/icon.png', rarity: GiftRarity.rare),
    Gift.coin(name: '50 сердечек', imagePath: 'assets/images/icon.png', value: 50, rarity: GiftRarity.epic),
  ];

  List<InventoryItem> getInventory();
  Stream<List<InventoryItem>> watchInventory();
  Future<void> addGift(Gift gift);
  Future<void> clearInventory();
}

@Singleton(as: GiftLocalSource)
class GiftLocalSourceImpl implements GiftLocalSource {
  static const _inventoryKey = 'inventory';

  final SharedPreferences _prefs;
  final _controller = StreamController<List<InventoryItem>>.broadcast();

  GiftLocalSourceImpl(this._prefs);

  @override
  List<InventoryItem> getInventory() {
    final raw = _prefs.getStringList(_inventoryKey);
    if (raw == null) return [];
    return raw
        .map((e) =>
            InventoryItem.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  @override
  Stream<List<InventoryItem>> watchInventory() => _controller.stream;

  @override
  Future<void> addGift(Gift gift) async {
    final inventory = getInventory();
    final index = inventory.indexWhere((item) => item.gift.name == gift.name);
    if (index >= 0) {
      final existing = inventory[index];
      inventory[index] = existing.copyWith(count: existing.count + 1);
    } else {
      inventory.add(InventoryItem(gift: gift, count: 1));
    }
    await _saveInventory(inventory);
    _controller.add(inventory);
  }

  @override
  Future<void> clearInventory() async {
    await _prefs.remove(_inventoryKey);
    _controller.add([]);
  }

  Future<void> _saveInventory(List<InventoryItem> inventory) async {
    final raw = inventory.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(_inventoryKey, raw);
  }
}
