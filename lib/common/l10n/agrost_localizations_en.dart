// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'agrost_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get sign_in => 'Sign in';

  @override
  String get sign_out => 'Sign out';

  @override
  String get sign_up => 'Sign up';

  @override
  String get sign_up_success => 'Account created! Check your email to confirm.';

  @override
  String get fields => 'Fields';

  @override
  String get plants => 'Plants';

  @override
  String get profile => 'Profile';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirm_password => 'Confirm password';

  @override
  String get field_required => 'Required field';

  @override
  String get field_incorrect => 'This field is incorrect';

  @override
  String get my_plants => 'My plants';

  @override
  String get plant_market => 'Plant market';

  @override
  String get plant_family => 'Plant family';

  @override
  String get soil_type => 'Soil type';

  @override
  String get description => 'Description';

  @override
  String get plant_published_publicly => 'Plant is published publicly';

  @override
  String get growth_stages => 'Growth stages';

  @override
  String weeks(num weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks weeks',
      one: '$weeks week',
    );
    return '$_temp0';
  }

  @override
  String days(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '$days day',
    );
    return '$_temp0';
  }
}
