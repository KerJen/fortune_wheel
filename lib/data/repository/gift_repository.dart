import 'package:injectable/injectable.dart';

import '../model/gift/gift.dart';
import '../model/inventory_item/inventory_item.dart';
import '../source/local/balance_local_source.dart';
import '../source/local/gift_local_source.dart';

abstract class GiftRepository {
  List<Gift> getWheelGifts();
  List<InventoryItem> getInventory();
  Stream<List<InventoryItem>> watchInventory();
  Future<void> claimGift(Gift gift);
}

@Injectable(as: GiftRepository)
class GiftRepositoryImpl implements GiftRepository {
  final GiftLocalSource _giftSource;
  final BalanceLocalSource _balanceSource;

  GiftRepositoryImpl(this._giftSource, this._balanceSource);

  @override
  List<Gift> getWheelGifts() => GiftLocalSource.wheelGifts;

  @override
  List<InventoryItem> getInventory() => _giftSource.getInventory();

  @override
  Stream<List<InventoryItem>> watchInventory() => _giftSource.watchInventory();

  @override
  Future<void> claimGift(Gift gift) async {
    switch (gift) {
      case CoinGift(:final value):
        await _balanceSource.addCoins(value);
      case RegularGift():
        await _giftSource.addGift(gift);
    }
  }
}
