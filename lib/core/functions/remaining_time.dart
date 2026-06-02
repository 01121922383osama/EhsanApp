import 'dart:async';

Stream<String> remainingTime(DateTime prayerTime) async* {
  yield formatCountdown(prayerTime.difference(DateTime.now()));
  yield* Stream.periodic(const Duration(seconds: 1), (_) {
    return formatCountdown(prayerTime.difference(DateTime.now()));
  });
}

String formatCountdown(Duration duration) {
  if (duration.isNegative) return '00:00:00';

  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  return '${hours.toString().padLeft(2, '0')}:'
      '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}';
}

/// @deprecated Use [formatCountdown] instead.
String durationToTime(Duration duration) => formatCountdown(duration);
