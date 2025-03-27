import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/home_page.dart';
import '../views/second_page.dart';
import '../views/about_page.dart';
import '../views/contact_page.dart';
import '../views/articles_page.dart';
import '../controllers/theme_controller.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const AppScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightGreen),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
              },
            ),
            ListTile(
              title: const Text('Seconde Page'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SecondPage()));
              },
            ),
            ListTile(
              title: const Text('À propos'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AboutPage()));
              },
            ),
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ContactPage()));
              },
            ),
            ListTile(
              title: const Text('Articles'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ArticlesPage()));
              },
            ),
            const Divider(),
            Consumer<ThemeController>(
              builder: (context, themeController, _) {
                return SwitchListTile(
                  title: const Text('Mode sombre'),
                  value: themeController.isDarkMode,
                  onChanged: (_) {
                    themeController.toggleTheme();
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
