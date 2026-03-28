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

  @override
  String get create_plant => 'Створити рослину';

  @override
  String get basic_information => 'Основна інформація';

  @override
  String get add_photo => 'Додайте фото вашої рослини';

  @override
  String get take_photo => 'Зробити фото';

  @override
  String get upload_from_gallery => 'Завантажити з галереї';

  @override
  String get plant_name => 'Назва рослини';

  @override
  String get plant_description => 'Опис рослини';

  @override
  String get public_plant => 'Публічна рослина';

  @override
  String get public_plant_description =>
      'Коли інші люди можуть бачити вашу рослину, вони можуть вчитися від неї та допомагати вам її вирощувати';

  @override
  String get growth_stages_description =>
      'Ви можете додати етапи росту, щоб показати цю рослину. Якщо ви додасте етап росту, ви зможете мати кращий огляд того, які дії слід вживати.';

  @override
  String get stage_name => 'Назва етапу';

  @override
  String get stage_description => 'Опис етапу';

  @override
  String get duration => 'Тривалість';

  @override
  String get time_format => 'Формат часу';

  @override
  String get create_stage => 'Створити етап';

  @override
  String get plant_created_success => 'Рослину успішно додано!';

  @override
  String get light_requirements => 'Потреба в освітленні';

  @override
  String get watering_frequency => 'Частота поливу';

  @override
  String get growth_seasons => 'Сезони росту';

  @override
  String get select_option => 'Оберіть варіант';

  @override
  String get add_tags => 'Додайте теги, натисніть Enter для підтвердження';

  @override
  String get no_options_available => 'Немає доступних варіантів';
}
