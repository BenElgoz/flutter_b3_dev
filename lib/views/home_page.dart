import 'package:flutter/material.dart'; 
import '../widgets/app_scaffold.dart'; // recupere le scaffold pour le drawer

class HomePage extends StatelessWidget {
  const HomePage({super.key}); // constructeur constant

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Accueil', // affiché dans l'appBar
      body: Center(
        child:
            Text("Bienvenue sur la page d'accueil"),
      ),
    );
  }
}
