import 'package:flutter/material.dart'; 
import 'dart:convert'; // pour jsonDecode
import 'package:http/http.dart' as http; // requêtes HTTP
import '../models/article.dart'; // modèle de données Article
import '../widgets/app_scaffold.dart';
import 'article_detail_page.dart'; // page de détails article

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final int _articlesPerPage = 10; // nbr d’articles par page
  int _currentPage = 0; // page courante
  List<Article> _allArticles = []; // tous les articles récupérés

  @override
  void initState() {
    super.initState();
    _loadArticles(); // appel API au chargement
  }

  // récupère les articles depuis l'API et les stocke dans _allArticles
  Future<void> _loadArticles() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body); // parse JSON
        setState(() {
          _allArticles = jsonData
              .map((json) => Article.fromJson(json))
              .toList(); // map json en objets Article
        });
      }
    } catch (e) {
      debugPrint('Erreur de chargement des articles : $e'); // log si erreur
    }
  }

  // passe à la page suivante si possible
  void _goToNextPage() {
    if ((_currentPage + 1) * _articlesPerPage < _allArticles.length) {
      setState(() {
        _currentPage++;
      });
    }
  }

  // revient à la page précédente
  void _goToPreviousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  // retourne les articles pour la page courante
  List<Article> _getPaginatedArticles() {
    final start = _currentPage * _articlesPerPage;
    final end = (_currentPage + 1) * _articlesPerPage;
    return _allArticles.sublist(
      start,
      end > _allArticles.length ? _allArticles.length : end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Articles',
      body: _allArticles.isEmpty
          ? const Center(
              child: Text('Aucun article à afficher.')) // si la liste est vide
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _getPaginatedArticles().length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1), // ligne entre les items
                    itemBuilder: (context, index) {
                      final article = _getPaginatedArticles()[index];
                      return ListTile(
                        title: Text(article.title), // affiche le titre
                        onTap: () {
                          // navigation vers la page de détails
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ArticleDetailPage(article: article),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const Divider(height: 1), // séparation avec les boutons
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _currentPage > 0 ? _goToPreviousPage : null,
                        child: const Text('Précédent'),
                      ),
                      Text(
                        'Page ${_currentPage + 1} / ${(_allArticles.length / _articlesPerPage).ceil()}', // x / total
                      ),
                      ElevatedButton(
                        onPressed: (_currentPage + 1) * _articlesPerPage <
                                _allArticles.length
                            ? _goToNextPage
                            : null,
                        child: const Text('Suivant'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
