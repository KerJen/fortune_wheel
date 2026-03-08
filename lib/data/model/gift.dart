enum GiftRarity { common, rare, epic, legendary }

class Gift {
  final String name;
  final String? imagePath;
  final GiftRarity rarity;
  final int count;

  const Gift({
    required this.name,
    this.imagePath,
    required this.rarity,
    required this.count,
  });
}
