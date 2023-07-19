import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  Color _themeColor;

  ThemeChanger(this._themeColor);

  getThemeColor() => _themeColor;

  setThemeColor(Color color) async {
    _themeColor = color;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("color", color.value);

    notifyListeners();
  }
}
