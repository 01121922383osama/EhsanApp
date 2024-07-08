import 'dart:async';

import 'package:intl/intl.dart';

Stream<String> remainingTime(DateTime prayerTime) async* {
  yield* Stream.periodic(const Duration(seconds: 1), (computationCount) {
    DateTime now = DateTime.now();
    Duration remains = prayerTime.difference(now);
    return durationToTime(remains);
  });
}

///*---------------- * [Duration] * ----------------*///
String durationToTime(Duration duration) {
  int hours = duration.inHours - 1;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  String dateFormat = DateFormat('HH:mm:ss').format(
    DateTime(0, 0, 0, hours, minutes, seconds),
  );

  return dateFormat;
}
