import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_clean_architecture_tdd/article.dart';
import 'package:news_clean_architecture_tdd/news_change_notifier.dart';
import 'package:news_clean_architecture_tdd/news_services.dart';

class MockNewsService extends Mock implements NewsServices {}

void main() {
  late NewsChangeNotifier sut;
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });
  test('initial values are correct', () {
    expect(sut.articles, []);
    expect(sut.isLoading, false);
  });
  group('getArticles', () {
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

    test(
      'gets articles using the NewsServices',
      () async {
        arrangeNewsServiceReturns3Articles();
        await sut.getArticles();
        verify(() => mockNewsService.getArticles()).called(1);
      },
    );
    test(
      """indicates loading of data, 
        sets articles to the once from the service,
        indicates that data is not being loaded any more
        """,
      () async {
        arrangeNewsServiceReturns3Articles();
        final future = sut.getArticles();
        expect(sut.isLoading, true);
        await future;
        expect(sut.articles, articlesFromService);
        expect(sut.isLoading, false);
      },
    );
  });
}
