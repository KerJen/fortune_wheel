import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift.freezed.dart';
part 'gift.g.dart';

enum GiftRarity {
  common(weight: 40),
  rare(weight: 30),
  epic(weight: 20),
  legendary(weight: 10)
  ;

  final int weight;
  const GiftRarity({required this.weight});
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
    required int value,
    required GiftRarity rarity,
  }) = CoinGift;

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);
}
