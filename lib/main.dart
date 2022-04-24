import 'package:flutter/material.dart';
import 'package:news_clean_architecture_tdd/news_change_notifier.dart';
import 'package:news_clean_architecture_tdd/news_page.dart';
import 'package:news_clean_architecture_tdd/news_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsServices()),
        child: NewsPage(),
      ),
    );
  }
}
