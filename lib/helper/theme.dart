import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const themeStatus = 'THEMESTATUS';

  setDarkTheme(bool value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getBool(themeStatus) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: isDarkTheme ? const Color(0xFF1f1b24) :const  Color(0xFFf7f7f7),
      accentColor: isDarkTheme ? const Color(0xFFf7f7f7) : const Color(0xFF0D5C63),
      iconTheme: isDarkTheme
          ? const IconThemeData(
              color: Color(0xFFf7f7f7),
            )
          : const IconThemeData(
              color: Color(0xff0D5C63),
            ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
