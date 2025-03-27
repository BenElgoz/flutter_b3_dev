import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Accueil',
      body: Center(child: Text('Bienvenue sur la page d\'accueil')),
    );
  }
}
