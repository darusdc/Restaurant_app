import 'package:flutter/material.dart';
import 'package:resto_mana/common/styles.dart';
import 'package:resto_mana/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRecommendationPreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  bool _isDailyRecommendationActive = false;
  bool get isDailyRecommmendationActive => _isDailyRecommendationActive;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyRecommendationPreferences() async {
    _isDailyRecommendationActive =
        await preferencesHelper.isDailyRecommendationActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyRecommendation(bool value) {
    preferencesHelper.setDailyRecommendation(value);

    _getDailyRecommendationPreferences();
  }
}
