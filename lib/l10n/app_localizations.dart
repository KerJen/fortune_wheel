import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @tabWheel.
  ///
  /// In ru, this message translates to:
  /// **'Колесо'**
  String get tabWheel;

  /// No description provided for @tabGifts.
  ///
  /// In ru, this message translates to:
  /// **'Подарки'**
  String get tabGifts;

  /// No description provided for @tabCredits.
  ///
  /// In ru, this message translates to:
  /// **'Авторы'**
  String get tabCredits;

  /// No description provided for @spin.
  ///
  /// In ru, this message translates to:
  /// **'Крутить!'**
  String get spin;

  /// No description provided for @inventoryTitle.
  ///
  /// In ru, this message translates to:
  /// **'ИНВЕНТАРЬ'**
  String get inventoryTitle;

  /// No description provided for @inventoryEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пока пусто — крути колесо!'**
  String get inventoryEmpty;

  /// No description provided for @creditsTitle.
  ///
  /// In ru, this message translates to:
  /// **'АВТОРЫ'**
  String get creditsTitle;

  /// No description provided for @creditsRoleDev.
  ///
  /// In ru, this message translates to:
  /// **'Разработка и UX/UI'**
  String get creditsRoleDev;

  /// No description provided for @creditsRoleGraphics.
  ///
  /// In ru, this message translates to:
  /// **'Графика'**
  String get creditsRoleGraphics;

  /// No description provided for @ok.
  ///
  /// In ru, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @collect.
  ///
  /// In ru, this message translates to:
  /// **'Получить'**
  String get collect;

  /// No description provided for @errorNotEnoughCoins.
  ///
  /// In ru, this message translates to:
  /// **'Недостаточно монет для вращения'**
  String get errorNotEnoughCoins;

  /// No description provided for @errorNoConnection.
  ///
  /// In ru, this message translates to:
  /// **'Нет связи с сервером. Монеты возвращены'**
  String get errorNoConnection;

  /// No description provided for @errorSpin.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка при вращении. Монеты возвращены'**
  String get errorSpin;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In ru, this message translates to:
  /// **'Слишком много запросов. Подождите немного'**
  String get errorTooManyRequests;

  /// No description provided for @errorSaveGift.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить подарок'**
  String get errorSaveGift;

  /// No description provided for @giftBouquet.
  ///
  /// In ru, this message translates to:
  /// **'Букет'**
  String get giftBouquet;

  /// No description provided for @giftTulip.
  ///
  /// In ru, this message translates to:
  /// **'Тюльпан'**
  String get giftTulip;

  /// No description provided for @giftPerfume.
  ///
  /// In ru, this message translates to:
  /// **'Духи'**
  String get giftPerfume;

  /// No description provided for @giftChocolates.
  ///
  /// In ru, this message translates to:
  /// **'Коробка конфет'**
  String get giftChocolates;

  /// No description provided for @giftSock.
  ///
  /// In ru, this message translates to:
  /// **'Носок'**
  String get giftSock;

  /// No description provided for @giftCar.
  ///
  /// In ru, this message translates to:
  /// **'Машина'**
  String get giftCar;

  /// No description provided for @giftKiss.
  ///
  /// In ru, this message translates to:
  /// **'Поцелуй'**
  String get giftKiss;

  /// No description provided for @giftHearts.
  ///
  /// In ru, this message translates to:
  /// **'50 сердечек'**
  String get giftHearts;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'ru':
      return SRu();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
