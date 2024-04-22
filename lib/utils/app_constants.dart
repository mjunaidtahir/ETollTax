import 'package:flutter/material.dart';
import 'package:tolls/models/interChange.dart';

class AppConstants {
  AppConstants._();
  static List<Interchange> interchanges = [
    Interchange('Zero point', 0),
    Interchange('NS Interchange', 5),
    Interchange('Ph4 Interchange', 10),
    Interchange('Ferozpur Interchange', 17),
    Interchange('Lake City Interchange', 24),
    Interchange('Raiwand Interchange', 29),
    Interchange('Bahria Interchange', 34),
  ];
}

class ColorName {
  ColorName._();

  static const primaryColor = Color.fromARGB(255, 56, 110, 246);
}
