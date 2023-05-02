import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
