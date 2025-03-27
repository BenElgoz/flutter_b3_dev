import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false; // état actuel : false = clair, true = sombre

  bool get isDarkMode => _isDarkMode; // expose l’état actuel

  // retourne le thème à utiliser (light ou dark)
  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // change le thème (inverse) et notifie l'app
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // informe les widgets qu’il faut rebuild
  }
}
