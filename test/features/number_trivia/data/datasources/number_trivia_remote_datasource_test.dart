import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDatasourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDatasourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess(tnumber) {
    when(
      mockHttpClient.get(
        Uri.parse("http://numbersapi.com/$tnumber"),
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
        (realInvocation) async => http.Response(fixture("trivia.json"), 200));
  }

  void setUpMockHttpClientSuccessr() {
    when(
      mockHttpClient.get(
        Uri.parse("http://numbersapi.com/random"),
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
        (realInvocation) async => http.Response(fixture("trivia.json"), 200));
  }

  void setUpMockHttpClientFailure(tnumber) {
    when(
      mockHttpClient.get(
        Uri.parse("http://numbersapi.com/$tnumber"),
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
        (realInvocation) async => http.Response("Something went wrong!", 500));
  }

  void setUpMockHttpClientFailurer() {
    when(
      mockHttpClient.get(
        Uri.parse("http://numbersapi.com/random"),
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
        (realInvocation) async => http.Response("Something went wrong!", 500));
  }

  group("Get Concrete Number Trivia", () {
    final tnumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
        "Should perform GET request on URL with tNumber being enpoint and with application.json header",
        () async {
      // arrange
      setUpMockHttpClientSuccess(tnumber);
      // act
      dataSource.getConcreteNumberTrivia(tnumber);
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse("http://numbersapi.com/$tnumber"),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });
    test("Should return NumberTrivia when response code is 200", () async {
      // arrange
      setUpMockHttpClientSuccess(tnumber);
      // act
      final result = await dataSource.getConcreteNumberTrivia(tnumber);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });
    test("Should throw ServerException when response code is not 200",
        () async {
      // arrange
      setUpMockHttpClientFailure(tnumber);
      // act
      final call = dataSource.getConcreteNumberTrivia;
      // assert
      expect(() => call(tnumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group("Get Random Number Trivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
        "Should perform GET request on URL with tNumber being enpoint and with application.json header",
        () async {
      // arrange
      setUpMockHttpClientSuccessr();
      // act
      dataSource.getRandomNumberTrivia();
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse("http://numbersapi.com/random"),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });
    test("Should return NumberTrivia when response code is 200", () async {
      // arrange
      setUpMockHttpClientSuccessr();
      // act
      final result = await dataSource.getRandomNumberTrivia();
      // assert
      expect(result, equals(tNumberTriviaModel));
    });
    test("Should throw ServerException when response code is not 200",
        () async {
      // arrange
      setUpMockHttpClientFailurer();
      // act
      final call = dataSource.getRandomNumberTrivia;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
