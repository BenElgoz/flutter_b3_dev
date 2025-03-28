import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart'; 
import '../views/home_page.dart';
import '../views/second_page.dart';
import '../views/about_page.dart';
import '../views/contact_page.dart';
import '../views/articles_page.dart';
import '../controllers/theme_controller.dart';

// widget réutilisable qui sert de structure commune à toutes les pages
class AppScaffold extends StatelessWidget {
  final String title; // titre affiché dans la barre du haut (appBar)
  final Widget body; // contenu principal de chaque page

  const AppScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(title)), // barre du haut avec le titre de la page

      drawer: Drawer(
        // menu latéral qui s’ouvre à gauche
        child: ListView(
          padding: EdgeInsets.zero, // supprime les marges par défaut
          children: [
            const DrawerHeader(
              // style du header
              decoration:
                  BoxDecoration(color: Colors.lightGreen), // couleur de fond
              child: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white, fontSize: 24), 
              ),
            ),

            // liens vers les autres pages
            // lien vers la page d'accueil
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                // remplace la page actuelle par HomePage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
            ),

            // lien vers la seconde page
            ListTile(
              title: const Text('Seconde Page'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SecondPage()),
                );
              },
            ),

            // lien vers la page "À propos"
            ListTile(
              title: const Text('À propos'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),

            // lien vers la page Contact
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactPage()),
                );
              },
            ),

            // lien vers la page Articles
            ListTile(
              title: const Text('Articles'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ArticlesPage()),
                );
              },
            ),

            const Divider(), // ligne horizontale pour séparer les sections

            // switch pour activer/désactiver le thème sombre
            Consumer<ThemeController>(
              // écoute les changements de thème
              builder: (context, themeController, _) {
                return SwitchListTile(
                  title: const Text('Mode sombre'),
                  value: themeController.isDarkMode, // état actuel
                  onChanged: (_) {
                    themeController.toggleTheme(); // inverse le thème
                  },
                );
              },
            ),
          ],
        ),
      ),

      body: body, // contenu dynamique de chaque page, injecté dans AppScaffold
    );
  }
}
