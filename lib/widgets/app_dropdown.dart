import 'package:flutter/material.dart';
import 'package:tolls/utils/helper_functions.dart';

class AppDropdownForm<T> extends FormField<T> {
  final List<T> values;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final String labelText;
  final Widget? dropDownIcon;
  final bool? isCustomName;

  AppDropdownForm(
      {super.key,
      required this.values,
      required this.onChanged,
      required this.labelText,
      this.selectedValue,
      this.dropDownIcon,
      super.validator,
      super.onSaved,
      this.isCustomName})
      : super(
            initialValue: selectedValue,
            builder: (state) {
              return Column(
                children: <Widget>[
                  // ignore: deprecated_member_use_from_same_package
                  AppDropdown<T>(
                    values: values,
                    selectedValue: selectedValue,
                    onChanged: (value) {
                      state.didChange(value);
                      onChanged(value);
                    },
                    labelText: labelText,
                    dropDownIcon: dropDownIcon,
                    isCustomName: isCustomName,
                  ),
                  state.hasError
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 10),
                            child: Text(
                              state.errorText ?? '',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12),
                            ),
                          ),
                        )
                      : Container()
                ],
              );
            });
}

@Deprecated("Use AppDropdownForm instead it also provided form validation")
class AppDropdown<T> extends StatefulWidget {
  final List<T> values;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final String labelText;
  final Widget? dropDownIcon;
  final bool? isCustomName;

  const AppDropdown(
      {super.key,
      required this.values,
      required this.onChanged,
      required this.labelText,
      this.selectedValue,
      this.dropDownIcon,
      this.isCustomName});

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

// ignore: deprecated_member_use_from_same_package
class _AppDropdownState<T> extends State<AppDropdown<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: DropdownButton<T>(
        underline: const SizedBox(),
        value: _selectedValue,
        onChanged: (T? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedValue = newValue;
              widget.onChanged(newValue);
            });
          }
        },
        items: widget.values.map((value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Row(
              children: [
                widget.dropDownIcon ?? const SizedBox(),
                const SizedBox(width: 10),
                Text(
                  getNameForAppDropDown(
                      value, widget.isCustomName), // Use the helper function
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
        hint: Row(
          children: [
            if (widget.dropDownIcon != null) ...[
              widget.dropDownIcon!,
              const SizedBox(width: 5),
            ],
            Expanded(
              child: Text(
                widget.labelText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
