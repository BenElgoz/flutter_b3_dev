import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart'; // recupere le scaffold pour le drawer

class SecondPage extends StatelessWidget {
  const SecondPage(
      {super.key}); // constructeur constant

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Seconde page', // affiché dans l'appBar
      body: Center(
        child: Text('Bienvenue sur la seconde page'),
      ),
    );
  }
}
