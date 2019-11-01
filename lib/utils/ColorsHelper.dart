import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = HexColor("5DADE2");
  static Color googleBackground = HexColor("dd4b39");
  static Color facebookBackground = HexColor("3b5998");
  static Color white = Colors.white;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
