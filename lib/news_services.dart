import 'package:news_clean_architecture_tdd/article.dart';

class NewsServices {
  //simulating a remote database
  final _articles = List.generate(
    10,
    (index) => Article(
      title: 'title $index',
      content: 'this is content $index',
    ),
  );
  Future<List<Article>> getArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return _articles;
  }
}
