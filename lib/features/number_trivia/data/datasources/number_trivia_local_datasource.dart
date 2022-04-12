import 'dart:convert';

import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDatasource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel>? getLastNumberTrivia();

  /// Saves the [NumberTriviaModel] to the cache.
  /// [NumberTriviaModel] is the number trivia which was gotten.
  /// Throws [CacheException] if the cache is full.
  Future<void>? cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = "CACHED_NUMBER_TRIVIA";

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDatasource {
  late final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void>? cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    // TODO: implement cacheNumberTrivia
    return null;
  }

  @override
  Future<NumberTriviaModel>? getLastNumberTrivia() {
    final String jsonString =
        sharedPreferences.getString(CACHED_NUMBER_TRIVIA)!;
    return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
  }
}
