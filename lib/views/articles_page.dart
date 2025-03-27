import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/article.dart'; // modèle article
import '../widgets/app_scaffold.dart'; // scaffold avec menu
import 'article_detail_page.dart'; // page détails article

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

  Future<List<Article>> fetchArticles() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body); // parse json
      return jsonData.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Erreur de chargement des articles');
    }
  }

  @override
  void initState() {
    super.initState();
    futureArticles = fetchArticles(); // appel API au chargement
  }

  void _goToNextPage() {
    if ((_currentPage + 1) * _articlesPerPage < _allArticles.length) {
      setState(() {
        _currentPage++; // page suivante
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--; // page précédente
      });
    }
  }

  List<Article> _getPaginatedArticles() {
    final start = _currentPage * _articlesPerPage;
    final end = (_currentPage + 1) * _articlesPerPage;
    return _allArticles.sublist(
      start,
      end > _allArticles.length ? _allArticles.length : end,
    ); // retourne les articles de la page courante
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
                child: CircularProgressIndicator()); // chargement
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erreur : ${snapshot.error}')); // si erreur
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
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final article = paginatedArticles[index];
                    return ListTile(
                      title: Text(article.title), // affiche titre
                      onTap: () {
                        // va à la page de détails
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
              const Divider(height: 1),
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
                      'Page ${_currentPage + 1} / ${(_allArticles.length / _articlesPerPage).ceil()}',
                    ), // x / total
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
