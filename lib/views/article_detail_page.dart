import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article; // article à afficher (passé depuis la liste)

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Article ${article.id}')), // titre avec l'id
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // aligné à gauche
          children: [
            Text(
              article.title, // titre de l’article
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              article.body, // contenu de l’article
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
