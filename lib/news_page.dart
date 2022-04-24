import 'package:flutter/material.dart';
import 'package:news_clean_architecture_tdd/news_change_notifier.dart';
import 'package:provider/provider.dart';

import 'article_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsChangeNotifier>().getArticles(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Consumer<NewsChangeNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              key: Key('progress-indicator'),
            ));
          }
          return ListView.builder(
            itemBuilder: (_, index) {
              final article = notifier.articles[index];

              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ArticlePage(
                      article: article,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.content),
                ),
              );
            },
            itemCount: notifier.articles.length,
          );
        },
        child: Text('frogjorjgjorojgr'),
      ),
    );
  }
}
