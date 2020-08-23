import 'dart:async';
import 'package:cheers/data/theme/app_themes.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:cheers/bloc/theme_bloc/theme_event.dart';
import 'package:cheers/bloc/theme_bloc/theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeState initialState)
      : super(initialState ??
            ThemeState(
                themeData: appThemeData[AppTheme.GreenLight],
                appTheme: AppTheme.GreenLight));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield ThemeState(
          themeData: appThemeData[event.theme], appTheme: event.theme);
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState(
          themeData: appThemeData[
              EnumToString.fromString(AppTheme.values, json['theme'])],
          appTheme: EnumToString.fromString(AppTheme.values, json['theme']));
    } catch (e) {
      return e;
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    try {
      return {'theme': EnumToString.parse(state.appTheme)};
    } catch (e) {
      return e;
    }
  }
}
