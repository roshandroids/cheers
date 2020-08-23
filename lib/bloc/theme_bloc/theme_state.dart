import 'package:cheers/data/theme/app_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;
  final AppTheme appTheme;

  ThemeState({@required this.themeData, @required this.appTheme});

  @override
  List<Object> get props => [themeData, appTheme];
}
