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

          final articles = snapshot.data!;

          return ListView.separated(
            itemCount: articles.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final article = articles[index];
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
          );
        },
      ),
    );
  }
}
