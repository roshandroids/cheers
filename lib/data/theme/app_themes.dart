import 'package:flutter/material.dart';

enum AppTheme {
  GreenLight,
  GreenDark,
}
final appThemeData = {
  AppTheme.GreenLight:
      ThemeData(brightness: Brightness.light, primaryColor: Colors.green),
  AppTheme.GreenDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
  ),
};
