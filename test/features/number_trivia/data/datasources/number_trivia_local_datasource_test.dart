import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';

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
  });
}
