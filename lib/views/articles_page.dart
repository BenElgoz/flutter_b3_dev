import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/article.dart';
import '../widgets/app_scaffold.dart';
import 'article_detail_page.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  late Future<List<Article>> futureArticles;

  final int _articlesPerPage = 10;
  int _currentPage = 0;
  List<Article> _allArticles = [];

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Erreur de chargement des articles');
    }
  }

  @override
  void initState() {
    super.initState();
    futureArticles = fetchArticles();
  }

  void _goToNextPage() {
    if ((_currentPage + 1) * _articlesPerPage < _allArticles.length) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun article trouvé.'));
          }

          _allArticles = snapshot.data!;
          final paginatedArticles = _getPaginatedArticles();

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: paginatedArticles.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final article = paginatedArticles[index];
                    return ListTile(
                      title: Text(article.title),
                      onTap: () {
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
                    Text('Page ${_currentPage + 1} / ${(_allArticles.length / _articlesPerPage).ceil()}'),
                    ElevatedButton(
                      onPressed: (_currentPage + 1) * _articlesPerPage < _allArticles.length
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
