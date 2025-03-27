import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'À propos',
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Bienvenue sur la page à propos, voici une courte description de l\'application :  Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet ',
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/images/came.jpg', // image locale (dans assets/images/)
              width: 400,
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}
