import 'package:flutter/material.dart'; 
import '../widgets/app_scaffold.dart'; 

class AboutPage extends StatelessWidget {
  const AboutPage({super.key}); // constructeur constant 

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'À propos', 

      body: Center(
        child: Column(
          // empile les éléments verticalement
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0), // marge
              child: Text(
                'Bienvenue sur la page à propos, voici une courte description de l\'application :  Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet ',
                textAlign:
                    TextAlign.justify, // aligne le texte sur les deux bords
              ),
            ),

            const SizedBox(height: 16), 

            Image.asset(
              'assets/images/came.jpg', // path vers image locale
              width: 400, 
              height: 400, 
            ),
          ],
        ),
      ),
    );
  }
}
