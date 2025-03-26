import 'package:flutter/material.dart';
import 'home_page.dart';
import 'contact_page.dart';
import 'second_page.dart';
import 'articles_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Seconde Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
            ),
            ListTile(
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Articles'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArticlesPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Bienvenue sur la page à propos, voici une courte description de l\'application :  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam id lacinia lectus. Vivamus scelerisque rutrum lacus nec lacinia. Fusce felis nisi, maximus vel nisl at, iaculis condimentum elit. In hac habitasse platea dictumst. Fusce tincidunt vitae ipsum vel ultrices. Etiam pellentesque mauris eget risus sodales posuere. Maecenas placerat ullamcorper consectetur. Nulla vel cursus tortor. Aenean commodo feugiat arcu nec commodo. Etiam vehicula vitae sapien eu suscipit. Cras in lacus ligula. Curabitur ipsum ex, vestibulum nec feugiat quis, convallis eu massa. Donec elementum lacus ac elit venenatis imperdiet. Aliquam dapibus dolor ut velit mattis lobortis.',
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/images/came.jpg',
                width: 400,
                height: 400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
