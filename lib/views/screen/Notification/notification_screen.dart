import 'package:flutter/material.dart';
import 'package:radeef/models/notification_model.dart';
import 'package:radeef/views/base/custom_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample notifications with different dates (today, yesterday, earlier)
  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: "Payment confirm",
      body:
          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
      time: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    NotificationModel(
      title: "Payment confirm",
      body:
          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
      time: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    NotificationModel(
      title: "Payment confirm",
      body:
          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
      time: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
    NotificationModel(
      title: "Payment confirm",
      body:
          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
      time: DateTime.now().subtract(const Duration(days: 1, minutes: 45)),
    ),
    NotificationModel(
      title: "Payment confirm",
      body:
          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
      time: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  Map<String, List<NotificationModel>> _grouped = {};

  @override
  void initState() {
    super.initState();
    _groupNotifications();
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isToday(DateTime d) => _isSameDay(d, DateTime.now());

  bool _isYesterday(DateTime d) =>
      _isSameDay(d, DateTime.now().subtract(const Duration(days: 1)));

  void _groupNotifications() {
    // Sort newest first
    _notifications.sort((a, b) => b.time.compareTo(a.time));

    final Map<String, List<NotificationModel>> m = {};
    for (var n in _notifications) {
      String key;
      if (_isToday(n.time)) {
        key = 'Today';
      } else if (_isYesterday(n.time)) {
        key = 'Yesterday';
      } else {
        key = 'Earlier';
      }
      m.putIfAbsent(key, () => []).add(n);
    }
    setState(() => _grouped = m);
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return '${diff.inDays} day${diff.inDays > 1 ? "s" : ""} ago';
  }

  Widget _buildNotificationTile(NotificationModel n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          n.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF012F64),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          n.body,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF676769),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _timeAgo(n.time),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF676769),
          ),
        ),
        const SizedBox(height: 8),
        const Divider(color: Color(0xFFE6E6E6), height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a flat list of widgets (headers + items) so ListView can render sections
    final List<Widget> children = [];
    final order = ['Today', 'Yesterday'];
    for (var key in order) {
      final items = _grouped[key];
      if (items == null || items.isEmpty) continue;

      // Section header
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF012F64),
            ),
          ),
        ),
      );

      // Items in that section
      for (var n in items) {
        children.add(_buildNotificationTile(n));
        // small spacing between items (optional)
        children.add(const SizedBox(height: 10));
      }
    }

    return Scaffold(
      appBar: const CustomAppbar(title: "Notification"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: children,
      ),
    );
  }
}
