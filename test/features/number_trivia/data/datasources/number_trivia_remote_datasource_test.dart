import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDatasourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDatasourceImpl(client: mockHttpClient);
  });

  group("Get Concrete Number Trivia", () {
    final tnumber = 1;
    /* test(
        "Should perform GET request on URL with tNumber being enpoint and with application.json header",
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse("http://numbersapi.com/$tnumber"),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
          (realInvocation) async => http.Response(fixture("trivia.json"), 200));
      // act
      dataSource.getConcreteNumberTrivia(tnumber);
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse("http://numbersapi.com/$tnumber"),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    }); */
  });
}
