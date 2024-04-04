import 'package:flutter/material.dart';

class DropDownMenuWidget extends StatefulWidget {
  const DropDownMenuWidget({super.key});

  @override
  State<DropDownMenuWidget> createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  String? _selectedType;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        value: _selectedType,
        hint: Text(
          'Select Type',
          style: TextStyle(color: Colors.grey[600]),
        ),
        items: ['Income', 'Expense']
            .map((type) => DropdownMenuItem(
          value: type,
          child: Text(
            type,
            style: const TextStyle(color: Colors.black),
          ),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedType = value as String?;
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
