import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_clean_architecture_tdd/article.dart';
import 'package:news_clean_architecture_tdd/article_page.dart';
import 'package:news_clean_architecture_tdd/news_change_notifier.dart';
import 'package:news_clean_architecture_tdd/news_page.dart';
import 'package:news_clean_architecture_tdd/news_services.dart';
import 'package:provider/provider.dart';

class MockNewsService extends Mock implements NewsServices {}

void main() {
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
  });
  final articlesFromService = [
    Article(title: 'test1', content: 'content1'),
    Article(title: 'test2', content: 'content2'),
    Article(title: 'test3', content: 'content3'),
  ];
  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewsService.getArticles()).thenAnswer(
      (_) async => articlesFromService,
    );
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsService),
        child: NewsPage(),
      ),
    );
  }

  testWidgets(
      'tapping on the first article excerpt the article page where the full article content is displayed',
      (WidgetTester tester) async {
    arrangeNewsServiceReturns3Articles();
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    await tester.tap(find.text('content1'));
    await tester.pumpAndSettle();
    expect(find.byType(NewsPage), findsNothing);
    expect(find.byType(ArticlePage), findsOneWidget);
    expect(find.text('test1'), findsOneWidget);
    expect(find.text('content1'), findsOneWidget);
  });
}
