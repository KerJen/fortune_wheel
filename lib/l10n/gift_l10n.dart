import 'package:flutter/widgets.dart';

import '../../data/model/gift/gift.dart';
import 'app_localizations.dart';

extension GiftL10n on Gift {
  String localizedName(BuildContext context) {
    final s = S.of(context);
    return switch (name) {
      'bouquet' => s.giftBouquet,
      'tulip' => s.giftTulip,
      'perfume' => s.giftPerfume,
      'chocolates' => s.giftChocolates,
      'sock' => s.giftSock,
      'car' => s.giftCar,
      'kiss' => s.giftKiss,
      'hearts' => s.giftHearts,
      _ => name,
    };
  }
}
