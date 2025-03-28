import 'package:flutter/material.dart'; // nécessaire pour utiliser ThemeMode et ChangeNotifier

// classe qui gère le thème clair/sombre de l'app
class ThemeController extends ChangeNotifier {
  // ChangeNotifier permet de notifier les widgets qui écoutent (ex: via Provider)

  bool _isDarkMode =
      false; // état interne du thème, false = clair, true = sombre

  // getter public → expose l'état actuel à d'autres widgets
  bool get isDarkMode => _isDarkMode;

  // retourne le type de thème à appliquer, utilisé par MaterialApp (light ou dark)
  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // inverse l'état du thème et notifie tous les widgets
  void toggleTheme() {
    _isDarkMode = !_isDarkMode; // switch de true à false ou inverse
    notifyListeners(); // rebuild des widgets qui utilisent le controller
  }
}
