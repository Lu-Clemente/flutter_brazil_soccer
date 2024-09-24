import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final Rx<bool> isDarkMode = false.obs;
  Map<String, ThemeMode> themesMode = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  late SharedPreferences prefs;

  static ThemeController get to => Get.find();

  Future loadThemeMode() async {
    prefs = await SharedPreferences.getInstance();
    String themeText = prefs.getString('theme') ?? 'light';
    isDarkMode.value = themeText == 'dark';
    setMode(themeText);
  }

  setMode(String themeText) {
    ThemeMode? themeMode = themesMode[themeText];
    Get.changeThemeMode(themeMode ?? ThemeMode.system);
    prefs.setString('theme', themeText);
  }

  changeTheme() {
    setMode(isDarkMode.value ? 'light' : 'dark');
    isDarkMode.value = !isDarkMode.value;
  }
}
