import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final double fontSize;
  final String language;

  const AppSettings({
    required this.notificationsEnabled,
    required this.darkModeEnabled,
    required this.fontSize,
    required this.language,
  });

  AppSettings copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    double? fontSize,
    String? language,
  }) {
    return AppSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      fontSize: fontSize ?? this.fontSize,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props =>
      [notificationsEnabled, darkModeEnabled, fontSize, language];
}
