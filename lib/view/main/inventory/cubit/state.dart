import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/model/inventory_item/inventory_item.dart';

part 'state.freezed.dart';

@freezed
sealed class InventoryState with _$InventoryState {
  const factory InventoryState.loading() = InventoryLoading;
  const factory InventoryState.loaded({required List<InventoryItem> items}) =
      InventoryLoaded;
}
