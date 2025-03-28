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
  late Future<List<Article>> futureArticles; // future pour chargement API

  final int _articlesPerPage = 10; // nbr d’articles par page
  int _currentPage = 0; // page courante
  List<Article> _allArticles = []; // tous les articles récupérés

  // fonction qui récupère les articles depuis l'API
  Future<List<Article>> fetchArticles() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body); // parse JSON
      return jsonData
          .map((json) => Article.fromJson(json))
          .toList(); // map en liste d'objets Article
    } else {
      throw Exception('Erreur de chargement des articles');
    }
  }

  @override
  void initState() {
    super.initState();
    futureArticles = fetchArticles(); // appel API au chargement
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

  // retourne la liste des articles à afficher pour la page courante
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
      body: FutureBuilder<List<Article>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // affichage d'un spinner de chargement
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur : ${snapshot.error}'), // erreur API
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun article trouvé.'));
          }

          _allArticles = snapshot.data!;
          final paginatedArticles =
              _getPaginatedArticles(); // filtre les bons articles

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: paginatedArticles.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1), // ligne entre les items
                  itemBuilder: (context, index) {
                    final article = paginatedArticles[index];
                    return ListTile(
                      title: Text(article.title), // affiche le titre
                      onTap: () {
                        // navigation vers la page de détails
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ArticleDetailPage(article: article),
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
          );
        },
      ),
    );
  }
}
