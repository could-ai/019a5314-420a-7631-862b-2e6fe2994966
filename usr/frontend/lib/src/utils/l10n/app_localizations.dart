import 'package:flutter/material.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  String get appTitle => 'PulseX';
  String get forYou => 'For You';
  String get following => 'Following';
  String get login => 'Login';
  String get logout => 'Logout';
  String get settings => 'Settings';
  String get profile => 'Profile';
  String get bookmarks => 'Bookmarks';
  String get comments => 'Comments';
  String get share => 'Share';
  String get like => 'Like';
  String get darkMode => 'Dark Mode';
  String get language => 'Language';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations();
  }
  
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}