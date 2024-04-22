import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final Function(DateTime dateTime) onDateTimeSelected;

  const DateTimePicker({super.key, required this.onDateTimeSelected});

  @override
  createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? _selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });

        widget.onDateTimeSelected(_selectedDateTime!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          _selectedDateTime != null
              ? '${_selectedDateTime!.year}-${_selectedDateTime!.month}-${_selectedDateTime!.day}  ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}:${_selectedDateTime!.second}'
              : 'Select date and time',
        ),
        trailing: const Icon(Icons.date_range),
        onTap: () => _selectDateTime(context),
      ),
    );
  }
}
