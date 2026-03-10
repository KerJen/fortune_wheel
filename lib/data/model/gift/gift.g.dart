// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegularGift _$RegularGiftFromJson(Map<String, dynamic> json) => RegularGift(
  name: json['name'] as String,
  imagePath: json['imagePath'] as String?,
  rarity: $enumDecode(_$GiftRarityEnumMap, json['rarity']),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$RegularGiftToJson(RegularGift instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imagePath': instance.imagePath,
      'rarity': _$GiftRarityEnumMap[instance.rarity]!,
      'runtimeType': instance.$type,
    };

const _$GiftRarityEnumMap = {
  GiftRarity.common: 'common',
  GiftRarity.rare: 'rare',
  GiftRarity.epic: 'epic',
  GiftRarity.legendary: 'legendary',
};

CoinGift _$CoinGiftFromJson(Map<String, dynamic> json) => CoinGift(
  name: json['name'] as String,
  imagePath: json['imagePath'] as String?,
  value: (json['value'] as num).toInt(),
  rarity: $enumDecode(_$GiftRarityEnumMap, json['rarity']),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$CoinGiftToJson(CoinGift instance) => <String, dynamic>{
  'name': instance.name,
  'imagePath': instance.imagePath,
  'value': instance.value,
  'rarity': _$GiftRarityEnumMap[instance.rarity]!,
  'runtimeType': instance.$type,
};
