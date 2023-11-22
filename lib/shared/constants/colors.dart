import 'package:flutter/material.dart';

class ColorConstants {
  static Color lightScaffoldBackgroundColor = const Color(0xFFF9F9F9);
  static Color darkScaffoldBackgroundColor = const Color(0xFF000000);
  static Color primaryAppColor = const Color(0xFF1680ee);
  static Color secondaryAppColor = const Color(0xff1680ee);
  static Color secondaryDarkAppColor = const Color(0xff1680ee);
  static Color tipColor = const Color(0xFFB6B6B6);
  static Color lightGray = const Color(0xFFF6F6F6);
  static Color darkGray = const Color(0xFF9F9F9F);
  static Color black = const Color(0xFF000000);
  static Color white = const Color(0xFFFFFFFF);
  static Color blackBg = const Color(0xFF212121);
  static Color orangeText = const Color(0xFFE8501F);
  static Color lightBlueText = const Color(0xFF40C4FF);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex), 'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) + (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
