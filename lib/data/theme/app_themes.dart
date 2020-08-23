import 'package:flutter/material.dart';

enum AppTheme {
  GreenLight,
  GreenDark,
}
final appThemeData = {
  AppTheme.GreenLight: ThemeData(
      brightness: Brightness.light, primaryColor: Colors.blueGrey[600]),
  AppTheme.GreenDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[700],
  ),
};
