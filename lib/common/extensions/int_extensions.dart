import 'package:flutter_gen/gen_l10n/agrost_localizations.dart';

extension DurationExtensions on int {
  String formatAsDuration(AppLocalizations strings) {
    var seconds = this;
    final weeks = seconds ~/ (Duration.secondsPerDay * 7);
    seconds -= weeks * (Duration.secondsPerDay * 7);
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    // final hours = seconds ~/ Duration.secondsPerHour;
    // seconds -= hours * Duration.secondsPerHour;
    // final minutes = seconds ~/ Duration.secondsPerMinute;
    // seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (weeks != 0) {
      tokens.add('$weeks ${strings.weeks(weeks)}');
    }
    if (days != 0) {
      tokens.add('$days ${strings.days(days)}');
    }
    // if (hours != 0) {
    //   tokens.add('$hours ${S.of(context).hours(hours)}');
    // }
    // if (minutes != 0) {
    //   tokens.add('$minutes ${S.of(context).minutes(minutes)}');
    // }
    return tokens.join(' ');
  }
}
