import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift.freezed.dart';
part 'gift.g.dart';

enum GiftRarity {
  common(weight: 40, soundAsset: 'assets/sounds/common_win.mp3'),
  rare(weight: 30, soundAsset: 'assets/sounds/rare_win.mp3'),
  epic(weight: 20, soundAsset: 'assets/sounds/epic_win.mp3'),
  legendary(weight: 10, soundAsset: 'assets/sounds/legendary_win.mp3'),
  ;

  final int weight;
  final String soundAsset;
  const GiftRarity({required this.weight, required this.soundAsset});
}

@freezed
sealed class Gift with _$Gift {
  const factory Gift.regular({
    required String name,
    String? imagePath,
    required GiftRarity rarity,
  }) = RegularGift;

  const factory Gift.coin({
    required String name,
    String? imagePath,
    required int value,
    required GiftRarity rarity,
  }) = CoinGift;

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);
}
