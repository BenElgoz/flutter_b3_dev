import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Seconde page',
      body: Center(child: Text('Bienvenue sur la seconde page')),
    );
  }
}
