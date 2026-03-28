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

  @override
  String get create_plant => 'Create plant';

  @override
  String get basic_information => 'Basic information';

  @override
  String get add_photo => 'Add a pic of your plant';

  @override
  String get take_photo => 'Take a cute picture';

  @override
  String get upload_from_gallery => 'Upload from gallery';

  @override
  String get plant_name => 'Plant name';

  @override
  String get plant_description => 'Plant description';

  @override
  String get public_plant => 'Public plant';

  @override
  String get public_plant_description =>
      'When other people can see your plant they can learn from it and help you grow it';

  @override
  String get growth_stages_description =>
      'You can add growth stages to show this plant. If you add a growth stage, you can have a better overview of what actions should be taken.';

  @override
  String get stage_name => 'Stage name';

  @override
  String get stage_description => 'Stage description';

  @override
  String get duration => 'Duration';

  @override
  String get time_format => 'Time format';

  @override
  String get create_stage => 'Create stage';

  @override
  String get plant_created_success => 'Plant was successfully added!';

  @override
  String get light_requirements => 'Light requirements';

  @override
  String get watering_frequency => 'Watering frequency';

  @override
  String get growth_seasons => 'Growth seasons';

  @override
  String get select_option => 'Select an option';

  @override
  String get add_tags => 'Add tags, press Enter to confirm';

  @override
  String get no_options_available => 'No options available';
}
