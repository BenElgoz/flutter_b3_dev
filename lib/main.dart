import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:b3_dev/views/home_page.dart';
import 'package:b3_dev/controllers/theme_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return MaterialApp(
      title: 'App B3 MDS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 9, 9, 216),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 9, 9, 216),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeController.currentTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
