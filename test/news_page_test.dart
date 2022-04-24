import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_clean_architecture_tdd/article.dart';
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

  void arrangeNewsServiceReturns3ArticlesAfter2SecondWait() {
    when(() => mockNewsService.getArticles()).thenAnswer(
      (_) async {
        await Future.delayed(Duration(seconds: 2));
        return articlesFromService;
      },
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
    'title is displayed',
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3Articles();
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('News'), findsOneWidget);
    },
  );
  testWidgets('loading indicator is displayed while waiting for articles',
      (WidgetTester tester) async {
    arrangeNewsServiceReturns3ArticlesAfter2SecondWait();
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(
      const Duration(microseconds: 500),
    ); //force the widget to rebuild
    expect(find.byKey(Key('progress-indicator')), findsOneWidget);
    await tester.pumpAndSettle();
  });
  testWidgets('articles are displayed', (WidgetTester tester) async {
    arrangeNewsServiceReturns3Articles();
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    for (final article in articlesFromService) {
      expect(find.text(article.title), findsOneWidget);
      expect(find.text(article.content), findsOneWidget);
    }
  });
}
