String formatTimeFromMs(int totalMs) {
  final totalMinutes = totalMs ~/ 60000; 
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;
  return "${hours}h ${minutes}m";
}

