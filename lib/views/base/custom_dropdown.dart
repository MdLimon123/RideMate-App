import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String title;

  const CustomDropdown({
    super.key,
    required this.title,
    required this.options,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  void _sendValue() {
    if (_selectedValue != null && _selectedValue!.isNotEmpty) {
      widget.onChanged(_selectedValue);
    } else {
      widget.onChanged(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12,
      horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFFE6E6E6),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedValue,
        decoration: const InputDecoration.collapsed(hintText: ''),
        hint: Text(
          widget.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        icon: Icon(Icons.keyboard_arrow_down,),
        items: widget.options.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          );
        }).toList(),
        onChanged: (val) {
          setState(() {
            _selectedValue = val;
          });
          _sendValue();
        },
      ),
    );
  }
}