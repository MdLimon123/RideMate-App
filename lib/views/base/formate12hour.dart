String formatTime12(String dateTime) {
  DateTime dt = DateTime.parse(dateTime);
  String hour = (dt.hour % 12 == 0 ? 12 : dt.hour % 12).toString().padLeft(2, '0');
  String minute = dt.minute.toString().padLeft(2, '0');
  String period = dt.hour >= 12 ? "PM" : "AM";
  return "$hour:$minute $period";
}
