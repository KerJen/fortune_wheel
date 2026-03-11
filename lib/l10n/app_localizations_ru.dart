// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SRu extends S {
  SRu([String locale = 'ru']) : super(locale);

  @override
  String get tabWheel => 'Колесо';

  @override
  String get tabGifts => 'Подарки';

  @override
  String get tabCredits => 'Авторы';

  @override
  String get spin => 'Крутить!';

  @override
  String get inventoryTitle => 'ИНВЕНТАРЬ';

  @override
  String get inventoryEmpty => 'Пока пусто — крути колесо!';

  @override
  String get creditsTitle => 'АВТОРЫ';

  @override
  String get creditsRoleDev => 'Разработка и UX/UI';

  @override
  String get creditsRoleGraphics => 'Графика';

  @override
  String get ok => 'OK';

  @override
  String get collect => 'Получить';

  @override
  String get errorNotEnoughCoins => 'Недостаточно монет для вращения';

  @override
  String get errorNoConnection => 'Нет связи с сервером. Монеты возвращены';

  @override
  String get errorSpin => 'Ошибка при вращении. Монеты возвращены';

  @override
  String get errorTooManyRequests =>
      'Слишком много запросов. Подождите немного';

  @override
  String get errorSaveGift => 'Не удалось сохранить подарок';

  @override
  String get giftBouquet => 'Букет';

  @override
  String get giftTulip => 'Тюльпан';

  @override
  String get giftPerfume => 'Духи';

  @override
  String get giftChocolates => 'Коробка конфет';

  @override
  String get giftSock => 'Носок';

  @override
  String get giftCar => 'Машина';

  @override
  String get giftKiss => 'Поцелуй';

  @override
  String get giftHearts => '50 сердечек';
}
