// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'agrost_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get sign_in => 'Ввійти';

  @override
  String get sign_out => 'Вийти';

  @override
  String get sign_up => 'Зареєструватися';

  @override
  String get sign_up_success =>
      'Акаунт створено! Перевірте пошту для підтвердження.';

  @override
  String get fields => 'Поля';

  @override
  String get plants => 'Рослини';

  @override
  String get profile => 'Профіль';

  @override
  String get email => 'Пошта';

  @override
  String get password => 'Пароль';

  @override
  String get confirm_password => 'Підтвердження паролю';

  @override
  String get field_required => 'Це поле обовʼязкове';

  @override
  String get field_incorrect => 'Це поле заповнено невірно';

  @override
  String get my_plants => 'Мої рослини';

  @override
  String get plant_market => 'Ринок рослин';

  @override
  String get plant_family => 'Родина';

  @override
  String get soil_type => 'Тип ґрунту';

  @override
  String get description => 'Опис';

  @override
  String get plant_published_publicly => 'Рослина у відкритому доступі';

  @override
  String get growth_stages => 'Growth stages';

  @override
  String weeks(num weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks тижнів',
      one: '$weeks тиждень',
    );
    return '$_temp0';
  }

  @override
  String days(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дні',
      one: '$days день',
    );
    return '$_temp0';
  }
}
