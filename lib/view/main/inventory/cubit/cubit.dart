import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/model/inventory_item/inventory_item.dart';
import '../../../../data/repository/gift_repository.dart';
import 'state.dart';

@injectable
class InventoryCubit extends Cubit<InventoryState> {
  final GiftRepository _giftRepository;
  StreamSubscription? _subscription;

  InventoryCubit(this._giftRepository) : super(const InventoryState.loading()) {
    _init();
  }

  void _init() {
    emit(InventoryState.loaded(items: _sortByRarity(_giftRepository.getInventory())));
    _subscription = _giftRepository.watchInventory().listen((items) {
      emit(InventoryState.loaded(items: _sortByRarity(items)));
    });
  }

  List<InventoryItem> _sortByRarity(List<InventoryItem> items) {
    return [...items]..sort((a, b) => b.gift.rarity.index.compareTo(a.gift.rarity.index));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
