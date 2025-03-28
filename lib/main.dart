import 'package:flutter/material.dart'; // lib UI principale de Flutter
import 'package:provider/provider.dart'; // lib de gestion d'état
import 'package:b3_dev/views/home_page.dart'; 
import 'package:b3_dev/controllers/theme_controller.dart'; // contrôleur pour gérer le thème

void main() {
  runApp(
    // point d'entrée de l'app, lance le rendu de l'UI
    ChangeNotifierProvider(
      // injecte un état observable (ici pour le thème)
      // create est appelé 1 seule fois → on instancie le ThemeController
      create: (_) => ThemeController(),
      // toute l'app aura accès à ce contrôleur via Provider
      child: const MyApp(), // widget racine de l'app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // récupère le ThemeController grâce à Provider
    // permet d'accéder à l'état du thème actuel
    final themeController = Provider.of<ThemeController>(context);

    return MaterialApp(
      title:
          'App B3 MDS', // nom de l'app 
      theme: ThemeData(
        // config du thème clair
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(
              255, 9, 9, 216), // couleur principale (générée automatiquement)
          brightness: Brightness.light, // force le theme clair
        ),
        useMaterial3: true, // active Material Design 3, design system Google
      ),
      darkTheme: ThemeData(
        // config du thème sombre
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 9, 9, 216),
          brightness: Brightness.dark, // force le theme sombre
        ),
        useMaterial3: true,
      ),
      themeMode: themeController
          .currentTheme, // applique soit le thème clair soit sombre selon l'état
      debugShowCheckedModeBanner:
          false, // supprime le bandeau "debug" en haut à droite
      home: const HomePage(), // première page affichée au lancement
    );
  }
}
