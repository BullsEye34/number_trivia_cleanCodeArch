import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDataSourceImpl datasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group("get lastNumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cache.json')));
    test(
        "Should return NumberTriviaModel from sharedPreferences when there is one in the cache",
        () async {
      // arrange
      when(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA))
          .thenReturn(fixture('trivia_cache.json'));
      // act
      final result = await datasource.getLastNumberTrivia();
      // assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        "Should throw CacheException from sharedPreferences when there is nothing in the cache",
        () async {
      // arrange
      when(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA))
          .thenReturn(null);
      // act
      final call = datasource.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  /* group("Cache Number Trivia", () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "test");
    test("Should call SharedPreferences to cache the data", () {
      // arrange
      // act
      datasource.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      verify(mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, json.encode(tNumberTriviaModel.toJson())));
    });
  }); */
}
