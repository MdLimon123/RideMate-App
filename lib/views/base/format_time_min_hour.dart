String formatMinutesToHour(dynamic totalMs) {
  if (totalMs == null) return "0h 0m";

  final totalMinutes = (totalMs / 1000 / 60).floor();
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;

  return "${hours}h ${minutes}m";
}
