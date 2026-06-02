import 'remaining_time.dart';

/// Converts stored prayer time to today (fixes legacy Hive dates).
DateTime prayerTimeOnToday(DateTime time) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, time.hour, time.minute);
}

/// Next occurrence for countdown (today if not passed, else tomorrow).
DateTime nextOccurrenceOf(DateTime prayerTime) {
  final today = prayerTimeOnToday(prayerTime);
  if (DateTime.now().isBefore(today)) return today;
  return today.add(const Duration(days: 1));
}

class PrayerSlot {
  const PrayerSlot({
    required this.name,
    required this.time,
    required this.imageAsset,
  });

  final String name;
  final DateTime time;
  final String imageAsset;
}

class PrayerScheduleInfo {
  const PrayerScheduleInfo({
    required this.slots,
    required this.currentIndex,
    required this.nextIndex,
    required this.remainingToNext,
    required this.remainingByIndex,
    required this.isPassedByIndex,
  });

  final List<PrayerSlot> slots;
  final int currentIndex;
  final int nextIndex;
  final Duration remainingToNext;
  final List<Duration> remainingByIndex;
  final List<bool> isPassedByIndex;
}

PrayerScheduleInfo computePrayerSchedule(List<PrayerSlot> slots) {
  final now = DateTime.now();
  final remainingByIndex = <Duration>[];
  final isPassedByIndex = <bool>[];

  var currentIndex = 0;
  var nextIndex = 0;
  var nextTime = slots.first.time;

  for (var i = 0; i < slots.length; i++) {
    final prayerTime = slots[i].time;
    final isPassed = !now.isBefore(prayerTime);
    isPassedByIndex.add(isPassed);

    if (isPassed) {
      currentIndex = i;
    }

    if (!isPassed) {
      remainingByIndex.add(prayerTime.difference(now));
    } else {
      remainingByIndex.add(Duration.zero);
    }
  }

  for (var i = 0; i < slots.length; i++) {
    if (!isPassedByIndex[i]) {
      nextIndex = i;
      nextTime = slots[i].time;
      break;
    }
  }

  if (isPassedByIndex.every((passed) => passed)) {
    nextIndex = 0;
    nextTime = slots.first.time.add(const Duration(days: 1));
    remainingByIndex[0] = nextTime.difference(now);
  }

  return PrayerScheduleInfo(
    slots: slots,
    currentIndex: currentIndex,
    nextIndex: nextIndex,
    remainingToNext: nextTime.difference(now),
    remainingByIndex: remainingByIndex,
    isPassedByIndex: isPassedByIndex,
  );
}

Stream<PrayerScheduleInfo> prayerScheduleStream(List<PrayerSlot> slots) async* {
  yield computePrayerSchedule(slots);
  yield* Stream.periodic(
    const Duration(seconds: 1),
    (_) => computePrayerSchedule(slots),
  );
}

String formatRemainingDuration(Duration duration) {
  if (duration.isNegative) return '00:00:00';
  return durationToTime(duration);
}
