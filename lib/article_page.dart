import 'package:flutter/material.dart';
import 'package:news_clean_architecture_tdd/article.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  const ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Text(article.content),
    );
  }
}
