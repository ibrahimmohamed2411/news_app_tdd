import 'package:flutter/foundation.dart';
import 'package:news_clean_architecture_tdd/article.dart';

import 'news_services.dart';

class NewsChangeNotifier extends ChangeNotifier {
  final NewsServices _newsServices;
  NewsChangeNotifier(this._newsServices);
  List<Article> _articles = [];

  List<Article> get articles => _articles;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getArticles() async {
    _isLoading = true;
    notifyListeners();
    _articles = await _newsServices.getArticles();
    _isLoading = false;
    notifyListeners();
  }
}
