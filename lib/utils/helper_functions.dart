import 'package:flutter/material.dart';

String getNameForAppDropDown(dynamic value, bool? isCustomName) {
  if (value is Enum) {
    return capitalizeFirstWord(value.toString().split('.').last);
  }

  try {
    if (isCustomName != null && isCustomName) {
      return value.getDropDownValue;
    } else {
      return value.name;
    }
  } catch (e) {
    return value.toString();
  }
}

void hideKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String capitalizeFirstWord(String input) {
  return input.isNotEmpty ? input[0].toUpperCase() + input.substring(1) : input;
}

String extractNumericPart(String plate) {
  String numericPart = plate.replaceAll(RegExp(r'[^0-9]'), '');

  if (numericPart.length >= 3) {
    return numericPart.substring(numericPart.length - 3);
  } else {
    return numericPart;
  }
}

bool validateNumberPlate(String plate) {
  RegExp regex = RegExp(r'^[A-Z]{3}-[0-9]{3}$');
  return regex.hasMatch(plate);
}
