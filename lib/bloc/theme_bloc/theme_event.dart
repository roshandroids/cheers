import 'package:cheers/data/theme/app_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeEvent extends Equatable {}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({
    @required this.theme,
  });

  @override
  List<Object> get props => [theme];
}
