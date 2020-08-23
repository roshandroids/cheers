import 'package:cheers/bloc/theme_bloc/theme_bloc.dart';
import 'package:cheers/bloc/theme_bloc/theme_state.dart';
import 'package:cheers/data/theme/app_themes.dart';
import 'package:cheers/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(ThemeState(
          themeData: appThemeData[AppTheme.GreenLight],
          appTheme: AppTheme.GreenLight)),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
      theme: state.themeData,
    );
  }
}
