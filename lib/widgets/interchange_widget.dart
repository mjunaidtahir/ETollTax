import 'package:flutter/material.dart';
import 'package:tolls/models/interChange.dart';

class SelectedInterChangeWidget extends StatefulWidget {
  final List<Interchange> interchanges;
  final Function(Interchange)? onInterchangeSelected;

  const SelectedInterChangeWidget({
    super.key,
    required this.interchanges,
    this.onInterchangeSelected,
  });

  @override
  createState() => _SelectedInterChangeWidgetState();
}

class _SelectedInterChangeWidgetState extends State<SelectedInterChangeWidget> {
  Interchange? _selectedInterchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3),
      child: DropdownButton<Interchange>(
        value: _selectedInterchange,
        underline: const SizedBox(),
        dropdownColor: Colors.white,
        onChanged: (Interchange? newValue) {
          setState(() {
            _selectedInterchange = newValue;
          });
          if (newValue != null && widget.onInterchangeSelected != null) {
            widget.onInterchangeSelected!(newValue);
          }
        },
        items: widget.interchanges.map((interchange) {
          return DropdownMenuItem<Interchange>(
            value: interchange,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  interchange.name,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 30,
          color: Colors.grey,
        ),
        style: const TextStyle(fontSize: 18, color: Colors.grey),
        hint: _selectedInterchange != null
            ? Text(
                _selectedInterchange!.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              )
            : const Text(
                'Select Interchange',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }
}
